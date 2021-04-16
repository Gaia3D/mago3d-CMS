package gaia3d.controller.rest;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import gaia3d.config.PropertiesConfig;
import gaia3d.controller.AuthorizationController;
import gaia3d.domain.Key;
import gaia3d.domain.ShapeFileExt;
import gaia3d.domain.layer.Layer;
import gaia3d.domain.layer.LayerFileInfo;
import gaia3d.domain.layer.LayerType;
import gaia3d.domain.policy.GeoPolicy;
import gaia3d.domain.policy.Policy;
import gaia3d.domain.user.UserSession;
import gaia3d.geospatial.ShapeFileParser;
import gaia3d.service.GeoPolicyService;
import gaia3d.service.LayerFileInfoService;
import gaia3d.service.LayerService;
import gaia3d.service.PolicyService;
import gaia3d.support.LogMessageSupport;
import gaia3d.support.ZipSupport;
import gaia3d.utils.WebUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/layer")
public class LayerRestController implements AuthorizationController {

	@Autowired
	private GeoPolicyService geoPolicyService;
	@Autowired
    private LayerService layerService;
    @Autowired
    private LayerFileInfoService layerFileInfoService;
    @Autowired
    private PolicyService policyService;
    @Autowired
    private PropertiesConfig propertiesConfig;

    // 파일 copy 시 버퍼 사이즈
    public static final int BUFFER_SIZE = 8192;

