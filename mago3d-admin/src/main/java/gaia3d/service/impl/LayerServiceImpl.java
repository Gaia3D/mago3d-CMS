package gaia3d.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.ShapeFileExt;
import gaia3d.domain.layer.Layer;
import gaia3d.domain.layer.LayerFileInfo;
import gaia3d.domain.policy.GeoPolicy;
import gaia3d.geospatial.LayerStyleParser;
import gaia3d.geospatial.Ogr2OgrExecute;
import gaia3d.persistence.LayerFileInfoMapper;
import gaia3d.persistence.LayerMapper;
import gaia3d.security.Crypt;
import gaia3d.service.GeoPolicyService;
import gaia3d.service.LayerService;
import lombok.extern.slf4j.Slf4j;

/**
 * 여기서는 Geoserver Rest API 결과를 가지고 파싱 하기 때문에 RestTemplate을 커스트마이징하면 안됨
 * @author Cheon JeongDae
 *
 */
@Slf4j
@Service
public class LayerServiceImpl implements LayerService {

	@Value("${spring.datasource.url}")
	private String url;
	@Value("${spring.datasource.username}")
	private String username;
	@Value("${spring.datasource.password}")
	private String password;

    @Autowired
    private GeoPolicyService geoPolicyService;

    @Autowired
    private PropertiesConfig propertiesConfig;

    @Autowired
    private LayerMapper layerMapper;
    @Autowired
    private LayerFileInfoMapper layerFileInfoMapper;

    /**
	 * Layer 총 건수
	 * @param layer
	 * @return
	 */
    @Transactional(readOnly=true)
	public Long getLayerTotalCount(Layer layer) {
    	return layerMapper.getLayerTotalCount(layer);
    }
    
    /**
    * layer 목록
    * @return
    */
    @Transactional(readOnly=true)
    public List<Layer> getListLayer(Layer layer) {
        return layerMapper.getListLayer(layer);
    }
    
    /**
     * geoserver layer 목록 조회 
     */
    @Transactional(readOnly=true)
    public String getListGeoserverLayer(GeoPolicy geoPolicy) {
    	String geoserverLayerJson = null;
    	try {
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders headers = new HttpHeaders();
			// 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
			List<MediaType> acceptList = new ArrayList<>();
			acceptList.add(MediaType.ALL);
			headers.setAccept(acceptList);
			// 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
			headers.setContentType(MediaType.TEXT_XML);
			// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding 
			headers.add("Authorization", "Basic " + Base64.getEncoder().
					encodeToString((geoPolicy.getGeoserverUser() + ":" + geoPolicy.getGeoserverPassword()).getBytes()));
			
			List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
			//Add the String Message converter
			messageConverters.add(new StringHttpMessageConverter());
			//Add the message converters to the restTemplate
			restTemplate.setMessageConverters(messageConverters);
		    
			HttpEntity<String> entity = new HttpEntity<>(headers);
			
			String url = geoPolicy.getGeoserverDataUrl() + "/rest/workspaces/" + geoPolicy.getGeoserverDataWorkspace()+ "/layers";
			ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			log.info("-------- statusCode = {}, body = {}", response.getStatusCodeValue(), response.getBody());
			geoserverLayerJson = response.getBody().toString();
		
    	} catch(RestClientException e) {
    		log.info("@@@ RestClientException. message = {}", e.getMessage());
    	} catch(RuntimeException e) {
    		log.info("@@@ RuntimeException. message = {}", e.getMessage());
		} catch(Exception e) {
			log.info("@@@ Exception. message = {}", e.getMessage());
		}
    	
    	return geoserverLayerJson;
    }

    /**
    * layer 정보 취득
    * @param layerId
    * @return
    */
    @Transactional(readOnly=true)
    public Layer getLayer(Integer layerId) {
        return layerMapper.getLayer(layerId);
    }
    
    @Transactional(readOnly=true)
    public Boolean isLayerKeyDuplication(String layerKey) {
    	return layerMapper.isLayerKeyDuplication(layerKey);
    }

    /**
    * 레이어 테이블의 컬럼 타입이 어떤 geometry 타입인지를 구함
    * @param layerKey
    * @return
    */
    @Transactional(readOnly=true)
    public String getGeometryType(String layerKey) {
        return layerMapper.getGeometryType(layerKey);
    }

    @Transactional(readOnly = true)
    public String getLayerColumn(String layerKey) {
    	return layerMapper.getLayerColumn(layerKey);
    }

