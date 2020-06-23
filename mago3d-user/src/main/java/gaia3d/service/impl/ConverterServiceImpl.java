package gaia3d.service.impl;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.amqp.AmqpException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;
import gaia3d.config.PropertiesConfig;
import gaia3d.domain.ConverterJob;
import gaia3d.domain.ConverterJobFile;
import gaia3d.domain.ConverterJobStatus;
import gaia3d.domain.ConverterTemplate;
import gaia3d.domain.DataAttribute;
import gaia3d.domain.DataGroup;
import gaia3d.domain.DataInfo;
import gaia3d.domain.DataStatus;
import gaia3d.domain.UploadDataType;
import gaia3d.domain.LocationUdateType;
import gaia3d.domain.MethodType;
import gaia3d.domain.QueueMessage;
import gaia3d.domain.ServerTarget;
import gaia3d.domain.UploadData;
import gaia3d.domain.UploadDataFile;
import gaia3d.persistence.ConverterMapper;
import gaia3d.service.AMQPPublishService;
import gaia3d.service.ConverterService;
import gaia3d.service.DataAttributeService;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataService;
import gaia3d.service.UploadDataService;
import gaia3d.utils.FileUtils;

/**
 * converter manager
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class ConverterServiceImpl implements ConverterService {

	@Autowired
	private AMQPPublishService aMQPPublishService;

	@Autowired
	private DataAttributeService dataAttributeService;
	@Autowired
	private DataService dataService;

	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private PropertiesConfig propertiesConfig;

	@Autowired
	private UploadDataService uploadDataService;

	@Autowired
	private ConverterMapper converterMapper;

	/**
	 * converter job 총 건수
	 * @param converterJob
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getConverterJobTotalCount(ConverterJob converterJob) {
		return converterMapper.getConverterJobTotalCount(converterJob);
	}

	/**
	 * converter job file 총 건수
	 * @param converterJobFile
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getConverterJobFileTotalCount(ConverterJobFile converterJobFile) {
		return converterMapper.getConverterJobFileTotalCount(converterJobFile);
	}

	/**
	 * converter job 목록
	 * @param converterLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterJob> getListConverterJob(ConverterJob converterJob) {
		return converterMapper.getListConverterJob(converterJob);
	}

	/**
	 * converter job file 목록
	 * @param converterJobFile
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterJobFile> getListConverterJobFile(ConverterJobFile converterJobFile) {
		return converterMapper.getListConverterJobFile(converterJobFile);
	}

	/**
	 * converter 변환
	 * @param converterJob
	 * @return
	 */
	@Transactional
	public int insertConverter(ConverterJob converterJob) {

		String dataGroupRootPath = propertiesConfig.getDataServiceDir();

		String title = converterJob.getTitle();
		String converterTemplate = converterJob.getConverterTemplate();
		String userId = converterJob.getUserId();
		BigDecimal usf = converterJob.getUsf();

		String[] uploadDataIds = converterJob.getConverterCheckIds().split(",");
		for(String uploadDataId : uploadDataIds) {
			// 1. 변환해야 할 파일 목록을 취득
			UploadData uploadData = new UploadData();
			uploadData.setUserId(userId);
			uploadData.setUploadDataId(Long.valueOf(uploadDataId));
			uploadData.setConverterTarget(true);
			List<UploadDataFile> uploadDataFileList = uploadDataService.getListUploadDataFile(uploadData);

			// 2. converter job 을 등록
			ConverterJob inConverterJob = new ConverterJob();
			inConverterJob.setUploadDataId(Long.valueOf(uploadDataId));
			inConverterJob.setDataGroupTarget(ServerTarget.USER.name().toLowerCase());
			inConverterJob.setUserId(userId);
			inConverterJob.setTitle(title);
			inConverterJob.setUsf(usf);
			inConverterJob.setConverterTemplate(converterTemplate);
			inConverterJob.setFileCount(uploadDataFileList.size());
			inConverterJob.setYAxisUp(converterJob.getYAxisUp());
			converterMapper.insertConverterJob(inConverterJob);

			Long converterJobId = inConverterJob.getConverterJobId();
			int converterTargetCount = uploadDataFileList.size();
			for(int i=0; i< converterTargetCount; i++) {
				UploadDataFile uploadDataFile = uploadDataFileList.get(i);
				ConverterJobFile converterJobFile = new ConverterJobFile();
				converterJobFile.setUserId(userId);
				converterJobFile.setConverterJobId(converterJobId);
				converterJobFile.setUploadDataId(Long.valueOf(uploadDataId));
				converterJobFile.setUploadDataFileId(uploadDataFile.getUploadDataFileId());
				converterJobFile.setDataGroupId(uploadDataFile.getDataGroupId());
				converterJobFile.setUserId(userId);
				converterJobFile.setUsf(usf);

				// 3. job file을 하나씩 등록
				converterMapper.insertConverterJobFile(converterJobFile);

				// 4. 데이터를 등록. 상태를 ready 로 등록해야 함
				DataInfo dataInfo = upsertData(userId, converterJobId, converterTargetCount, uploadDataFile);

				// 5. 데이터 그룹 신규 생성의 경우 데이터 건수 update, location_update_type 이 auto 일 경우 dataInfo 위치 정보로 dataGroup 위치 정보 수정
				updateDataGroup(userId, dataInfo, uploadDataFile);

				if( i == converterTargetCount - 1) {
					// queue 를 실행
					executeConverter(userId, dataGroupRootPath, inConverterJob, uploadDataFile);
				}
			}

			uploadData.setConverterCount(1);
			uploadDataService.updateUploadData(uploadData);
		}

		return uploadDataIds.length;
	}

	/**
	 * @param userId
	 * @param dataGroupRootPath
	 * @param inConverterJob
	 * @param uploadDataFile
	 */
	private void executeConverter(String userId, String dataGroupRootPath, ConverterJob inConverterJob, UploadDataFile uploadDataFile) {
		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userId);
		dataGroup.setDataGroupId(uploadDataFile.getDataGroupId());
		dataGroup = dataGroupService.getDataGroup(dataGroup);

		// path 와 File.seperator 의 차이점 때문에 변환
		String dataGroupFilePath = FileUtils.getFilePath(dataGroup.getDataGroupPath());

		log.info("-------------------------------------------------------");
		log.info("----------- dataGroupRootPath = {}", dataGroupRootPath);
		log.info("----------- dataGroup.getDataGroupPath() = {}", dataGroup.getDataGroupPath());

		log.info("----------- input = {}", uploadDataFile.getFilePath());
		log.info("----------- output = {}", dataGroupRootPath + dataGroupFilePath);
		log.info("----------- log = {}", dataGroupRootPath + dataGroupFilePath + "logTest.txt");

		log.info("-------------------------------------------------------");

		QueueMessage queueMessage = new QueueMessage();
		queueMessage.setServerTarget(ServerTarget.USER.name());
		queueMessage.setConverterJobId(inConverterJob.getConverterJobId());
