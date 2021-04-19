package gaia3d.service.impl;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.amqp.AmqpException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.ConverterType;
import gaia3d.domain.LocationUdateType;
import gaia3d.domain.MethodType;
import gaia3d.domain.ServerTarget;
import gaia3d.domain.agent.ConversionJobResult;
import gaia3d.domain.agent.ConverterJobResultStatus;
import gaia3d.domain.agent.ConverterLocation;
import gaia3d.domain.agent.ConverterResultLog;
import gaia3d.domain.common.QueueMessage;
import gaia3d.domain.converter.ConverterJob;
import gaia3d.domain.converter.ConverterJobFile;
import gaia3d.domain.converter.ConverterJobStatus;
import gaia3d.domain.converter.ConverterTemplate;
import gaia3d.domain.data.DataAttribute;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataRelationInfo;
import gaia3d.domain.data.DataStatus;
import gaia3d.domain.uploaddata.UploadData;
import gaia3d.domain.uploaddata.UploadDataFile;
import gaia3d.domain.uploaddata.UploadDataType;
import gaia3d.domain.uploaddata.UploadDirectoryType;
import gaia3d.persistence.ConverterMapper;
import gaia3d.service.AMQPPublishService;
import gaia3d.service.ConverterService;
import gaia3d.service.DataAttributeService;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataRelationService;
import gaia3d.service.DataService;
import gaia3d.service.UploadDataService;
import gaia3d.support.LogMessageSupport;
import gaia3d.utils.FileUtils;
import lombok.extern.slf4j.Slf4j;

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
	private ConverterMapper converterMapper;

	@Autowired
	private DataAttributeService dataAttributeService;

	@Autowired
	private DataService dataService;

	@Autowired
	private DataRelationService dataRelationService;

	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private PropertiesConfig propertiesConfig;

	@Autowired
	private UploadDataService uploadDataService;

	/**
	 * converter job 총 건수
	 * @param converterJob converterJob
	 * @return converter job 총 건수
	 */
	@Transactional(readOnly=true)
	public Long getConverterJobTotalCount(ConverterJob converterJob) {
		return converterMapper.getConverterJobTotalCount(converterJob);
	}

	/**
	 * converter job file 총 건수
	 * @param converterJobFile converterJobFile
	 * @return converter job file 총 건수
	 */
	@Transactional(readOnly=true)
	public Long getConverterJobFileTotalCount(ConverterJobFile converterJobFile) {
		return converterMapper.getConverterJobFileTotalCount(converterJobFile);
	}

	/**
	 * f4d converter job 목록
	 * @param converterJob converterJob
	 * @return f4d converter job 목록
	 */
	@Transactional(readOnly=true)
	public List<ConverterJob> getListConverterJob(ConverterJob converterJob) {
		return converterMapper.getListConverterJob(converterJob);
	}

	/**
	 * f4d converter job file 목록
	 * @param converterJobFile converterJobFile
	 * @return f4d converter job file 목록
	 */
	@Transactional(readOnly=true)
	public List<ConverterJobFile> getListConverterJobFile(ConverterJobFile converterJobFile) {
		return converterMapper.getListConverterJobFile(converterJobFile);
	}

	/**
	 * f4d converter 변환 job 등록
	 * @param converterJob    converterJob
	 */
	@Transactional
	public void insertConverter(ConverterJob converterJob) {

		// 1. 변환해야 할 파일 목록(업로딩 데이터 목록)을 취득
		// 2. converter job 을 등록
		// 3. convert job file 하나씩 등록. 변환 상태를 ready(준비)로 등록.
		// 4. queue 를 실행
		// 7. 업로드 데이터의 ConverterCount를 1로 갱신

		String dataGroupRootPath = propertiesConfig.getDataServiceDir();

		String title = converterJob.getTitle();
		String converterTemplate = converterJob.getConverterTemplate();
		String userId = converterJob.getUserId();
		BigDecimal usf = converterJob.getUsf();

		String[] uploadDataIds = converterJob.getConverterCheckIds().split(",");
		for (String uploadDataId : uploadDataIds) {

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
			for (int i = 0; i < converterTargetCount; i++) {

				UploadDataFile uploadDataFile = uploadDataFileList.get(i);

				// 3. convert job file 하나씩 등록. 변환 상태를 ready(준비)로 등록.
				ConverterJobFile converterJobFile = new ConverterJobFile();
				converterJobFile.setUserId(userId);
				converterJobFile.setConverterJobId(converterJobId);
				converterJobFile.setUploadDataId(Long.valueOf(uploadDataId));
				converterJobFile.setUploadDataFileId(uploadDataFile.getUploadDataFileId());
				converterJobFile.setDataGroupId(uploadDataFile.getDataGroupId());
				converterJobFile.setUserId(userId);
				converterJobFile.setUsf(usf);
				converterJobFile.setStatus(ConverterJobStatus.READY.getValue());
				converterMapper.insertConverterJobFile(converterJobFile);

				if( i == converterTargetCount - 1) {
					// 4. queue 를 실행
					executeConverter(userId, dataGroupRootPath, inConverterJob, uploadDataFile);
				}

				// 5. 데이터를 등록 혹은 갱신. 상태를 use(사용중)로 등록.
				// DataInfo dataInfo = upsertData(userId, converterJobId, converterTargetCount, uploadDataFile);

				// 6. 데이터 그룹 신규 생성의 경우 데이터 건수 update -
				//    location_update_type 이 auto 일 경우 dataInfo 위치 정보로 dataGroup 위치 정보 수정
				// updateDataGroup(userId, dataInfo, uploadDataFile);

			}

			// 7. 업로드 데이터의 ConverterCount를 1로 갱신
			uploadData.setConverterCount(1);
			uploadDataService.updateUploadData(uploadData);
		}

	}

	@Transactional
	public void updateConverterJob(ConverterJob converterJob) {
		converterMapper.updateConverterJob(converterJob);
/*
		DataInfo dataInfo = new DataInfo();
		// dataInfo.setUserId(converterJob.getUserId());
		dataInfo.setConverterJobId(converterJob.getConverterJobId());

		List<DataInfo> dataInfoList = dataService.getDataByConverterJob(dataInfo);
		if(ConverterJobStatus.SUCCESS == ConverterJobStatus.valueOf(converterJob.getStatus().toUpperCase())) {
			String serviceDirectory = propertiesConfig.getAdminDataServiceDir();
			// TODO 상태를 success 로 udpate 해야 함
			for(DataInfo updateDataInfo : dataInfoList) {
				if (UploadDataType.CITYGML == UploadDataType.findBy(updateDataInfo.getDataType())) {
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
				dataService.updateDataStatus(updateDataInfo);
			}
		} else {
			// 상태가 실패인 경우
			// 1. 데이터 삭제
			// 2. 데이터 그룹 데이터 건수 -1
			// 3. 데이터 그룹 최신 이동 location 은? 이건 그냥 다음에 하는걸로~
			for(DataInfo deleteDataInfo : dataInfoList) {
				// deleteDataInfo.setUserId(converterJob.getUserId());
				deleteDataInfo.setConverterJobId(converterJob.getConverterJobId());
				dataService.deleteDataByConverterJob(deleteDataInfo);

				DataGroup dataGroup = new DataGroup();
				// dataGroup.setUserId(converterJob.getUserId());
				dataGroup.setDataGroupId(deleteDataInfo.getDataGroupId());
				dataGroup = dataGroupService.getDataGroup(dataGroup);

				DataGroup updateDataGroup = new DataGroup();
				// updateDataGroup.setUserId(converterJob.getUserId());
				updateDataGroup.setDataGroupId(dataGroup.getDataGroupId());
				updateDataGroup.setDataCount(dataGroup.getDataCount() - 1);
				dataGroupService.updateDataGroup(updateDataGroup);
			}
		}

		converterMapper.updateConverterJob(converterJob);

 */
	}


	/**
	 * 로그파일을 통한 데이터 변환 작업 상태를 갱신
	 * @param converterResultLog converterResultLog
	 */
	@Transactional
	public void updateConverterJobStatus(ConverterResultLog converterResultLog) {

		ConverterJob converterJob = converterResultLog.getConverterJob();

		// 1. 로그파일 정보를 통해 ConvertJob 갱신
		updateConverterJob(converterJob, converterResultLog);

		// 2. 로그파일 정보를 통해 ConvertJobFile 갱신
		List<ConverterJobFile> converterJobFiles = converterMapper.getListConverterJobFileByConverterJob(converterJob);

		// upload 한 파일 정보
		UploadData uploadData = uploadDataService.getUploadData(UploadData.builder()
				.uploadDataId(converterJobFiles.get(0).getUploadDataId())
				.build()
		);
		DataRelationInfo dataRelationInfo = DataRelationInfo.builder()
				.assemble(uploadData.getAssemble())
				.build();

		// List to Map
		List<ConversionJobResult> conversionJobResultList = converterResultLog.getConversionJobResult();
		Map<String, ConversionJobResult> converterJobResultMap = conversionJobResultList
				.stream()
				.collect(Collectors.toMap(ConversionJobResult::getFileName, result -> result));

		String userId = converterJob.getUserId();
		Long converterJobId = converterJob.getConverterJobId();
		int converterTargetCount = converterJobFiles.size();

		for (ConverterJobFile converterJobFile : converterJobFiles) {

			UploadDataFile uploadDataFile = new UploadDataFile();
			uploadDataFile.setUploadDataFileId(converterJobFile.getUploadDataFileId());
			uploadDataFile = uploadDataService.getUploadDataFile(uploadDataFile);

			String key = uploadDataFile.getFileRealName();
			String dataName = uploadDataFile.getDataName();
			String fileName = uploadDataFile.getFileName();
			// dataName(converterTargetCount = 1 이면 uploading 시 데이터 이름을 넣고, 아닐 경우 dataFile 명을 등록)
			String countDataName = converterTargetCount == 1 ? dataName : fileName.substring(0, fileName.lastIndexOf("."));

			ConversionJobResult conversionJobResult = converterJobResultMap.get(key);

			if (ConverterJobResultStatus.SUCCESS == conversionJobResult.getResultStatus()) {
				// 상태가 성공인 경우
				var splitResult = conversionJobResult.getSplitResult();
				var length = splitResult.length;
				for (var i = 0; i < length; i++) {
					// dataKey
					uploadDataFile.setFileRealName(splitResult[i]);
					// 쪼개진 파일일경우 splitInfo.json 에 기록된 "파일명_인덱스"를 dataName 으로 사용
					uploadDataFile.setDataName(length > 1 ? dataName + "_" + i : countDataName);

					// 쪼개진 파일이거나 합체인 경우에는 relation 정보 insert
					// TODO: 단일 파일이 쪼개진 경우 upload_data 의 assemble 정보를 갱신해줘야함
					// TODO: 변환한 파일 다시 변환할 때 data_relation_id 또 생성하는거 수정해야함. 컨버팅쪽 소스정리하면서 같이하기
					if (length > 1 || uploadData.getAssemble()) {
						dataRelationInfo.setAssemble(true);
						dataRelationService.insertDataRelation(dataRelationInfo);
					}

					DataInfo dataInfo = upsertData(converterJob, uploadDataFile, dataRelationInfo);

				// 데이터 그룹 신규 생성의 경우 데이터 건수 update
				// location_update_type 이 auto 일 경우 dataInfo 위치 정보로 dataGroup 위치 정보 수정
				updateDataGroup(userId, dataInfo, uploadDataFile);

				if (conversionJobResult.getLocation() != null) {
					// 위치정보 갱신
						ConverterLocation converterLocation = conversionJobResult.getLocation()[i];
					updateConverterLocation(converterLocation, dataInfo);
				}
				if (conversionJobResult.getAttributes() != null) {
					// 속성정보 갱신
						String attributes = conversionJobResult.getAttributes()[i];
					updateConverterAttribute(attributes, dataInfo);
				}
				}

				converterJobFile.setStatus(ConverterJobStatus.SUCCESS.getValue());
			} else {
				// 상태가 실패인 경우
				// 1) 데이터 삭제
				// 2) 데이터 그룹 데이터 건수 -1
				// 3) 데이터 그룹 최신 이동 location 은? 이건 그냥 다음에 하는걸로~
				DataInfo dataInfo = new DataInfo();
				// dataInfo.setUserId(converterJob.getUserId());
				dataInfo.setConverterJobId(converterJobId);
				List<DataInfo> dataInfoList = dataService.getDataByConverterJob(dataInfo);
				deleteFailData(dataInfoList);

				converterJobFile.setStatus(ConverterJobStatus.FAIL.getValue());
				converterJobFile.setErrorCode(conversionJobResult.getMessage());
			}

			// ConvertJobFile status, errorCode 갱신
			converterMapper.updateConverterJobFile(converterJobFile);

		}
	}

	/**
	 * QueueMessage 실행
	 * @param userId	userId
	 * @param dataGroupRootPath	dataGroupRootPath
	 * @param inConverterJob	inConverterJob
	 * @param uploadDataFile	uploadDataFile
	 */
	private void executeConverter(String userId, String dataGroupRootPath, ConverterJob inConverterJob, UploadDataFile uploadDataFile) {

		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userId);
		dataGroup.setDataGroupId(uploadDataFile.getDataGroupId());
		dataGroup = dataGroupService.getDataGroup(dataGroup);

		Long converterJobId = inConverterJob.getConverterJobId();

		// path 와 File.seperator 의 차이점 때문에 변환
		String dataGroupFilePath = FileUtils.getFilePath(dataGroup.getDataGroupPath());

		// 로그파일을 ConverterJobId로 분리하여 쓰도록 수정
		String makedDirectory = FileUtils.makeDirectory(userId, UploadDirectoryType.YEAR_MONTH, propertiesConfig.getDataConverterLogDir());
		String logFilePath = makedDirectory + "logTest_" + converterJobId + ".txt";

		log.info("-------------------------------------------------------");
		log.info("----------- dataGroupRootPath = {}", dataGroupRootPath);
		log.info("----------- dataGroup.getDataGroupPath() = {}", dataGroup.getDataGroupPath());

		log.info("----------- input = {}", uploadDataFile.getFilePath());
		log.info("----------- output = {}", dataGroupRootPath + dataGroupFilePath);
		log.info("----------- log = {}", logFilePath);

		log.info("-------------------------------------------------------");

		QueueMessage queueMessage = new QueueMessage();
		queueMessage.setConverterType(ConverterType.DATA);
		queueMessage.setServerTarget(ServerTarget.USER);
		queueMessage.setConverterJobId(converterJobId);
		//queueMessage.setConverterJobFileId(inConverterJob.getConverterJobFileId());
		queueMessage.setInputFolder(uploadDataFile.getFilePath());
		queueMessage.setOutputFolder(dataGroupRootPath + dataGroupFilePath);
		//queueMessage.setMeshType("0");
		queueMessage.setLogPath(logFilePath);
		queueMessage.setIndexing("y");
		queueMessage.setUsf(inConverterJob.getUsf());
		queueMessage.setIsYAxisUp(inConverterJob.getYAxisUp());
		queueMessage.setUserId(userId);
		queueMessage.setUploadDataType(UploadDataType.findBy(uploadDataFile.getDataType()));

		// 템플릿 별 meshType과 skinLevel 설정
		ConverterTemplate template = ConverterTemplate.findBy(inConverterJob.getConverterTemplate());
		//assert template != null;
		queueMessage.setMeshType(template.getMeshType());
		queueMessage.setSkinLevel(template.getSkinLevel());

		// TODO
		// 조금 미묘하다. transaction 처리를 할지, 관리자 UI 재 실행을 위해서는 여기가 맞는거 같기도 하고....
		// 별도 기능으로 분리해야 하나?
		try {
			aMQPPublishService.send(propertiesConfig.getRabbitmqConverterExchange(), propertiesConfig.getRabbitmqConverterRoutingKey(), queueMessage);
		} catch(AmqpException e) {
			ConverterJob converterJob = new ConverterJob();
			converterJob.setUserId(userId);
			converterJob.setConverterJobId(converterJobId);
			converterJob.setStatus(ConverterJobStatus.WAITING.name());
			converterJob.setErrorCode(e.getMessage());
			converterMapper.updateConverterJob(converterJob);
			LogMessageSupport.printMessage(e, "@@@@@@@@@@@@ AmqpException. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
	}


	/**
	 * 로그파일을 통한 데이터 변환 작업 상태를 갱신
	 * @param converterJob	converterJob
	 * @param converterResultLog	converterResultLog
	 */
	private boolean updateConverterJob(ConverterJob converterJob, ConverterResultLog converterResultLog) {
		boolean isSuccess = true;
		int numberOfFilesConverted = converterResultLog.getNumberOfFilesConverted();
		if (converterResultLog.getIsSuccess() && numberOfFilesConverted != 0) {
			if (converterResultLog.getNumberOfFilesToBeConverted() - numberOfFilesConverted > 0) {
				converterJob.setStatus(ConverterJobStatus.PARTIAL_SUCCESS.getValue());
			} else {
				converterJob.setStatus(ConverterJobStatus.SUCCESS.getValue());
			}
			isSuccess = true;
		} else {
			converterJob.setStatus(ConverterJobStatus.FAIL.getValue());
			converterJob.setErrorCode(converterResultLog.getFailureLog());
			isSuccess = false;
		}
		converterMapper.updateConverterJob(converterJob);
		return isSuccess;
	}

	/**
	 * 위치파일(LonsLats.json)을 통한 데이터 Longitude, Latitude 갱신
	 * (CityGML, IndoorGML 파일에 한함)
	 * @param converterLocation	converterLocation
	 * @param updateDataInfo	updateDataInfo
	 */
	private void updateConverterLocation(ConverterLocation converterLocation, DataInfo updateDataInfo) {
		BigDecimal longitude = converterLocation.getLongitude();
		BigDecimal latitude = converterLocation.getLatitude();
		if (isNotNull(longitude, latitude)) {
			updateDataInfo.setLongitude(longitude);
			updateDataInfo.setLatitude(latitude);
			updateDataInfo.setLocation("POINT(" + longitude + " " + latitude + ")");
		}
		updateDataInfo.setAltitude(new BigDecimal(0));
		// TODO 유효한 위치정보가 아닐 경우 DataInfo의 상태를 UNUSED로 갱신해야할지..?
		dataService.updateDataStatus(updateDataInfo);
	}

	/**
	 * 속성파일(attributes.json) 을 통한 데이터 Attribute 갱신
	 * (CityGML, IndoorGML 파일에 한함)
	 * @param attributes	attributes
	 * @param updateDataInfo	updateDataInfo
	 */
	private void updateConverterAttribute(String attributes, DataInfo updateDataInfo) {
		if (attributes != null && !attributes.isEmpty()) {
			// 데이터 속성 등록. 있으면 update, 없으면 insert
			Long dataId = updateDataInfo.getDataId();
			DataAttribute dataAttribute = dataAttributeService.getDataAttribute(dataId);
			upsertDataAttribute(dataAttribute, dataId, attributes);

			updateDataInfo.setAttributeExist(Boolean.TRUE);
			dataService.updateDataStatus(updateDataInfo);
		}
	}

	/**
	 * TODO 현재는 converterJob 과 dataInfo 가 1:1 의 관계여서 converterJobId를 받지만, 나중에는 converterJobFileId 를 받아야 함
	 * dataKey가 존재하지 않을 경우 insert, 존재할 경우 update
	 * @param uploadDataFile	uploadDataFile
	 */
	private DataInfo upsertData(ConverterJob converterJob, UploadDataFile uploadDataFile, DataRelationInfo dataRelationInfo) {

		Long converterJobId = converterJob.getConverterJobId();
		String userId = converterJob.getUserId();
		Integer dataGroupId = uploadDataFile.getDataGroupId();
		String dataKey = uploadDataFile.getFileRealName();
		String dataName = uploadDataFile.getDataName();
		String dataType = uploadDataFile.getDataType();
		String sharing = uploadDataFile.getSharing();
		String mappingType = uploadDataFile.getMappingType();
		String heightReference = uploadDataFile.getHeightReference();
		BigDecimal latitude = uploadDataFile.getLatitude();
		BigDecimal longitude = uploadDataFile.getLongitude();
		BigDecimal altitude = uploadDataFile.getAltitude();

		Boolean assemble = dataRelationInfo.getAssemble();
		Long dataRelationId = dataRelationInfo.getDataRelationId();

		DataInfo dataInfo = new DataInfo();
		dataInfo.setDataGroupId(dataGroupId);
		dataInfo.setDataKey(dataKey);
		dataInfo = dataService.getDataByDataKey(dataInfo);

		if (dataInfo == null) {
			// int order = 1;
			// TODO nodeType 도 입력해야 함
			String metainfo = "{\"isPhysical\": true, \"heightReference\": \"" + heightReference + "\"}";
			
			dataInfo = new DataInfo();
			dataInfo.setMethodType(MethodType.INSERT);
			dataInfo.setDataGroupId(dataGroupId);
			dataInfo.setDataRelationId(dataRelationId);
			dataInfo.setAssemble(assemble);
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
			if (isNotNull(longitude, latitude)) {
				dataInfo.setLocation("POINT(" + longitude + " " + latitude + ")");
			}
			dataInfo.setMetainfo(metainfo);
			//dataInfo.setStatus(DataStatus.PROCESSING.name().toLowerCase());
			dataInfo.setStatus(DataStatus.USE.name().toLowerCase());
			dataInfo.setLabel(dataName);
			dataService.insertData(dataInfo);

		} else {
			dataInfo.setDataRelationId(dataRelationId);
			dataInfo.setAssemble(assemble);
			dataInfo.setMethodType(MethodType.UPDATE);
			dataInfo.setConverterJobId(converterJobId);
			dataInfo.setSharing(sharing);
			dataInfo.setMappingType(mappingType);
			dataInfo.setDataType(dataType);
			dataInfo.setDataName(dataName);
			dataInfo.setUserId(userId);
			dataInfo.setMetainfo("{\"isPhysical\": true, \"heightReference\": \"" + heightReference + "\"}");
			dataInfo.setLatitude(latitude);
			dataInfo.setLongitude(longitude);
			dataInfo.setAltitude(altitude);
			if (isNotNull(longitude, latitude)) {
				dataInfo.setLocation("POINT(" + longitude + " " + latitude + ")");
			} else {
				dataInfo.setLocation(null);
			}
			//dataInfo.setStatus(DataStatus.PROCESSING.name().toLowerCase());
			dataInfo.setStatus(DataStatus.USE.name().toLowerCase());
			dataService.updateData(dataInfo);
		}

		return dataInfo;
	}

	/**
	 * 데이터 그룹 신규 생성의 경우 데이터 건수 update
	 * location_update_type 이 auto 일 경우 dataInfo 위치 정보로 dataGroup 위치 정보 수정
	 * @param userId	userId
	 * @param dataInfo	dataInfo
	 * @param uploadDataFile	uploadDataFile
	 */
	private void updateDataGroup(String userId, DataInfo dataInfo, UploadDataFile uploadDataFile) {
		DataGroup dataGroup = DataGroup.builder()
				.userId(userId)
				.dataGroupId(uploadDataFile.getDataGroupId())
				.build();

		DataGroup dbDataGroup = dataGroupService.getDataGroup(dataGroup);

		if (MethodType.INSERT == dataInfo.getMethodType()) {
			dataGroup.setDataCount(dbDataGroup.getDataCount() + 1);
		}

		if (LocationUdateType.AUTO == LocationUdateType.valueOf(dbDataGroup.getLocationUpdateType().toUpperCase())) {
			BigDecimal longitude = dataInfo.getLongitude();
			BigDecimal latitude = dataInfo.getLatitude();
			if (isNotNull(longitude, latitude)) {
				dataGroup.setLocation("POINT(" + longitude + " " + latitude + ")");
				dataGroup.setAltitude(dataInfo.getAltitude());
			}
		}

		dataGroupService.updateDataGroup(dataGroup);
	}

	/**
	 * dataAttribute가 존재하지 않을 경우 insert, 존재할 경우 update
	 * @param dataAttribute	dataAttribute
	 * @param dataId	dataId
	 * @param attributes	attributes
	 */
	private void upsertDataAttribute(DataAttribute dataAttribute, Long dataId, String attributes) {
		if(dataAttribute == null) {
			dataAttribute = new DataAttribute();
			dataAttribute.setDataId(dataId);
			dataAttribute.setAttributes(attributes);
			dataAttributeService.insertDataAttribute(dataAttribute);
		} else {
			dataAttribute.setAttributes(attributes);
			dataAttributeService.updateDataAttribute(dataAttribute);
		}
	}

	/**
	 * TODO 경도 -180 ~ 180, 위도 -90 ~ 90 추가
	 * 경위도 유효성 검증
	 * @param longitude	경도
	 * @param latitude	위도
	 * @return 유효한 값일 경우 true, 아닐경우 false
	 */
	private boolean isNotNull(BigDecimal longitude, BigDecimal latitude) {
		return longitude != null && latitude != null;
	}

	/**
	 * 실패한 데이터의 데이터 그룹 삭제, 데이터 그룹의 데이터 갯수 -1
	 * @param dataInfoList	dataInfoList
	 */
	private void deleteFailData(List<DataInfo> dataInfoList) {
		for(DataInfo deleteDataInfo : dataInfoList) {
			// deleteDataInfo.setUserId(converterJob.getUserId());
			// deleteDataInfo.setConverterJobId(converterJob.getConverterJobId());
			// dataService.deleteDataByConverterJob(deleteDataInfo);

			DataGroup dataGroup = new DataGroup();
			dataGroup.setUserId(deleteDataInfo.getUserId());
			dataGroup.setDataGroupId(deleteDataInfo.getDataGroupId());
			dataGroup = dataGroupService.getDataGroup(dataGroup);

			DataGroup updateDataGroup = new DataGroup();
			updateDataGroup.setUserId(dataGroup.getUserId());
			updateDataGroup.setDataGroupId(dataGroup.getDataGroupId());
			updateDataGroup.setDataCount(dataGroup.getDataCount() - 1);
			dataGroupService.updateDataGroup(updateDataGroup);
		}
	}


	private void getCityGmlLocation(String serviceDirectory, DataInfo updateDataInfo) {
		try {
			String targetDirectory = serviceDirectory + updateDataInfo.getDataGroupKey() + File.separator + DataInfo.F4D_PREFIX + updateDataInfo.getDataKey();

			File file = new File(targetDirectory + File.separator + "lonsLats.json");
			if(file.exists()) {
				byte[] jsonData = Files.readAllBytes(Paths.get(targetDirectory + File.separator + "lonsLats.json"));
				String encodingData = new String(jsonData, StandardCharsets.UTF_8);

				ObjectMapper objectMapper = new ObjectMapper();
				//read JSON like DOM Parser
				JsonNode jsonNode = objectMapper.readTree(encodingData);

				//String dataKey = jsonNode.path("data_key").asText();
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
			LogMessageSupport.printMessage(e);
		}

	}

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
			LogMessageSupport.printMessage(e);
		}

		return attribute;
	}
}