    /**
    * 레이어 등록
    * @param layer
    * @return
    */
    @Transactional
    public Map<String, Object> insertLayer(Layer layer, List<LayerFileInfo> layerFileInfoList) {
    	Map<String, Object> layerFileInfoGroupMap = new HashMap<>();

        // layer 정보 수정
        layerMapper.insertLayer(layer);

        // shape 파일이 있을 경우
        if(!layerFileInfoList.isEmpty()) {
            String shapeFileName = null;
            String shapeEncoding = null;
            Integer layerId = layer.getLayerId();
            String userId = layer.getUserId();

            Integer layerFileInfoGroupId = 0;
            List<Integer> layerFileInfoGroupIdList = new ArrayList<>();
            for(LayerFileInfo layerFileInfo : layerFileInfoList) {
                layerFileInfo.setLayerId(layerId);
                layerFileInfo.setUserId(userId);
                layerFileInfo.setEnableYn("Y");

                layerFileInfoMapper.insertLayerFileInfoMapper(layerFileInfo);
                layerFileInfoGroupIdList.add(layerFileInfo.getLayerFileInfoId());

                if(LayerFileInfo.SHAPE_EXTENSION.equals(layerFileInfo.getFileExt().toLowerCase())) {
                    layerFileInfoGroupId = layerFileInfo.getLayerFileInfoId();
                    shapeFileName = layerFileInfo.getFilePath() + layerFileInfo.getFileRealName();
                    shapeEncoding = layerFileInfo.getShapeEncoding();
                }
            }
            log.info("---- shapeFileName = {}", shapeFileName);

            Integer fileVersion = layerFileInfoMapper.getMaxFileVersion(layerId);
            if(fileVersion == null) fileVersion = 0;
            fileVersion = fileVersion + 1;
            layerFileInfoGroupMap.put("fileVersion", fileVersion);
            layerFileInfoGroupMap.put("shapeFileName", shapeFileName);
            layerFileInfoGroupMap.put("shapeEncoding", shapeEncoding);
            layerFileInfoGroupMap.put("layerFileInfoGroupId", layerFileInfoGroupId);
            layerFileInfoGroupMap.put("layerFileInfoGroupIdList", layerFileInfoGroupIdList);
            layerFileInfoGroupMap.put("layerId", layerId);
            log.info("+++ layerFileInfoGroupMap = {}", layerFileInfoGroupMap);
            layerFileInfoMapper.updateLayerFileInfoGroup(layerFileInfoGroupMap);
        }

        return layerFileInfoGroupMap;
    }

    /**
    * shape 파일을 이용한 layer 정보 수정
    * @param layer
    * @param isLayerFileInfoExist
    * @param layerFileInfoList
    * @return
    * @throws Exception
    */
    @Transactional
    public Map<String, Object> updateLayer(Layer layer, boolean isLayerFileInfoExist, List<LayerFileInfo> layerFileInfoList) {

        Map<String, Object> layerFileInfoGroupMap = new HashMap<>();

        // layer 정보 수정
        layerMapper.updateLayer(layer);

        // shape 파일이 있을 경우
        if(!layerFileInfoList.isEmpty()) {
            String shapeFileName = null;
            String shapeEncoding = null;
            Integer layerId = layer.getLayerId();
            String userId = layer.getUserId();
            String tableName = layer.getLayerKey();

            if(isLayerFileInfoExist) {
                // 모든 layer_file_info 의 shape 상태를 비활성화로 update 함
                layerFileInfoMapper.updateLayerFileInfoAllDisabledByLayerId(layerId);
                // 이 레이어의 지난 데이터를 비 활성화 상태로 update 함
                layerFileInfoMapper.updateShapePreDataDisable(tableName);
            }

            Integer layerFileInfoGroupId = 0;
            List<Integer> layerFileInfoGroupIdList = new ArrayList<>();
            for(LayerFileInfo layerFileInfo : layerFileInfoList) {
                layerFileInfo.setLayerId(layerId);
                layerFileInfo.setUserId(userId);
                layerFileInfo.setEnableYn("Y");

                layerFileInfoMapper.insertLayerFileInfoMapper(layerFileInfo);
                layerFileInfoGroupIdList.add(layerFileInfo.getLayerFileInfoId());

                if(LayerFileInfo.SHAPE_EXTENSION.equals(layerFileInfo.getFileExt().toLowerCase())) {
                    layerFileInfoGroupId = layerFileInfo.getLayerFileInfoId();
                    shapeFileName = layerFileInfo.getFilePath() + layerFileInfo.getFileRealName();
                    shapeEncoding = layerFileInfo.getShapeEncoding();
                }
            }
            log.info("---- shapeFileName = {}", shapeFileName);

            Integer fileVersion = layerFileInfoMapper.getMaxFileVersion(layerId);
            if(fileVersion == null) fileVersion = 0;
            fileVersion = fileVersion + 1;
            layerFileInfoGroupMap.put("fileVersion", fileVersion);
            layerFileInfoGroupMap.put("shapeFileName", shapeFileName);
            layerFileInfoGroupMap.put("shapeEncoding", shapeEncoding);
            layerFileInfoGroupMap.put("layerFileInfoGroupId", layerFileInfoGroupId);
            layerFileInfoGroupMap.put("layerFileInfoGroupIdList", layerFileInfoGroupIdList);
            log.info("+++ layerFileInfoGroupMap = {}", layerFileInfoGroupMap);
            layerFileInfoMapper.updateLayerFileInfoGroup(layerFileInfoGroupMap);
        }

        return layerFileInfoGroupMap;
    }