//		queueMessage.setConverterJobFileId(inConverterJob.getConverterJobFileId());
		queueMessage.setInputFolder(uploadDataFile.getFilePath());
		queueMessage.setOutputFolder(dataGroupRootPath + dataGroupFilePath);
//		queueMessage.setMeshType("0");
		queueMessage.setLogPath(dataGroupRootPath + dataGroupFilePath + "logTest.txt");
		queueMessage.setIndexing("y");
		queueMessage.setUsf(inConverterJob.getUsf());
		queueMessage.setIsYAxisUp(inConverterJob.getYAxisUp());
		queueMessage.setUserId(userId);
		
		// 템플릿 별 meshType과 skinLevel 설정
		ConverterTemplate template = ConverterTemplate.findBy(inConverterJob.getConverterTemplate());
		queueMessage.setMeshType(template.getMeshType());
		queueMessage.setSkinLevel(template.getSkinLevel());
		
		// TODO
		// 조금 미묘하다. transaction 처리를 할지, 관리자 UI 재 실행을 위해서는 여기가 맞는거 같기도 하고....
		// 별도 기능으로 분리해야 하나?
		try {
			aMQPPublishService.send(queueMessage);
		} catch(AmqpException e) {
			ConverterJob converterJob = new ConverterJob();
			converterJob.setUserId(userId);
			converterJob.setConverterJobId(inConverterJob.getConverterJobId());
			converterJob.setStatus(ConverterJobStatus.WAITING.name());
			converterJob.setErrorCode(e.getMessage());
			converterMapper.updateConverterJob(converterJob);
			
			log.info("@@@@@@@@@@@@ AmqpException. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
	}

	/**
	 * TODO 현재는 converterJob 과 dataInfo 가 1:1 의 관계여서 converterJobId를 받지만, 나중에는 converterJobFileId 를 받아야 함
	 * dataKey 존재하지 않을 경우 insert, 존재할 경우 update
	 * @param userId
	 * @param uploadDataFile
	 */
	private DataInfo upsertData(String userId, Long converterJobId, int converterTargetCount, UploadDataFile uploadDataFile) {
		
		// converterTargetCount = 1 이면 uploading 시 데이터 이름을 넣고, 아닐 경우 dataFile명을 등록
		
		Integer dataGroupId = uploadDataFile.getDataGroupId();
		String dataKey = uploadDataFile.getFileRealName().substring(0, uploadDataFile.getFileRealName().lastIndexOf("."));
		String dataName = null;
		if(converterTargetCount == 1) {
			dataName = uploadDataFile.getDataName();
		} else {
			dataName = uploadDataFile.getFileName().substring(0, uploadDataFile.getFileName().lastIndexOf("."));
		}
		String dataType = uploadDataFile.getDataType();
		String sharing = uploadDataFile.getSharing();
		String mappingType = uploadDataFile.getMappingType();
		BigDecimal latitude = uploadDataFile.getLatitude();
		BigDecimal longitude = uploadDataFile.getLongitude();
		BigDecimal altitude = uploadDataFile.getAltitude();
		
		DataInfo dataInfo = new DataInfo();
		dataInfo.setDataGroupId(dataGroupId);
		dataInfo.setDataKey(dataKey);

		dataInfo = dataService.getDataByDataKey(dataInfo);

		if(dataInfo == null) {
			// int order = 1;
			// TODO nodeType 도 입력해야 함
			String metainfo = "{\"isPhysical\": true}";

			dataInfo = new DataInfo();
			dataInfo.setMethodType(MethodType.INSERT);
			dataInfo.setDataGroupId(dataGroupId);
			dataInfo.setConverterJobId(converterJobId);
			dataInfo.setSharing(sharing);
			dataInfo.setMappingType(mappingType);
			dataInfo.setDataType(dataType);
			dataInfo.setDataKey(dataKey);
			dataInfo.setDataName(dataName);
			dataInfo.setUserId(userId);
			dataInfo.setLatitude(latitude);
			dataInfo.setLongitude(longitude);
			dataInfo.setAltitude(altitude);
			if(longitude != null && longitude.longValue() >0l && latitude != null && latitude.longValue() > 0l) {
				dataInfo.setLocation("POINT(" + longitude + " " + latitude + ")");
			}
			dataInfo.setMetainfo(metainfo);
			dataInfo.setStatus(DataStatus.PROCESSING.name().toLowerCase());
			dataService.insertData(dataInfo);
			
		} else {
			dataInfo.setMethodType(MethodType.UPDATE);
			dataInfo.setConverterJobId(converterJobId);
			dataInfo.setSharing(sharing);
			dataInfo.setMappingType(mappingType);
			dataInfo.setDataType(dataType);
			dataInfo.setDataName(dataName);
			dataInfo.setUserId(userId);
			dataInfo.setLatitude(latitude);
			dataInfo.setLongitude(longitude);
			dataInfo.setAltitude(altitude);
			if(longitude != null && longitude.longValue() >0l && latitude != null && latitude.longValue() > 0l) {
				dataInfo.setLocation("POINT(" + longitude + " " + latitude + ")");
			} else {
				dataInfo.setLocation(null);
			}
			dataInfo.setStatus(DataStatus.PROCESSING.name().toLowerCase());
			dataService.updateData(dataInfo);
		}
		
		return dataInfo;
	}

	/**
	 * dataKey 존재하지 않을 경우 insert, 존재할 경우 update
	 * @param userId
	 * @param dataInfo
	 * @param uploadDataFile
	 */
	private void updateDataGroup(String userId, DataInfo dataInfo, UploadDataFile uploadDataFile) {
		DataGroup dataGroup = DataGroup.builder()
				.userId(userId)
				.dataGroupId(uploadDataFile.getDataGroupId())
				.build();

		DataGroup dbDataGroup = dataGroupService.getDataGroup(dataGroup);

		if(MethodType.INSERT == dataInfo.getMethodType()) {
			dataGroup.setDataCount(dbDataGroup.getDataCount() + 1);
		}

		if(LocationUdateType.AUTO == LocationUdateType.valueOf(dbDataGroup.getLocationUpdateType().toUpperCase())) {
			if(dataInfo.getLongitude() != null && dataInfo.getLongitude().longValue() >0l && dataInfo.getLatitude() != null && dataInfo.getLatitude().longValue() > 0l) {
				dataGroup.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
				dataGroup.setAltitude(dataInfo.getAltitude());
			}
		}

		dataGroupService.updateDataGroup(dataGroup);
	}

	/**
	 * 데이터 변환 작업 상태를 변경
	 * @param converterJob
	 * @return
	 */
	@Transactional
	public int updateConverterJob(ConverterJob converterJob) {

		DataInfo dataInfo = new DataInfo();
		dataInfo.setUserId(converterJob.getUserId());
		dataInfo.setConverterJobId(converterJob.getConverterJobId());
		List<DataInfo> dataInfoList = dataService.getDataByConverterJob(dataInfo);
		if(ConverterJobStatus.SUCCESS == ConverterJobStatus.valueOf(converterJob.getStatus().toUpperCase())) {
			String serviceDirectory = propertiesConfig.getUserDataServiceDir() + converterJob.getUserId() + File.separator;
			// TODO 상태를 success 로 udpate 해야 함
			for(DataInfo updateDataInfo : dataInfoList) {
				if(	UploadDataType.CITYGML == UploadDataType.findBy(updateDataInfo.getDataType())) {
					// json 파일을 읽어서 longitude, latitude를 갱신, 없을 때 예외가 맞는 것일까?
					getCityGmlLocation(serviceDirectory, updateDataInfo);
					// json 파일을 읽어서 속성 정보를 update
					String attribute = getCityGmlAttribute(serviceDirectory, updateDataInfo);
					if(attribute != null) {
						DataAttribute dataAttribute = dataAttributeService.getDataAttribute(updateDataInfo.getDataId());
						if(dataAttribute == null) {
							dataAttribute = new DataAttribute();
							dataAttribute.setDataId(updateDataInfo.getDataId());
							dataAttribute.setAttributes(attribute);
							dataAttributeService.insertDataAttribute(dataAttribute);
						} else {
							dataAttribute.setAttributes(attribute);
							dataAttributeService.updateDataAttribute(dataAttribute);
						}
						updateDataInfo.setAttributeExist(Boolean.TRUE);
					}
				} else {
					updateDataInfo.setStatus(DataStatus.USE.name().toLowerCase());
				}
				updateDataInfo.setUserId(converterJob.getUserId());
				dataService.updateDataStatus(updateDataInfo);
			}
		} else {
			// 상태가 실패인 경우
			// 1. 데이터 삭제
			// 2. 데이터 그룹 데이터 건수 -1
			// 3. 데이터 그룹 최신 이동 location 은? 이건 그냥 다음에 하는걸로~

			for(DataInfo deleteDataInfo : dataInfoList) {
				deleteDataInfo.setUserId(converterJob.getUserId());
				deleteDataInfo.setConverterJobId(converterJob.getConverterJobId());
				dataService.deleteDataByConverterJob(deleteDataInfo);

				DataGroup dataGroup = new DataGroup();
				dataGroup.setUserId(converterJob.getUserId());
				dataGroup.setDataGroupId(deleteDataInfo.getDataGroupId());
				dataGroup = dataGroupService.getDataGroup(dataGroup);

				DataGroup updateDataGroup = new DataGroup();
				updateDataGroup.setUserId(converterJob.getUserId());
				updateDataGroup.setDataGroupId(dataGroup.getDataGroupId());
				updateDataGroup.setDataCount(dataGroup.getDataCount() - 1);
				dataGroupService.updateDataGroup(updateDataGroup);
			}
		}

		return converterMapper.updateConverterJob(converterJob);
	}
	
	/**
	 * json 으로 부터 경, 위도 정보를 읽어 들임
	 * @param serviceDirectory
	 * @param updateDataInfo
	 * @return
	 */
	private DataInfo getCityGmlLocation(String serviceDirectory, DataInfo updateDataInfo) {
		try {
			String targetDirectory = serviceDirectory + updateDataInfo.getDataGroupKey() + File.separator + DataInfo.F4D_PREFIX + updateDataInfo.getDataKey();
			
			File file = new File(targetDirectory + File.separator + "lonsLats.json");
			if(file.exists()) {
				byte[] jsonData = Files.readAllBytes(Paths.get(targetDirectory + File.separator + "lonsLats.json"));
				String encodingData = new String(jsonData, StandardCharsets.UTF_8);
					
				ObjectMapper objectMapper = new ObjectMapper();
				//read JSON like DOM Parser
				JsonNode jsonNode = objectMapper.readTree(encodingData);
				
				String dataKey = jsonNode.path("data_key").asText();
				String longitude = jsonNode.path("longitude").asText().trim();
				String latitude = jsonNode.path("latitude").asText().trim();
				if(!StringUtils.isEmpty(longitude)) {
					updateDataInfo.setLongitude(new BigDecimal(longitude) );
					updateDataInfo.setLatitude(new BigDecimal(latitude) );
					updateDataInfo.setLocation("POINT(" + longitude + " " + latitude + ")");
				}
			}
			
			updateDataInfo.setAltitude(new BigDecimal(0));
			updateDataInfo.setStatus(DataStatus.USE.name().toLowerCase());
		} catch(IOException e) {
			updateDataInfo.setStatus(DataStatus.UNUSED.name().toLowerCase());
			e.printStackTrace();
		}
		
		return updateDataInfo;
	}
	
	/**
	 * citygml 속성 정보를 추출
	 * @param serviceDirectory
	 * @param updateDataInfo
	 * @return
	 */
	private String getCityGmlAttribute(String serviceDirectory, DataInfo updateDataInfo) {
		String attribute = null;
		try {
			String targetDirectory = serviceDirectory + updateDataInfo.getDataGroupKey() + File.separator + DataInfo.F4D_PREFIX + updateDataInfo.getDataKey();
			
			File file = new File(targetDirectory + File.separator + "attributes.json");
			if(file.exists()) {
				byte[] jsonData = Files.readAllBytes(Paths.get(targetDirectory + File.separator + "attributes.json"));
				attribute = new String(jsonData, StandardCharsets.UTF_8);
			}
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return attribute;
	}
}