    @GetMapping(value = "/list-geoserver")
	public Map<String, Object> geoserverLayerList(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
		String geoserverLayerJson = layerService.getListGeoserverLayer(geoPolicy);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		result.put("geoserverLayerJson", geoserverLayerJson);
		return result;
	}
    /**
     * geoserver 레이어를 서비스 레이어로 등록 
     * @param request
     * @param layer
     * @return
     */
    @PostMapping(value ="/insert-geoserver")
    public Map<String, Object> insertGeoserverLayer(HttpServletRequest request, Layer layer) throws Exception {
    	Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		Boolean layerKeyDuplication = layerService.isLayerKeyDuplication(layer.getLayerKey());
		if(layerKeyDuplication) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "layer.key.duplication");
			return result;
		}
		UserSession userSession = (UserSession) request.getSession().getAttribute(Key.USER_SESSION.name());
		String userId = userSession.getUserId();
		layer.setUserId(userId);
		List<LayerFileInfo> layerFileInfoList = new ArrayList<>();
		layerService.insertLayer(layer, layerFileInfoList);
		String layerType = layer.getLayerType();
		// 레이어 타입이 vector일 경우에만 스타일 설정 
		if(LayerType.VECTOR == LayerType.valueOf(layerType.toUpperCase())) {
			layerService.updateLayerStyle(layer);
		}
	
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

	/**
	 * shape 파일 변환 TODO dropzone 이 파일 갯수만큼 form data를 전송해 버려서 command 패턴을(Layer
	 * layer) 사용할 수 없음 dropzone 이 예외 처리가 이상해서 BAD_REQUEST 를 던지지 않고 OK 를 넣짐
	 *
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@PostMapping(value = "/insert")
	public Map<String, Object> insert(MultipartHttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;
		boolean isLayerFileInfoExist = false;
		Map<String, Object> updateLayerMap = new HashMap<>();

		try {
			errorCode = layerValidate(request);
			if (!StringUtils.isEmpty(errorCode)) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
				return result;
			}
			Boolean layerKeyDuplication = layerService.isLayerKeyDuplication(request.getParameter("layerKey"));
			if(layerKeyDuplication) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "layer.key.duplication");
				return result;
			}

			UserSession userSession = (UserSession) request.getSession().getAttribute(Key.USER_SESSION.name());
			String userId = userSession.getUserId();

			List<LayerFileInfo> layerFileInfoList = new ArrayList<>();
			Map<String, MultipartFile> fileMap = request.getFileMap();

			Policy policy = policyService.getPolicy();
			GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
			String shapeEncoding = replaceInvalidValue(request.getParameter("shapeEncoding"));
			String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
			// 레이어 객체 생성
			Layer layer = Layer.builder()
							.layerGroupId(Integer.valueOf(request.getParameter("layerGroupId")))
							.sharing(request.getParameter("sharing"))
							.layerName(request.getParameter("layerName"))
							.layerKey(request.getParameter("layerKey"))
							.ogcWebServices(request.getParameter("ogcWebServices"))
							.layerType(request.getParameter("layerType"))
							.layerInsertType(request.getParameter("layerInsertType"))
							.geometryType(request.getParameter("geometryType"))
							.layerLineColor(request.getParameter("layerLineColor"))
							.layerLineStyle(Float.valueOf(request.getParameter("layerLineStyle")))
							.layerFillColor(request.getParameter("layerFillColor"))
							.layerAlphaStyle(Float.valueOf(request.getParameter("layerAlphaStyle")))
							.defaultDisplay(Boolean.valueOf(request.getParameter("defaultDisplay")))
							.available(Boolean.valueOf(request.getParameter("available")))
							.labelDisplay(Boolean.valueOf(request.getParameter("labelDisplay")))
							.coordinate(request.getParameter("coordinate"))
							.description(request.getParameter("description"))
							.zIndex(Integer.valueOf(request.getParameter("zIndex")))
							.cacheAvailable(Boolean.valueOf(request.getParameter("cacheAvailable")))
							.viewOrder(Integer.valueOf(request.getParameter("viewOrder")))
							.userId(userId)
							.build();
			log.info("@@ layer = {}", layer);

			// layer 변경 횟수가 많지 않아서 년 단위로 관리할 예정
			String makedDirectory = propertiesConfig.getLayerUploadDir();
			createDirectory(makedDirectory);
			makedDirectory = makedDirectory + today.substring(0, 4) + File.separator;
			createDirectory(makedDirectory);
			log.info("@@@@@@@ = {}", makedDirectory);

			String groupFileName = request.getParameter("layerKey") + "_" + today;

			// 한건이면서 zip 의 경우
			boolean isZipFile = false;
			int fileCount = fileMap.values().size();
			log.info("********************************************* fileCount = {}", fileCount);
			if (fileCount == 1) {
				for (MultipartFile multipartFile : fileMap.values()) {
					String[] divideNames = multipartFile.getOriginalFilename().split("\\.");
					String fileExtension = divideNames[divideNames.length - 1];
					if (LayerFileInfo.ZIP_EXTENSION.equalsIgnoreCase(fileExtension)) {
						isZipFile = true;
						// zip 파일
						Map<String, Object> uploadMap = unzip(policy, groupFileName, multipartFile, shapeEncoding, makedDirectory);
						layerFileInfoList = (List<LayerFileInfo>) uploadMap.get("layerFileInfoList");
					}
				}
			}

			if (!isZipFile) {
				for (MultipartFile multipartFile : fileMap.values()) {
					log.info("@@@@@@@@@@@@@@@ name = {}, original_name = {}", multipartFile.getName(), multipartFile.getOriginalFilename());

					String saveFileName = groupFileName;
					LayerFileInfo layerFileInfo = new LayerFileInfo();

					// 파일 기본 validation 체크
					errorCode = fileValidate(policy, multipartFile);
					if (!StringUtils.isEmpty(errorCode)) {
						result.put("statusCode", HttpStatus.BAD_REQUEST.value());
						result.put("errorCode", errorCode);
						return result;
					}

					String originalName = multipartFile.getOriginalFilename();
					String[] divideFileName = originalName.split("\\.");
					String extension = null;
					if (divideFileName.length != 0) {
						extension = divideFileName[divideFileName.length - 1];
						if (LayerFileInfo.ZIP_EXTENSION.equalsIgnoreCase(extension)) {
							log.info("@@@@@@@@@@@@ upload.file.type.invalid");
							result.put("statusCode", HttpStatus.BAD_REQUEST.value());
							result.put("errorCode", "upload.file.type.invalid");
							return result;
						}
						saveFileName = saveFileName + "." + extension;
					}

					long size = 0L;
					try (	InputStream inputStream = multipartFile.getInputStream();
							OutputStream outputStream = new FileOutputStream(makedDirectory + saveFileName)) {

						int bytesRead = 0;
						byte[] buffer = new byte[BUFFER_SIZE];
						while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
							size += bytesRead;
							outputStream.write(buffer, 0, bytesRead);
						}
						layerFileInfo.setFileExt(extension);
						layerFileInfo.setFileName(multipartFile.getOriginalFilename());
						layerFileInfo.setFileRealName(saveFileName);
						layerFileInfo.setFilePath(makedDirectory);
						layerFileInfo.setFileSize(String.valueOf(size));
						layerFileInfo.setShapeEncoding(shapeEncoding);
					} catch(IOException e) {
						log.info("@@@@@@@@@@@@ IOException. message = {}", e.getMessage());
						layerFileInfo.setErrorMessage(e.getMessage());
					} catch(Exception e) {
						log.info("@@@@@@@@@@@@ Exception. message = {}", e.getMessage());
						layerFileInfo.setErrorMessage(e.getMessage());
					}

					layerFileInfoList.add(layerFileInfo);
				}
			}

			// shape 필수 파일 확인
			errorCode = shapeFileValidate(layerFileInfoList);
			if(!StringUtils.isEmpty(errorCode)) {
				log.info("@@@@@@@@@@@@ errorCode = {}", errorCode);
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", errorCode);
	            return result;
			}

			// shp 파일 필수 필드 확인
			ShapeFileParser shapeFileParser = new ShapeFileParser(makedDirectory + groupFileName + "." + ShapeFileExt.SHP.getValue());
			if(!shapeFileParser.fieldValidate()) {
				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
				result.put("errorCode", "upload.shpfile.requried");
				return result;
			}
			// 3. 레이어 기본 정보 및 레이어 이력 정보 등록
			updateLayerMap = layerService.insertLayer(layer, layerFileInfoList);
			if (!layerFileInfoList.isEmpty()) {
				// 4. org2ogr 실행
				layerService.insertOgr2Ogr(layer, isLayerFileInfoExist, (String) updateLayerMap.get("shapeFileName"),
						(String) updateLayerMap.get("shapeEncoding"));

				// org2ogr 로 등록한 데이터의 version을 갱신
				Map<String, String> orgMap = new HashMap<>();
				orgMap.put("fileVersion", ((Integer) updateLayerMap.get("fileVersion")).toString());
				orgMap.put("tableName", layer.getLayerKey());
				orgMap.put("enableYn", "Y");
				// 5. shape 파일 테이블의 현재 데이터의 활성화 하고 날짜를 업데이트
				layerFileInfoService.updateOgr2OgrDataFileVersion(orgMap);
				// 6. geoserver에 신규 등록일 경우 등록, 아닐경우 통과
				layerService.registerLayer(geoPolicy, layer.getLayerKey());
				String layerType = layer.getLayerType();
				// 레이어 타입이 vector일 경우에만 스타일 설정 
				if(LayerType.VECTOR == LayerType.valueOf(layerType.toUpperCase())) {
					layerService.updateLayerStyle(layer);
				}
			}

			statusCode = HttpStatus.OK.value();
		} catch(DataAccessException e) {
			// ogr2ogr2 실행하다가 에러날경우 이미 들어간 레이어, 레이러 파일정보 삭제 
			Integer layerId = (Integer) updateLayerMap.get("layerId");
			Integer layerFileInfoGroupId = (Integer) updateLayerMap.get("layerFileInfoGroupId");
			layerService.deleteLayer(layerId);
			layerFileInfoService.deleteLayerFileInfoByGroupId(layerFileInfoGroupId);
			
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			// ogr2ogr2 실행하다가 에러날경우 이미 들어간 레이어, 레이러 파일정보 삭제 
			Integer layerId = (Integer) updateLayerMap.get("layerId");
			Integer layerFileInfoGroupId = (Integer) updateLayerMap.get("layerFileInfoGroupId");
			layerService.deleteLayer(layerId);
			layerFileInfoService.deleteLayerFileInfoByGroupId(layerFileInfoGroupId);
			
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			LogMessageSupport.printMessage(e, "@@ runtime.exception. message = {}", message);
//			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			// ogr2ogr2 실행하다가 에러날경우 이미 들어간 레이어, 레이러 파일정보 삭제 
			Integer layerId = (Integer) updateLayerMap.get("layerId");
			Integer layerFileInfoGroupId = (Integer) updateLayerMap.get("layerFileInfoGroupId");
			layerService.deleteLayer(layerId);
			layerFileInfoService.deleteLayerFileInfoByGroupId(layerFileInfoGroupId);
			
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			LogMessageSupport.printMessage(e, "@@ exception. message = {}", message);
//			log.info("@@ exception. message = {}", message);
		}

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	@PostMapping(value = "/update-geoserver")
	public Map<String, Object> updateGeoserverLayer(HttpServletRequest request, Layer layer) throws Exception {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession) request.getSession().getAttribute(Key.USER_SESSION.name());
		String userId = userSession.getUserId();
		layer.setUserId(userId);
		List<LayerFileInfo> layerFileInfoList = new ArrayList<>();
		layerService.updateLayer(layer, false, layerFileInfoList);
		String layerType = layer.getLayerType();
		// 레이어 타입이 vector일 경우에만 스타일 설정 
		if(LayerType.VECTOR == LayerType.valueOf(layerType.toUpperCase())) {
			layerService.updateLayerStyle(layer);
		}
	
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
    /**
    * shape 파일 변환
    * TODO dropzone 이 파일 갯수만큼 form data를 전송해 버려서 command 패턴을(Layer layer) 사용할 수 없음
    * dropzone 이 예외 처리가 이상해서 BAD_REQUEST 를 던지지 않고 OK 를 넣짐
	 * @param request
	 * @param layerId
    * @return
    */
    @SuppressWarnings("unchecked")
	@PostMapping(value = "/update/{layerId:[0-9]+}")
    public Map<String, Object> update(MultipartHttpServletRequest request, @PathVariable("layerId") Integer layerId) {

    	Map<String, Object> result = new HashMap<>();
		int statusCode = 0;
		String errorCode = null;
		String message = null;

        boolean isRollback = false;
        Layer rollbackLayer = new Layer();
        boolean isLayerFileInfoExist = false;
        LayerFileInfo rollbackLayerFileInfo = null;
        Integer deleteLayerFileInfoGroupId = null;

        try {
            errorCode = layerValidate(request);
            if(!StringUtils.isEmpty(errorCode)) {
            	result.put("statusCode", HttpStatus.BAD_REQUEST.value());
                result.put("errorCode", errorCode);
                return result;
            }

            UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
            String userId = userSession.getUserId();

            List<LayerFileInfo> layerFileInfoList = new ArrayList<>();
            Map<String, MultipartFile> fileMap = request.getFileMap();

            Policy policy = policyService.getPolicy();
			GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
			String shapeEncoding = replaceInvalidValue(request.getParameter("shapeEncoding"));
			String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));

            // layer 변경 횟수가 많지 않아서 년 단위로 관리할 예정
            String makedDirectory = propertiesConfig.getLayerUploadDir();
            createDirectory(makedDirectory);
            makedDirectory = makedDirectory + today.substring(0,4) + File.separator;
            createDirectory(makedDirectory);
            log.info("@@@@@@@ = {}", makedDirectory);

            Layer layer = layerService.getLayer(layerId);
            BeanUtils.copyProperties(layer, rollbackLayer);
            // layer 파일의 경우 한 세트가 같은 이름에 확장자만 달라야 한다.
            String groupFileName = layer.getLayerKey() + "_" + today;

            // 한건이면서 zip 의 경우
            boolean isZipFile = false;
            int fileCount = fileMap.values().size();
            log.info("********************************************* fileCount = {}", fileCount);
            if(fileCount == 1) {
                for (MultipartFile multipartFile : fileMap.values()) {
                    String[] divideNames = multipartFile.getOriginalFilename().split("\\.");
                    String fileExtension = divideNames[divideNames.length - 1];
                    if(LayerFileInfo.ZIP_EXTENSION.equalsIgnoreCase(fileExtension)) {
                        isZipFile = true;
                        // zip 파일
                        Map<String, Object> uploadMap = unzip(policy, groupFileName, multipartFile, shapeEncoding, makedDirectory);
                        layerFileInfoList = (List<LayerFileInfo>)uploadMap.get("layerFileInfoList");
                    }
                }
            }

            if(!isZipFile) {
                for (MultipartFile multipartFile : fileMap.values()) {
                    log.info("@@@@@@@@@@@@@@@ name = {}, original_name = {}", multipartFile.getName(), multipartFile.getOriginalFilename());

                    String saveFileName = groupFileName;
                    LayerFileInfo layerFileInfo = new LayerFileInfo();

                    // 파일 기본 validation 체크
                    errorCode = fileValidate(policy, multipartFile);
                    if(!StringUtils.isEmpty(errorCode)) {
                    	result.put("statusCode", HttpStatus.BAD_REQUEST.value());
                        result.put("errorCode", errorCode);
                        return result;
                    }

                    String originalName = multipartFile.getOriginalFilename();
                    String[] divideFileName = originalName.split("\\.");
                    String extension = null;
                    if(divideFileName.length != 0) {
                        extension = divideFileName[divideFileName.length - 1];
                        if(LayerFileInfo.ZIP_EXTENSION.equalsIgnoreCase(extension)) {
                            log.info("@@@@@@@@@@@@ upload.file.type.invalid");
                            result.put("statusCode", HttpStatus.BAD_REQUEST.value());
                            result.put("errorCode", "upload.file.type.invalid");
                            return result;
                        }
                        saveFileName = saveFileName + "." + extension;
                    }

                    long size = 0L;
                    try (	InputStream inputStream = multipartFile.getInputStream();
                            OutputStream outputStream = new FileOutputStream(makedDirectory + saveFileName)) {

                    	int bytesRead = 0;
						byte[] buffer = new byte[BUFFER_SIZE];
						while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
							size += bytesRead;
							outputStream.write(buffer, 0, bytesRead);
						}
                        layerFileInfo.setFileExt(extension);
                        layerFileInfo.setFileName(multipartFile.getOriginalFilename());
                        layerFileInfo.setFileRealName(saveFileName);
                        layerFileInfo.setFilePath(makedDirectory);
                        layerFileInfo.setFileSize(String.valueOf(size));
                        layerFileInfo.setShapeEncoding(shapeEncoding);

                    } catch(IOException e) {
						log.info("@@@@@@@@@@@@ IOException. message = {}", e.getMessage());
						layerFileInfo.setErrorMessage(e.getMessage());
                    } catch(Exception e) {
                    	log.info("@@@@@@@@@@@@ Exception. message = {}", e.getMessage());
                        layerFileInfo.setErrorMessage(e.getMessage());
                    }

					layerFileInfoList.add(layerFileInfo);
                }
            }

            // shape 필수 파일 확인
 			errorCode = shapeFileValidate(layerFileInfoList);
 			if(!StringUtils.isEmpty(errorCode)) {
 				log.info("@@@@@@@@@@@@ errorCode = {}", errorCode);
 				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
 				result.put("errorCode", errorCode);
 	            return result;
 			}

            // shp 파일 필수 필드 확인
 			ShapeFileParser shapeFileParser = new ShapeFileParser(makedDirectory + groupFileName + "." + ShapeFileExt.SHP.getValue());
 			if(!shapeFileParser.fieldValidate()) {
 				result.put("statusCode", HttpStatus.BAD_REQUEST.value());
 				result.put("errorCode", "upload.shpfile.requried");
 				return result;
 			}

            layer.setLayerId(layerId);
            layer.setLayerGroupId(Integer.valueOf(request.getParameter("layerGroupId")));
            layer.setSharing(request.getParameter("sharing"));
            layer.setLayerName(request.getParameter("layerName"));
			layer.setLayerKey(request.getParameter("layerKey"));
			layer.setOgcWebServices(request.getParameter("ogcWebServices"));
			layer.setLayerType(request.getParameter("layerType"));
			layer.setGeometryType(request.getParameter("geometryType"));
			layer.setLayerLineColor(request.getParameter("layerLineColor"));
			layer.setLayerLineStyle(Float.valueOf(request.getParameter("layerLineStyle")));
			layer.setLayerFillColor(request.getParameter("layerFillColor"));
			layer.setLayerAlphaStyle(Float.valueOf(request.getParameter("layerAlphaStyle")));
			layer.setDefaultDisplay(Boolean.valueOf(request.getParameter("defaultDisplay")));
			layer.setAvailable(Boolean.valueOf(request.getParameter("available")));
			layer.setLabelDisplay(Boolean.valueOf(request.getParameter("labelDisplay")));
			layer.setCoordinate(request.getParameter("coordinate"));
			layer.setDescription(request.getParameter("description"));
			layer.setZIndex(Integer.valueOf(request.getParameter("zIndex")));
			layer.setCacheAvailable(Boolean.valueOf(request.getParameter("cacheAvailable")));
			layer.setViewOrder(Integer.valueOf(request.getParameter("viewOrder")));
			layer.setUserId(userId);

            // TODO geoserver 에서 postgresql 로 hang 걸리는게 있어서 우선 이럻게 처리 함. 추후 개선 예정
            // 여기서 부터 문제가 생기는 것은 rollback 처리를 합니다.
            // 1. 레이어 이력 파일이 존재하는 검사
            isLayerFileInfoExist = layerFileInfoService.isLayerFileInfoExist(layer.getLayerId());
            if(isLayerFileInfoExist) {
                // 2. 존재하면 백업을 위해 조회
                rollbackLayerFileInfo = layerFileInfoService.getEnableLayerFileInfo(layerId);
            }
            log.info("----- isLayerFileInfoExist = {}", isLayerFileInfoExist);
            // 3. 레이어 기본 정보 및 레이어 이력 정보 등록
            Map<String, Object> updateLayerMap = layerService.updateLayer(layer, isLayerFileInfoExist, layerFileInfoList);
            if(!layerFileInfoList.isEmpty()) {
                isRollback = true;

                deleteLayerFileInfoGroupId = (Integer)updateLayerMap.get("layerFileInfoGroupId");
                // 4. org2ogr 실행
                layerService.insertOgr2Ogr(layer, isLayerFileInfoExist, (String)updateLayerMap.get("shapeFileName"), (String)updateLayerMap.get("shapeEncoding"));

                // org2ogr 로 등록한 데이터의 version을 갱신
                Map<String, String> orgMap = new HashMap<>();
                orgMap.put("fileVersion", ((Integer)updateLayerMap.get("fileVersion")).toString());
                orgMap.put("tableName", layer.getLayerKey());
                orgMap.put("enableYn", "Y");
                // 5. shape 파일 테이블의 현재 데이터의 활성화 하고 날짜를 업데이트
                layerFileInfoService.updateOgr2OgrDataFileVersion(orgMap);
                // 6. geoserver에 신규 등록일 경우 등록, 아닐경우 통과
                layerService.registerLayer(geoPolicy, layer.getLayerKey());
            }
            String layerType = layer.getLayerType();
			// 레이어 타입이 vector일 경우에만 스타일 설정 
			if(LayerType.VECTOR == LayerType.valueOf(layerType.toUpperCase())) {
				layerService.updateLayerStyle(layer);
			}

            statusCode = HttpStatus.OK.value();
        } catch(DataAccessException e) {
        	if(isRollback) {
                // rollback 처리
                layerService.rollbackLayer(rollbackLayer, isLayerFileInfoExist, rollbackLayerFileInfo, deleteLayerFileInfoGroupId);
            }
        	
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "db.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ db.exception. message = {}", message);
		} catch(RuntimeException e) {
			if(isRollback) {
                // rollback 처리
                layerService.rollbackLayer(rollbackLayer, isLayerFileInfoExist, rollbackLayerFileInfo, deleteLayerFileInfoGroupId);
            }
			
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "runtime.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ runtime.exception. message = {}", message);
		} catch(Exception e) {
			if(isRollback) {
                // rollback 처리
                layerService.rollbackLayer(rollbackLayer, isLayerFileInfoExist, rollbackLayerFileInfo, deleteLayerFileInfoGroupId);
            }
			
			statusCode = HttpStatus.INTERNAL_SERVER_ERROR.value();
			errorCode = "unknown.exception";
			message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
			log.info("@@ exception. message = {}", message);
        }

        result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

	/**
	 * 레이어 삭제 삭제
	 * @param layerId
	 * @return
	 */
	@DeleteMapping(value = "/delete/{layerId:[0-9]+}")
	public Map<String, Object> delete(@PathVariable Integer layerId) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		layerService.deleteLayer(layerId);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

    /**
    * shape 파일 목록
	 * @param request
	 * @param layerId
    * @return
    */
    @GetMapping(value = "/{layerId:[0-9]+}/layer-fileinfos")
    public Map<String, Object> listLayerFileInfo(HttpServletRequest request, @PathVariable Integer layerId) {

    	Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		List<LayerFileInfo> layerFileInfoList = layerFileInfoService.getListLayerFileInfo(layerId);
        log.info("layerFileInfoList =============================== {} " , layerFileInfoList);
        int statusCode = HttpStatus.OK.value();
        
        result.put("layerFileInfoList", layerFileInfoList);
        result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    /**
    * shape 파일 다운 로드
	 * @param request
	 * @param response
	 * @param layerId
	 * @param layerFileInfoTeamId
    */
    @GetMapping(value = "/{layerId:[0-9]+}/layer-file-info/{layerFileInfoGroupId:[0-9]+}/download")
    public void download(HttpServletRequest request, HttpServletResponse response, @PathVariable Integer layerId, @PathVariable Integer layerFileInfoGroupId) {
        log.info("@@@@@@@@@@@@ layerId = {}, layerFileInfoGroupId = {}", layerId, layerFileInfoGroupId);
        try {

            Layer layer = layerService.getLayer(layerId);
            String today = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
            String filePath = propertiesConfig.getLayerExportDir() + today.substring(0, 6) + File.separator;
            String fileRealName = layer.getLayerKey() + "_" + today + "_" + System.nanoTime();
            // TODO 필요 없는 로직. 추후 삭제
//            fileRealName = fileRealName.replaceAll("/", "");
//            fileRealName = fileRealName.replaceAll("\\", "");
//            fileRealName = fileRealName.replaceAll(".", "");
            fileRealName = fileRealName.replaceAll("&", "");
            
            createDirectory(filePath);
            log.info("@@@@@@@ zip directory = {}", filePath);

            List<LayerFileInfo> layerFileInfoList = layerFileInfoService.getLayerFileInfoGroup(layerFileInfoGroupId);
            LayerFileInfo layerFileInfo = layerFileInfoList.get(0);
            layerFileInfo.setFilePath(filePath);
            layerFileInfo.setFileRealName(fileRealName);
            // db에 해당 versionId의 데이터를 shape으로 export
            layerService.exportOgr2Ogr(layerFileInfo, layer);

            String zipFileName = filePath + fileRealName + ".zip";
            List<LayerFileInfo> makeFileList = new ArrayList<>();
            for(ShapeFileExt shapeFileExt : ShapeFileExt.values()) {
				LayerFileInfo fileInfo = new LayerFileInfo();
				fileInfo.setFilePath(filePath);
				fileInfo.setFileRealName(fileRealName + "." + shapeFileExt.getValue());
				makeFileList.add(fileInfo);
			}

            ZipSupport.makeZip(zipFileName, makeFileList);

            response.setContentType("application/force-download");
            response.setHeader("Content-Transfer-Encoding", "binary");
            setDisposition(layer.getLayerName() + ".zip", request, response);

            File zipFile = new File(zipFileName);
            try(	BufferedInputStream in = new BufferedInputStream(new FileInputStream(zipFile));
                    BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream())) {

                FileCopyUtils.copy(in, out);
                out.flush();
            } catch(IOException e) {
            	log.info("@@ IOException. message = {}", e.getMessage());
            	throw new RuntimeException(e.getMessage());
            }
        } catch(DataAccessException e) {
			log.info("@@ DataAccessException. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
        } catch(RuntimeException e) {
			log.info("@@ RuntimeException. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
        } catch(IOException e) {
        	log.info("@@ FileNotFoundException. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
        } catch(Exception e) {
			log.info("@@ Exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
    }

    /**
    * 비활성화 상태의 layer를 활성화
	 * @param request
	 * @param layerId
	 * @param layerFileInfoId
	 * @param layerFileInfoGroupId
    * @return
    */
    @PostMapping(value = "/{layerId:[0-9]+}/layer-file-infos/{layerFileInfoId:[0-9]+}")
    public Map<String, Object> updateByLayerFileInfoId(HttpServletRequest request,
                                                            @PathVariable Integer layerId,
                                                            @PathVariable Integer layerFileInfoId,
                                                            Integer layerFileInfoGroupId) {
        log.info("@@@@@@@@@@@@ layerId = {}, layerFileInfoId = {}", layerId, layerFileInfoId);

        Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
        layerService.updateLayerByLayerFileInfoId(layerId, layerFileInfoGroupId, layerFileInfoId);

        int statusCode = HttpStatus.OK.value();

        result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
    }

    @GetMapping(value = "/file-info/{layerFileInfoId:[0-9]+}")
    public Map<String, Object> viewFileDetail(@PathVariable Integer layerFileInfoId) {
    	Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		LayerFileInfo layerFileInfo = layerFileInfoService.getLayerFileInfo(layerFileInfoId);
        log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ layerFileInfo = {}", layerFileInfo);
        int statusCode = HttpStatus.OK.value();

    	result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		result.put("layerFileInfo", layerFileInfo);
		return result;
    }

   private String replaceInvalidValue(String value) {
        if("null".equals(value)) value = null;
        return value;
    }

    /**
    * 업로딩 파일을 압축 해제
    * TODO 여기 Exception을 던지면 안될거 같음. 수정 필요
    * @param policy
	* @param groupFileName groupFileName layer 의 경우 한 세트가 같은 이름에 확장자만 달라야 함
    * @param multipartFile
	* @param shapeEncoding
    * @param targetDirectory
    * @return
    * @throws Exception
    */
    private Map<String, Object> unzip(Policy policy, String groupFileName, MultipartFile multipartFile, String shapeEncoding, String targetDirectory) throws Exception {
        Map<String, Object> result = new HashMap<>();
        String errorCode = fileValidate(policy, multipartFile);
        if(!StringUtils.isEmpty(errorCode)) {
            result.put("errorCode", errorCode);
            return result;
        }

        // temp 디렉토리에 압축을 해제 함
        String tempDirectory = targetDirectory + "temp" + File.separator;
        createDirectory(tempDirectory);

        List<LayerFileInfo> layerFileInfoList = new ArrayList<>();

        File uploadedFile = new File(tempDirectory + multipartFile.getOriginalFilename());
        multipartFile.transferTo(uploadedFile);

        try ( ZipFile zipFile = new ZipFile(uploadedFile)) {
            String directoryPath = targetDirectory;
            Enumeration<? extends ZipEntry> entries = zipFile.entries();
            while( entries.hasMoreElements() ) {
                LayerFileInfo layerFileInfo = new LayerFileInfo();
                ZipEntry entry = entries.nextElement();
                if( entry.isDirectory() ) {
                    String unzipfileName = directoryPath + entry.getName();
                    log.info("--------- unzip directory = {}", unzipfileName);
                    File file = new File(unzipfileName);
                    file.mkdirs();
                } else {
                    String extension = null;
                    String saveFileName = null;

					String fileName = entry.getName();
					String[] divideFileName = fileName.split("\\.");
                    if(divideFileName.length != 0) {
                        extension = divideFileName[divideFileName.length - 1];
                        saveFileName = groupFileName + "." + extension;
                        log.info("--------- unzip saveFileName = {}", saveFileName);
                    }

                    long size = 0L;
                    try ( 	InputStream inputStream = zipFile.getInputStream(entry);
                            FileOutputStream outputStream = new FileOutputStream(targetDirectory + saveFileName) ) {
                    	int bytesRead = 0;
                        byte[] buffer = new byte[BUFFER_SIZE];
                        while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
                            size += bytesRead;
                            outputStream.write(buffer, 0, bytesRead);
                        }

                        layerFileInfo.setFileExt(extension);
                        layerFileInfo.setFileName(fileName);
                        layerFileInfo.setFileRealName(saveFileName);
                        layerFileInfo.setFilePath(directoryPath);
                        layerFileInfo.setFileSize(String.valueOf(size));
                        layerFileInfo.setShapeEncoding(shapeEncoding);

                    } catch(IOException e) {
                    	log.info("@@ IOException. message = {}", e.getMessage());
                    	layerFileInfo.setErrorMessage(e.getMessage());
                    	throw new RuntimeException(e.getMessage());
                    }
                }
                layerFileInfo.setFileSize(String.valueOf(entry.getSize()));
                if( !entry.isDirectory() ) {
                    layerFileInfoList.add(layerFileInfo);
                }
            }
        } catch(RuntimeException ex) {
        	log.info("@@ RuntimeException. message = {}", ex.getCause() != null ? ex.getCause().getMessage() : ex.getMessage());
        } catch(Exception ex) {
        	log.info("@@ RuntimeException. message = {}", ex.getCause() != null ? ex.getCause().getMessage() : ex.getMessage());
        }

        log.info("##################### unzip layerFileInfoList = {}", layerFileInfoList.size());
        result.put("layerFileInfoList", layerFileInfoList);
        return result;
    }

    /**
    * @param policy
    * @param multipartFile
    * @return
    */
    private static String fileValidate(Policy policy, MultipartFile multipartFile) {

        // 2 파일 이름
        String fileName = multipartFile.getOriginalFilename();
//		if(fileName == null) {
//			log.info("@@ fileName is null");
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		} else if(fileName.indexOf("..") >= 0 || fileName.indexOf("/") >= 0) {
//			// TODO File.seperator 정규 표현식이 안 먹혀서 이렇게 처리함
//			log.info("@@ fileName = {}", fileName);
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		}

        // 3 파일 확장자
        String[] fileNameValues = fileName.split("\\.");
//		if(fileNameValues.length != 2) {
//			log.info("@@ fileNameValues.length = {}, fileName = {}", fileNameValues.length, fileName);
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		}
//		if(fileNameValues[0].indexOf(".") >= 0 || fileNameValues[0].indexOf("..") >= 0) {
//			log.info("@@ fileNameValues[0] = {}", fileNameValues[0]);
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		}
        // LowerCase로 비교
        String extension = fileNameValues[fileNameValues.length - 1];
//		List<String> extList = new ArrayList<String>();
//		if(policy.getUser_upload_type() != null && !"".equals(policy.getUser_upload_type())) {
//			String[] uploadTypes = policy.getUser_upload_type().toLowerCase().split(",");
//			extList = Arrays.asList(uploadTypes);
//		}
//		if(!extList.contains(extension.toLowerCase())) {
//			log.info("@@ extList = {}, extension = {}", extList, extension);
//			uploadLog.setError_code("fileinfo.ext.invalid");
//			return uploadLog;
//		}

        // 4 파일 사이즈
        long fileSize = multipartFile.getSize();
        log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ upload file size = {} KB", (fileSize / 1000));
        if( fileSize > (policy.getUserUploadMaxFilesize() * 1000000L)) {
            log.info("@@ fileSize = {}, user upload max filesize = {} M", (fileSize / 1000), policy.getUserUploadMaxFilesize());
            return "fileinfo.size.invalid";
        }

        return null;
    }

    // shape필수 파일 있는지 확인
    private String shapeFileValidate(List<LayerFileInfo> layerFileInfoList) {
    	if(!layerFileInfoList.isEmpty()) {
    		long validCount = layerFileInfoList.stream()
    				.filter(layerFileInfo -> {
    					String fileExt = layerFileInfo.getFileExt().toLowerCase().trim();
    					return fileExt.equals(ShapeFileExt.SHP.getValue()) || fileExt.equals(ShapeFileExt.DBF.getValue()) || fileExt.equals(ShapeFileExt.SHX.getValue());
    				})
    				.count();
    		if(ShapeFileExt.values().length-1 != (int)validCount) {
    			return "upload.shpfile.invalid";
    		}
    	}
    	
    	return null;
    }

    /**
	 *
    * @param targetDirectory
    */
    private void createDirectory(String targetDirectory) {
        File directory = new File(targetDirectory);
        if(!directory.exists()) {
            directory.mkdir();
        }
    }

    /**
    * validation 체크
    * @param request
    * @return
    */
    private String layerValidate(MultipartHttpServletRequest request) {
        if(StringUtils.isEmpty(request.getParameter("layerName"))) {
            return "layer.name.empty";
        }
        
        return null;
    }

    /**
    * 다운로드시 한글 깨짐 방지 처리
    */
    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
        String browser = WebUtils.getBrowser(request);
        String dispositionPrefix = "attachment; filename=";
        String encodedFilename = null;

        log.info("================================= browser = {}", browser);
        if (browser.equals("MSIE")) {
            encodedFilename = URLEncoder.encode(filename, StandardCharsets.UTF_8).replaceAll("\\+", "%20");
        } else if (browser.equals("Trident")) {       // IE11 문자열 깨짐 방지
            encodedFilename = URLEncoder.encode(filename, StandardCharsets.UTF_8).replaceAll("\\+", "%20");
        } else if (browser.equals("Firefox")) {
            encodedFilename = "\"" + new String(filename.getBytes(StandardCharsets.UTF_8), "8859_1") + "\"";
            encodedFilename = URLDecoder.decode(encodedFilename, StandardCharsets.UTF_8);
        } else if (browser.equals("Opera")) {
            encodedFilename = "\"" + new String(filename.getBytes(StandardCharsets.UTF_8), "8859_1") + "\"";
        } else if (browser.equals("Chrome")) {
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < filename.length(); i++) {
                char c = filename.charAt(i);
                if (c > '~') {
                    sb.append(URLEncoder.encode("" + c, StandardCharsets.UTF_8));
                } else {
                    sb.append(c);
                }
            }
            encodedFilename = sb.toString();
        } else if (browser.equals("Safari")){
            encodedFilename = "\"" + new String(filename.getBytes(StandardCharsets.UTF_8), "8859_1")+ "\"";
            encodedFilename = URLDecoder.decode(encodedFilename, StandardCharsets.UTF_8);
        }
        else {
            encodedFilename = "\"" + new String(filename.getBytes(StandardCharsets.UTF_8), "8859_1")+ "\"";
        }

        response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
        if ("Opera".equals(browser)){
            response.setContentType("application/octet-stream;charset=UTF-8");
        }
    }
}