    /**
    * Ogr2Ogr 실행
    * @param layer
    * @param isLayerFileInfoExist
    * @param shapeFileName
    * @param shapeEncoding
    * @throws Exception
    */
    @Transactional
    public void insertOgr2Ogr(Layer layer, boolean isLayerFileInfoExist, String shapeFileName, String shapeEncoding) throws Exception {
        //String osType = propertiesConfig.getOsType().toUpperCase();
        String gdalCommandPath =  propertiesConfig.getGdalCommandPath();
        String ogr2ogrPort = propertiesConfig.getOgr2ogrPort();
        String ogr2ogrHost = propertiesConfig.getOgr2ogrHost();
        String dbName = Crypt.decrypt(url);
        dbName = dbName.substring(dbName.lastIndexOf("/") + 1);
        String driver = "PG:host="+ogr2ogrHost + " port=" + ogr2ogrPort+ " dbname=" + dbName + " user=" + Crypt.decrypt(username) + " password=" + Crypt.decrypt(password);
        //Layer dbLayer = layerMapper.getLayer(layer.getLayerId());

        String updateOption = null;
        if(isLayerFileInfoExist) {
            // update 실행
            updateOption = "update";
        } else {
            // insert 실행
            updateOption = "insert";
        }

        GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
        String layerSourceCoordinate = layer.getCoordinate();
        String layerTargetCoordinate = geoPolicy.getLayerTargetCoordinate();
		//ShapeFileParser shapeFileParser = new ShapeFileParser();
		//shapeFileParser.parse(shapeFileName);
        //String enviromentPath = propertiesConfig.getOgr2ogrEnviromentPath();

        Ogr2OgrExecute ogr2OgrExecute = new Ogr2OgrExecute(gdalCommandPath, driver, shapeFileName, shapeEncoding, layer.getLayerKey(), updateOption, layerSourceCoordinate, layerTargetCoordinate);
        ogr2OgrExecute.insert();
    }
    
    /**
     * shp파일 정보를 db 정보 기준으로 export
     */
    @Transactional
    public void exportOgr2Ogr(LayerFileInfo layerFileInfo, Layer layer) throws Exception {
        String tableName = layer.getLayerKey();
        Integer versionId = layerFileInfo.getVersionId();
        String shpEncoding = layerFileInfo.getShapeEncoding();
        String exportPath = layerFileInfo.getFilePath() + layerFileInfo.getFileRealName()+ "." + ShapeFileExt.SHP.getValue();

        //String osType = propertiesConfig.getOsType().toUpperCase();
        String gdalCommandPath =  propertiesConfig.getGdalCommandPath();
        String ogr2ogrPort = propertiesConfig.getOgr2ogrPort();
        String ogr2ogrHost = propertiesConfig.getOgr2ogrHost();
        String dbName = Crypt.decrypt(url);
        dbName = dbName.substring(dbName.lastIndexOf("/") + 1);
        String driver = "PG:host="+ogr2ogrHost + " port=" + ogr2ogrPort+ " dbname=" + dbName + " user=" + Crypt.decrypt(username) + " password=" + Crypt.decrypt(password);
        GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
        String layerSourceCoordinate = geoPolicy.getLayerSourceCoordinate();
        String layerTargetCoordinate = geoPolicy.getLayerTargetCoordinate();
        String layerColumn = getLayerColumn(tableName);
        String sql = "SELECT "+ layerColumn + ", null::text AS enable_yn, null::int AS version_id FROM "+tableName+" WHERE version_id="+versionId;

        Ogr2OgrExecute ogr2OgrExecute = new Ogr2OgrExecute(gdalCommandPath, driver, shpEncoding, exportPath, sql, layerSourceCoordinate, layerTargetCoordinate);
        ogr2OgrExecute.export();
    }

    /**
    * layer 를 이 shape 파일로 활성화
    * @param layerId
    * @param layerFileInfoGroupId
    * @return
    */
    @Transactional
    public int updateLayerByLayerFileInfoId(Integer layerId, Integer layerFileInfoGroupId, Integer layerFileInfoId) {
        int result = 0;
        // layer 정보 수정
        Layer layer = layerMapper.getLayer(layerId);
        String tableName = layer.getLayerKey();

        // 모든 layer_file_info 의 shape 상태를 비활성화로 update 함
        layerFileInfoMapper.updateLayerFileInfoAllDisabledByLayerId(layerId);
        // shape table 모든 데이터를 비활성화 함
        layerFileInfoMapper.updateShapePreDataDisable(tableName);

        LayerFileInfo layerFileInfo = new LayerFileInfo();
        layerFileInfo.setLayerId(layerId);
        layerFileInfo.setLayerFileInfoGroupId(layerFileInfoGroupId);
        layerFileInfo.setEnableYn("Y");
        layerFileInfoMapper.updateLayerFileInfoByGroupId(layerFileInfo);

        Integer fileVersion = layerFileInfoMapper.getLayerShapeFileVersion(layerFileInfoId);
        Map<String, String> orgMap = new HashMap<>();
        orgMap.put("fileVersion", fileVersion.toString());
        orgMap.put("tableName", tableName);
        orgMap.put("enableYn", "Y");
        result = layerFileInfoMapper.updateOgr2OgrStatus(orgMap);

        return result;
    }
    
	/**
	 * 레이어 롤백 처리
	 * 
	 * @param layer
	 * @param isLayerFileInfoExist
	 * @param layerFileInfo
	 * @param deleteLayerFileInfoGroupId
	 */
	@Transactional
	public void rollbackLayer(Layer layer, boolean isLayerFileInfoExist, LayerFileInfo layerFileInfo,
			Integer deleteLayerFileInfoGroupId) {
		layerMapper.updateLayer(layer);
		if (isLayerFileInfoExist) {
			layerFileInfoMapper.deleteLayerFileInfoByGroupId(deleteLayerFileInfoGroupId);

			// 모든 layer_file_info 의 shape 상태를 비활성화로 update 함
			layerFileInfoMapper.updateLayerFileInfoAllDisabledByLayerId(layer.getLayerId());
			// 이 레이어의 지난 데이터를 비 활성화 상태로 update 함
			layerFileInfoMapper.updateShapePreDataDisable(layer.getLayerKey());

			// 이전 레이어 이력을 활성화
			layerFileInfoMapper.updateLayerFileInfoByGroupId(layerFileInfo);
			// 이전 shape 데이터를 활성화
			Map<String, String> orgMap = new HashMap<>();
			orgMap.put("fileVersion", layerFileInfo.getVersionId().toString());
			orgMap.put("tableName", layer.getLayerKey());
			orgMap.put("enableYn", "Y");
			layerFileInfoMapper.updateOgr2OgrStatus(orgMap);
		} else {
			layerFileInfoMapper.deleteLayerFileInfo(layer.getLayerId());
			// TODO shape 파일에도 이력이 있음 지워 줘야 하나?
		}
	}
	
	/**
	 * 레이어 삭제
	 * 
	 * @param layerId
	 * @return
	 */
	@Transactional
	public int deleteLayer(Integer layerId) {
		// geoserver layer 삭제
		GeoPolicy geopolicy = geoPolicyService.getGeoPolicy();
		Layer layer = layerMapper.getLayer(layerId);
		// 업로드 파일 삭제
		List<String> layerFilePath = layerFileInfoMapper.getListLayerFilePath(layerId);
		layerFilePath.stream()
					.forEach( path -> {
						File directory = new File(path);
				        if(directory.exists()) { directory.delete();}
					});
		if(layerFilePath.size() > 0) {
			// geoserver layer 삭제
			deleteGeoserverLayer(geopolicy, layer.getLayerKey());
			// geoserver style 삭제
			deleteGeoserverLayerStyle(geopolicy, layer.getLayerKey());
			// layer_file_info 히스토리 삭제
			layerFileInfoMapper.deleteLayerFileInfo(layerId);
			// 공간정보 테이블 삭제
			String layerExists = layerMapper.isLayerExists(layer.getLayerKey());
			if(layerExists != null) {
				layerMapper.deleteLayerTable(layer.getLayerKey());
			}
		}
		// 레이어 메타정보 삭제 
		return layerMapper.deleteLayer(layerId);
	}

	
/****************geoserver rest api 관련  서비스 *********************************************/	
	
    /**
    * layer 가 등록 되어 있지 않은 경우 rest api 를 이용해서 layer를 등록
    * @throws Exception
    */
    @Transactional
    public void registerLayer(GeoPolicy geoPolicy, String layerKey) throws Exception {
        HttpStatus httpStatus = getLayerStatus(geoPolicy, layerKey);
        if(HttpStatus.INTERNAL_SERVER_ERROR == httpStatus) {
            throw new Exception();
        }

        if(HttpStatus.OK == httpStatus) {
            log.info("layerKey = {} 는 이미 존재하는 layer 입니다.", layerKey);
            // 이미 등록 되어 있음
        } else if(HttpStatus.NOT_FOUND == httpStatus) {
            // 신규 등록
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.TEXT_XML);
            // geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
            headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( (geoPolicy.getGeoserverUser() + ":" + geoPolicy.getGeoserverPassword()).getBytes()));

            // body
            String xmlString = "<?xml version=\"1.0\" encoding=\"utf-8\"?><featureType><name>" + layerKey + "</name></featureType>";

            List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
            //Add the String Message converter
            messageConverters.add(new StringHttpMessageConverter());
            //Add the message converters to the restTemplate

            RestTemplate restTemplate = new RestTemplate();
            restTemplate.setMessageConverters(messageConverters);

            HttpEntity<String> entity = new HttpEntity<>(xmlString, headers);
            String url = geoPolicy.getGeoserverDataUrl() + "/rest/workspaces/"
                    + geoPolicy.getGeoserverDataWorkspace() + "/datastores/" + geoPolicy.getGeoserverDataStore() + "/featuretypes?recalculate=nativebbox,latlonbbox";

            ResponseEntity<?> response = restTemplate.postForEntity(url, entity, String.class);

            //ResponseEntity<APIResult> responseEntity = restTemplate.exchange(url, HttpMethod.POST, request, APIResult.class);
            log.info("----------------------- response = {}", response);
//			log.info("----------------------- body = {}", response.getBody());

            // shape 파일이 없는 layer를 등록 하려고 하면 400 Bad Request가 나옴
        } else {
            throw new Exception("http status code = " + httpStatus.toString());
        }
    }
    
    /**
     * 레이어의 스타일 정보를 수정
     * @param layer
     * @return
     */
     @Transactional
     public int updateLayerStyle(Layer layer) throws Exception {
    	 log.info("==============update layer style");
         GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
         Layer dbLayer = layerMapper.getLayer(layer.getLayerId());
         layer.setLayerKey(dbLayer.getLayerKey());
         String xmlData = getLayerStyleFileData(layer.getLayerId());
         HttpStatus httpStatus = getLayerStatus(geoPolicy, layer.getLayerKey());
         if(HttpStatus.NOT_FOUND == httpStatus) {
             return httpStatus.value();
         }
         httpStatus = getLayerStyle(geoPolicy, layer.getLayerKey());
         if(HttpStatus.INTERNAL_SERVER_ERROR.equals(httpStatus)) {
             throw new Exception();
         }

         if(HttpStatus.OK.equals(httpStatus)) {
             log.info("styleName = {} 는 이미 존재하는 layerStyle 입니다.", layer.getLayerKey());
             // 이미 등록 되어 있음, update
         } else if(HttpStatus.NOT_FOUND.equals(httpStatus)) {
             // 신규 등록
             insertGeoserverLayerStyle(geoPolicy, layer);
             // 기본 지오메트리타입 스타일 get
             xmlData = getLayerDefaultStyleFileData(layer.getGeometryType());
         } else {
             throw new Exception("http status code = " + httpStatus.toString());
         }

         LayerStyleParser layerStyleParser = new LayerStyleParser(
                 layer.getGeometryType(), layer.getLayerFillColor(), layer.getLayerAlphaStyle(), layer.getLayerLineColor(), layer.getLayerLineStyle(), xmlData.trim());
         layerStyleParser.updateLayerStyle();
         layer.setStyleFileContent(layerStyleParser.getStyleData());

         updateGeoserverLayerStyle(geoPolicy, layer);
         reloadGeoserverLayerStyle(geoPolicy, layer);
         
         return 0;

     }
     
	/**
	 * 레이어가 존재 하는지를 검사
	 * 
	 * @param geopolicy
	 * @param layerKey
	 * @return
	 * @throws Exception
	 */
	private HttpStatus getLayerStatus(GeoPolicy geopolicy, String layerKey) {
		HttpStatus httpStatus = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.TEXT_XML);
			// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
			headers.add("Authorization", "Basic " + Base64.getEncoder()
					.encodeToString((geopolicy.getGeoserverUser() + ":" + geopolicy.getGeoserverPassword()).getBytes()));

			List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
			// Add the String Message converter
			messageConverters.add(new StringHttpMessageConverter());
			// Add the message converters to the restTemplate
			RestTemplate restTemplate = new RestTemplate();
			restTemplate.setMessageConverters(messageConverters);

			HttpEntity<String> entity = new HttpEntity<>(headers);
			String url = geopolicy.getGeoserverDataUrl() + "/rest/workspaces/" + geopolicy.getGeoserverDataWorkspace()
					+ "/datastores/" + geopolicy.getGeoserverDataStore() + "/featuretypes/" + layerKey;
			log.info("-------- url = {}", url);
			ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			httpStatus = response.getStatusCode();
			log.info("-------- layerKey = {}, statusCode = {}, body = {}", layerKey, response.getStatusCodeValue(),
					response.getBody());
		} catch (RestClientException e) {
			log.info("-------- RestClientException message = {}", e.getMessage());
			String message = e.getMessage();
			if (message.indexOf("404") >= 0) {
				httpStatus = HttpStatus.NOT_FOUND;
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}
		} catch (Exception e) {
			log.info("-------- exception message = {}", e.getMessage());
			String message = e.getMessage();
			if (message.indexOf("404") >= 0) {
				httpStatus = HttpStatus.NOT_FOUND;
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}
		}

		return httpStatus;
	}
     
	/**
	 * 레이어 스타일 정보 등록
	 * 
	 * @param geopolicy
	 * @param layer
	 * @throws Exception
	 */
	private void insertGeoserverLayerStyle(GeoPolicy geopolicy, Layer layer) throws Exception {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		// 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
		List<MediaType> acceptList = new ArrayList<>();
		acceptList.add(MediaType.ALL);
		headers.setAccept(acceptList);
		// 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
		headers.setContentType(MediaType.TEXT_XML);
		// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
		headers.add("Authorization", "Basic " + Base64.getEncoder()
				.encodeToString((geopolicy.getGeoserverUser() + ":" + geopolicy.getGeoserverPassword()).getBytes()));

		List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
		// Add the String Message converter
		messageConverters.add(new StringHttpMessageConverter());
		// Add the message converters to the restTemplate
		restTemplate.setMessageConverters(messageConverters);

		HttpEntity<String> entity = new HttpEntity<>(getEmptyStyleFile(layer.getLayerKey()), headers);

		String url = geopolicy.getGeoserverDataUrl() + "/rest/workspaces/" + geopolicy.getGeoserverDataWorkspace()
				+ "/styles";
		ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
		log.info("-------- insertGeoserverLayerStyle statusCode = {}, body = {}", response.getStatusCodeValue(),
				response.getBody());
	}
	
	/**
	 * 기존에 존재하는 스타일의 정보를 취득 
	 * @param geopolicy
	 * @param layerKey
	 * @return
	 */
    private HttpStatus getLayerStyle(GeoPolicy geopolicy, String layerKey) {
        HttpStatus httpStatus = null;
        try {
            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders headers = new HttpHeaders();
            // 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
            List<MediaType> acceptList = new ArrayList<>();
            acceptList.add(MediaType.APPLICATION_JSON);
            headers.setAccept(acceptList);

            // 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
            headers.setContentType(MediaType.TEXT_XML);
            // geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
            headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( (geopolicy.getGeoserverUser() + ":" + geopolicy.getGeoserverPassword()).getBytes()));

            List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
            //Add the String Message converter
            messageConverters.add(new StringHttpMessageConverter());
            //Add the message converters to the restTemplate
            restTemplate.setMessageConverters(messageConverters);

            HttpEntity<String> entity = new HttpEntity<>(headers);
            String url = geopolicy.getGeoserverDataUrl() + "/rest/workspaces/" + geopolicy.getGeoserverDataWorkspace() + "/styles/" + layerKey;

            ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            httpStatus = response.getStatusCode();
            log.info("-------- getLayerStyle styleName = {}, statusCode = {}, body = {}", layerKey, response.getStatusCodeValue(), response.getBody());
        } catch (RestClientException e) {
			log.info("-------- RestClientException message = {}", e.getMessage());
			String message = e.getMessage();
			if (message.indexOf("404") >= 0) {
				httpStatus = HttpStatus.NOT_FOUND;
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
			}
        } catch(Exception e) {
            log.info("-------- exception message = {}", e.getMessage());
            String message = e.getMessage();
            if(message.indexOf("404") >= 0) {
                httpStatus = HttpStatus.NOT_FOUND;
            } else {
                httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
            }
        }

        log.info("########### getLayerStyle end");
        return httpStatus;
    }
    
	/**
	 * 기본 레이어 스타일 파일을 취득
	 * 
	 * @param geometryType
	 * @return
	 */
	private String getLayerDefaultStyleFileData(String geometryType) {
		String layerStyleFileData = null;
		HttpStatus httpStatus = null;
		try {
			GeoPolicy geopolicy = geoPolicyService.getGeoPolicy();

			RestTemplate restTemplate = new RestTemplate();

			HttpHeaders headers = new HttpHeaders();
			// 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
			List<MediaType> acceptList = new ArrayList<>();
			acceptList.add(MediaType.TEXT_XML);
			headers.setAccept(acceptList);

			// 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
			headers.setContentType(MediaType.TEXT_XML);
			// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
			headers.add("Authorization", "Basic " + Base64.getEncoder()
					.encodeToString((geopolicy.getGeoserverUser() + ":" + geopolicy.getGeoserverPassword()).getBytes()));

			List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
			// Add the String Message converter
			messageConverters.add(new StringHttpMessageConverter());
			// Add the message converters to the restTemplate
			restTemplate.setMessageConverters(messageConverters);

			HttpEntity<String> entity = new HttpEntity<>(headers);

			String url = geopolicy.getGeoserverDataUrl() + "/rest/styles/" + geometryType.toLowerCase() + ".sld";
			ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			httpStatus = response.getStatusCode();
			layerStyleFileData = response.getBody().toString();
			log.info("-------- getLayerStyle geometry type = {}, statusCode = {}, body = {}", geometryType,
					response.getStatusCodeValue(), response.getBody());
		} catch (RestClientException e) {
			log.info("-------- RestClientException message = {}", e.getMessage());
			String message = e.getMessage();
			if (message.indexOf("404") >= 0) {
				httpStatus = HttpStatus.NOT_FOUND;
				layerStyleFileData = null;
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				layerStyleFileData = null;
			}
		} catch (Exception e) {
			log.info("-------- exception message = {}", e.getMessage());
			String message = e.getMessage();
			if (message.indexOf("404") >= 0) {
				httpStatus = HttpStatus.NOT_FOUND;
				layerStyleFileData = null;
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				layerStyleFileData = null;
			}
		}

		return layerStyleFileData;
	}
     
	/**
	 * 레이어 스타일 파일을 취득
	 * 
	 * @param layerId
	 * @return
	 */
	private String getLayerStyleFileData(Integer layerId) {
		String layerStyleFileData = null;
		HttpStatus httpStatus = null;
		try {
			GeoPolicy geopolicy = geoPolicyService.getGeoPolicy();
			Layer layer = layerMapper.getLayer(layerId);

			RestTemplate restTemplate = new RestTemplate();

			HttpHeaders headers = new HttpHeaders();
			// 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
			List<MediaType> acceptList = new ArrayList<>();
			acceptList.add(MediaType.TEXT_XML);
			headers.setAccept(acceptList);

			// 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
			headers.setContentType(MediaType.TEXT_XML);
			// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
			headers.add("Authorization", "Basic " + Base64.getEncoder()
					.encodeToString((geopolicy.getGeoserverUser() + ":" + geopolicy.getGeoserverPassword()).getBytes()));

			List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
			// Add the String Message converter
			messageConverters.add(new StringHttpMessageConverter());
			// Add the message converters to the restTemplate
			restTemplate.setMessageConverters(messageConverters);

			HttpEntity<String> entity = new HttpEntity<>(headers);

			String url = geopolicy.getGeoserverDataUrl() + "/rest/workspaces/" + geopolicy.getGeoserverDataWorkspace()
					+ "/styles/" + layer.getLayerKey() + ".sld";
			ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			httpStatus = response.getStatusCode();
			layerStyleFileData = response.getBody().toString();
			log.info("-------- getLayerStyle styleName = {}, statusCode = {}, body = {}", layer.getLayerKey(),
					response.getStatusCodeValue(), response.getBody());
		} catch (RestClientException e) {
			log.info("-------- RestClientException message = {}", e.getMessage());
			String message = e.getMessage();
			if (message.indexOf("404") >= 0) {
				httpStatus = HttpStatus.NOT_FOUND;
				layerStyleFileData = null;
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				layerStyleFileData = null;
			}
		} catch (Exception e) {
			log.info("-------- exception message = {}", e.getMessage());
			String message = e.getMessage();
			if (message.indexOf("404") >= 0) {
				httpStatus = HttpStatus.NOT_FOUND;
				layerStyleFileData = null;
			} else {
				httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
				layerStyleFileData = null;
			}
		}

		return layerStyleFileData;
	}
      
	/**
	 * 레이어 스타일 정보를 수정
	 * 
	 * @param geopolicy
	 * @param layer
	 * @throws Exception
	 */
	private void updateGeoserverLayerStyle(GeoPolicy geopolicy, Layer layer) throws Exception {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		// 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
		List<MediaType> acceptList = new ArrayList<>();
		acceptList.add(MediaType.APPLICATION_JSON);
		headers.setAccept(acceptList);
		// 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
		headers.setContentType(new MediaType("application", "vnd.ogc.sld+xml"));
		// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
		headers.add("Authorization", "Basic " + Base64.getEncoder()
				.encodeToString((geopolicy.getGeoserverUser() + ":" + geopolicy.getGeoserverPassword()).getBytes()));

		List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
		// Add the String Message converter
		messageConverters.add(new StringHttpMessageConverter());
		// Add the message converters to the restTemplate
		restTemplate.setMessageConverters(messageConverters);

		HttpEntity<String> entity = new HttpEntity<>(layer.getStyleFileContent().trim(), headers);

		String url = geopolicy.getGeoserverDataUrl() + "/rest/workspaces/" + geopolicy.getGeoserverDataWorkspace()
				+ "/styles/" + layer.getLayerKey();
		log.info("-------- url = {}, xmlData = {}", url, layer.getStyleFileContent().trim());
		ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.PUT, entity, String.class);
		log.info("-------- updateGeoserverLayerStyle statusCode = {}, body = {}", response.getStatusCodeValue(),
				response.getBody());
	}
       
	/**
	 * geoserver에 존재하는 레이어를 삭제
	 * 
	 * @param geopolicy
	 * @param layerKey
	 * @return
	 * @throws Exception
	 */
	private HttpStatus deleteGeoserverLayer(GeoPolicy geopolicy, String layerKey) {
		HttpStatus httpStatus = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.TEXT_XML);
			// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
			headers.add("Authorization", "Basic " + Base64.getEncoder()
					.encodeToString((geopolicy.getGeoserverUser() + ":" + geopolicy.getGeoserverPassword()).getBytes()));

			List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
			// Add the String Message converter
			messageConverters.add(new StringHttpMessageConverter());
			// Add the message converters to the restTemplate
			RestTemplate restTemplate = new RestTemplate();
			restTemplate.setMessageConverters(messageConverters);

			HttpEntity<String> entity = new HttpEntity<>(headers);

			String url = geopolicy.getGeoserverDataUrl() + "/rest/workspaces/" + geopolicy.getGeoserverDataWorkspace()
					+ "/datastores/" + geopolicy.getGeoserverDataStore() + "/featuretypes/" + layerKey + "?recurse=true";
			log.info("-------- url = {}", url);
			ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.DELETE, entity, String.class);
			httpStatus = response.getStatusCode();
			log.info("-------- geoserver layer delete. layerKey = {}, statusCode = {}, body = {}", layerKey,
					response.getStatusCodeValue(), response.getBody());
		} catch (RestClientException e) {
			log.info("-------- RestClientException message = {}", e.getMessage());
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		} catch (Exception e) {
			log.info("-------- exception message = {}", e.getMessage());
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		}

		return httpStatus;
	}
	
	private void deleteGeoserverLayerStyle(GeoPolicy policy, String layerKey) {
		HttpStatus httpStatus = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.TEXT_XML);
			// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
			headers.add("Authorization", "Basic " + Base64.getEncoder()
					.encodeToString((policy.getGeoserverUser() + ":" + policy.getGeoserverPassword()).getBytes()));

			List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
			// Add the String Message converter
			messageConverters.add(new StringHttpMessageConverter());
			// Add the message converters to the restTemplate
			RestTemplate restTemplate = new RestTemplate();
			restTemplate.setMessageConverters(messageConverters);

			HttpEntity<String> entity = new HttpEntity<>(headers);

			String url = policy.getGeoserverDataUrl() + "/rest/workspaces/" + policy.getGeoserverDataWorkspace() + "/styles/" + layerKey + "?recurse=true";
			log.info("-------- url = {}", url);
			ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.DELETE, entity, String.class);
			httpStatus = response.getStatusCode();
		} catch (RestClientException e) {
			log.info("-------- RestClientException message = {}", e.getMessage());
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		} catch (Exception e) {
			log.info("-------- exception message = {}", e.getMessage());
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		}
	}
       
	private void reloadGeoserverLayerStyle(GeoPolicy geopolicy, Layer layer) throws Exception {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		// 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
		List<MediaType> acceptList = new ArrayList<>();
		acceptList.add(MediaType.APPLICATION_JSON);
		headers.setAccept(acceptList);
		// 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
		headers.setContentType(MediaType.TEXT_XML);
		// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
		headers.add("Authorization", "Basic " + Base64.getEncoder()
				.encodeToString((geopolicy.getGeoserverUser() + ":" + geopolicy.getGeoserverPassword()).getBytes()));

		List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
		// Add the String Message converter
		messageConverters.add(new StringHttpMessageConverter());
		// Add the message converters to the restTemplate
		restTemplate.setMessageConverters(messageConverters);

		HttpEntity<String> entity = new HttpEntity<>(
				getReloadLayerStyle(geopolicy.getGeoserverDataWorkspace(), layer.getLayerKey()), headers);
		String url = geopolicy.getGeoserverDataUrl() + "/rest/layers/" + geopolicy.getGeoserverDataWorkspace() + ":"
				+ layer.getLayerKey();
		ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.PUT, entity, String.class);
		log.info("-------- statusCode = {}, body = {}", response.getStatusCodeValue(), response.getBody());
	}

	/**
	 * geoserver rest api 가 빈 파일을 등록하고 update 해야 함
	 * 
	 * @param layerKey
	 * @return
	 */
	private String getEmptyStyleFile(String layerKey) {
		
        String fileName = layerKey + ".sld";
        StringBuilder builder = new StringBuilder()
        		.append("<style>")
                .append("<name>" + layerKey + "</name>")
                .append("<filename>" + fileName + "</filename>")
                .append("</style>");
        return builder.toString();
	}
      
	private String getReloadLayerStyle(String workspace, String layerKey) {
		
        StringBuilder builder = new StringBuilder()
                .append("<layer>")
                .append("<enabled>true</enabled>")
                .append("<defaultStyle>")
                .append("<name>" + layerKey + "</name>")
                .append("<workspace>" + workspace + "</workspace>")
                .append("</defaultStyle>")
                .append("</layer>");
        return builder.toString();
	}
}
