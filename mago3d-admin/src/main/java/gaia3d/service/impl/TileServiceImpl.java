package gaia3d.service.impl;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.amqp.AmqpException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.ServerTarget;
import gaia3d.domain.common.TileMessage;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfoSimple;
import gaia3d.domain.tile.TileDataGroup;
import gaia3d.domain.tile.TileDataInfo;
import gaia3d.domain.tile.TileInfo;
import gaia3d.domain.tile.TileLog;
import gaia3d.domain.tile.TileStatus;
import gaia3d.domain.uploaddata.UploadDirectoryType;
import gaia3d.persistence.TileMapper;
import gaia3d.service.AMQPPublishService;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataService;
import gaia3d.service.TileService;
import gaia3d.support.LogMessageSupport;
import gaia3d.utils.FileUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class TileServiceImpl implements TileService {

	@Autowired
	private AMQPPublishService aMQPPublishService;

	@Autowired
	private DataService dataService;

	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private ObjectMapper objectMapper;

	@Autowired
	private PropertiesConfig propertiesConfig;

	@Autowired
	private TileMapper tileMapper;

	/**
	 * 스마트 타일링 총건수
	 * @param tileInfo
	 * @return
	 */
	public Long getTileTotalCount(TileInfo tileInfo) {
		return tileMapper.getTileTotalCount(tileInfo);
	}
	
	/**
     * 스마트 타일링 목록
     * @return
     */
	@Transactional(readOnly = true)
	public List<TileInfo> getListTile(TileInfo tileInfo) {
		return tileMapper.getListTile(tileInfo);
	}

	/**
     * 스마트 타일링 정보 조회
     * @param tileInfo
	 * @return
	 */
	@Transactional(readOnly = true)
	public TileInfo getTile(TileInfo tileInfo) {
		return tileMapper.getTile(tileInfo);
	}

	/**
     * 스마트 타일링 Key 중복 확인
     * @param tileInfo
     * @return
     */
	@Transactional(readOnly = true)
	public Boolean isTileKeyDuplication(TileInfo tileInfo) {
		return tileMapper.isTileKeyDuplication(tileInfo);
	}
	
	/**
     * 스마트 타일링 그룹 등록
     * @param tileInfo
     * @return
     */
    @Transactional
	public int insertTile(TileInfo tileInfo) {
    	String checkIds = tileInfo.getDataGroupCheckIds();
		String[] dataGroups = checkIds.split(",");

		tileMapper.insertTile(tileInfo);
		Integer tileId = tileInfo.getTileId();
		String tilePath = tileInfo.getTilePath();

		// TODO 스트림 처리 해야 함
		for(String dataGroupId : dataGroups) {
			if(StringUtils.isEmpty(dataGroupId)) continue;

			TileDataGroup tileDataGroup = new TileDataGroup();
			tileDataGroup.setTileId(tileId);
			tileDataGroup.setDataGroupId(Integer.parseInt(dataGroupId));
			tileDataGroup.setTilePath(tilePath);

			tileMapper.insertTileDataGroup(tileDataGroup);
		}

		TileLog tileLog = new TileLog();
		tileLog.setTileId(tileId);
		tileLog.setUserId(tileInfo.getUserId());
		// 스마트 타일용 json 파일 생성
		writeTileTargetDatasInFile(tileInfo, dataGroups, tileLog);

		tileMapper.insertTileLog(tileLog);

		TileMessage tileMessage = new TileMessage();
		tileMessage.setTileId(tileId);
		tileMessage.setTileKey(tileInfo.getTileKey());
		tileMessage.setTileName(tileInfo.getTileName());
		tileMessage.setTilePath(propertiesConfig.getAdminTileServicePath() + tileInfo.getTileKey());
		tileMessage.setFilePath(tileLog.getFilePath());
		tileMessage.setFileName(tileLog.getFileRealName());
		tileMessage.setServerTarget(ServerTarget.ADMIN);
		// 스마트 타일 생성
		executeTileMaker(tileMessage);

		return 0;
    }

	private void writeTileTargetDatasInFile(TileInfo tileInfo, String[] dataGroups, TileLog tileLog) {
    	Integer tileId = tileInfo.getTileId();

		// tile json 생성 디렉토리
		String makedDirectory = FileUtils.makeDirectory(tileId.toString(), UploadDirectoryType.YEAR_MONTH, propertiesConfig.getTileMetaDir());
		String tileJsonFileName = tileInfo.getTileKey() + ".json";

		log.info("-------------------------------------------------------");
		log.info("----------- tileJonsDirectory = {}", makedDirectory);
		log.info("----------- tileJsonFileName = {}", tileJsonFileName);
		log.info("-------------------------------------------------------");

		tileLog.setFilePath(makedDirectory);
		tileLog.setFileRealName(tileJsonFileName);

		TileDataInfo tileDataInfo = new TileDataInfo();
		tileDataInfo.setTileId(tileId);
		tileDataInfo.setTileName(tileInfo.getTileName());
		tileDataInfo.setTileKey(tileInfo.getTileKey());

		// f4d 파일 위치
		String rootPath = propertiesConfig.getDataServiceDir();
		List<TileDataGroup> tileDataGroupList = new ArrayList<>();
		for(String dataGroupId : dataGroups) {
			DataGroup dataGroup = dataGroupService.getDataGroup(DataGroup.builder().dataGroupId(Integer.valueOf(dataGroupId)).build());

			TileDataGroup tileDataGroup = new TileDataGroup();
			tileDataGroup.setTileId(tileId);
			tileDataGroup.setDataGroupId(Integer.parseInt(dataGroupId));
			tileDataGroup.setDataGroupKey(dataGroup.getDataGroupKey());

			// path 와 File.seperator 의 차이점 때문에 변환
			String dataGroupFilePath = FileUtils.getFilePath(dataGroup.getDataGroupPath());
			tileDataGroup.setAbsoluteDataGroupPath(rootPath + dataGroupFilePath);

			List<DataInfoSimple> dataInfoList = dataService.getListAllDataByDataGroupId(Integer.valueOf(dataGroupId));
			tileDataGroup.setDataInfoList(dataInfoList);

			tileDataGroupList.add(tileDataGroup);
		}

		tileDataInfo.setTileDataGroupList(tileDataGroupList);

		try (	FileWriter fw = new FileWriter(new File(makedDirectory + tileJsonFileName), StandardCharsets.UTF_8);
			 	BufferedWriter writer = new BufferedWriter(fw)) {
				writer.append(objectMapper.writeValueAsString(tileDataInfo));
				writer.newLine();
		} catch (IOException e) {
			LogMessageSupport.printMessage(e);
		}

	}

	/**
	 * 스마트 타일링 실행
	 * @param tileMessage
	 */
	private void executeTileMaker(TileMessage tileMessage) {
		try {
			aMQPPublishService.tileMessageSend(propertiesConfig.getRabbitmqTilerExchange(), propertiesConfig.getRabbitmqTilerRoutingKey(), tileMessage);
		} catch(AmqpException e) {

			LogMessageSupport.printMessage(e, "@@@@@@@@@@@@ AmqpException. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
	}
    
    /**
	 * TODO tile path update 하는 로직
	 * json 파일이 있으면 삭제 하고 만들지, 백업 하고 만들지... 그 로직이 빠져 있음
	 * 스마트 타일링 수정
	 * @param tileInfo
	 * @return
	 */
    @Transactional
	public int updateTile(TileInfo tileInfo) {
		String checkIds = tileInfo.getDataGroupCheckIds();
		String[] dataGroups = checkIds.split(",");

		tileMapper.deleteTileDataGroup(TileDataGroup.builder().tileId(tileInfo.getTileId()).build());

		tileMapper.updateTile(tileInfo);
		Integer tileId = tileInfo.getTileId();
		String tilePath = tileInfo.getTilePath();

		for(String dataGroupId : dataGroups) {
			if(StringUtils.isEmpty(dataGroupId)) continue;

			TileDataGroup tileDataGroup = new TileDataGroup();
			tileDataGroup.setTileId(tileId);
			tileDataGroup.setDataGroupId(Integer.parseInt(dataGroupId));
			tileDataGroup.setTilePath(tilePath);

			tileMapper.insertTileDataGroup(tileDataGroup);
		}

		TileLog tileLog = new TileLog();
		tileLog.setTileId(tileId);
		tileLog.setUserId(tileInfo.getUserId());
		// 스마트 타일용 json 파일 생성
		writeTileTargetDatasInFile(tileInfo, dataGroups, tileLog);

		tileMapper.insertTileLog(tileLog);

		TileMessage tileMessage = new TileMessage();
		tileMessage.setTileId(tileId);
		tileMessage.setTileKey(tileInfo.getTileKey());
		tileMessage.setTileName(tileInfo.getTileName());
		tileMessage.setTilePath(propertiesConfig.getAdminTileServicePath() + tileInfo.getTileKey());
		tileMessage.setFilePath(tileLog.getFilePath());
		tileMessage.setFileName(tileLog.getFileRealName());
		// 스마트 타일 생성
		executeTileMaker(tileMessage);

		return 0;
    }

    /**
	 * 스마트 타일링 삭제
	 * @param tileInfo
	 * @return
	 */
    @Transactional
	public int deleteTile(TileInfo tileInfo) {
    	tileMapper.deleteTile(tileInfo);

		TileDataGroup tileDataGroup = new TileDataGroup();
		tileDataGroup.setTileId(tileInfo.getTileId());

		updateDataGroupTiling(tileInfo, false);

		return tileMapper.deleteTileDataGroup(tileDataGroup);
    }

	/**
	 * 스마트 타일링 결과 갱신
	 * @param tileInfo
	 * @return
	 */
	@Transactional
	public int updateTileInfo(TileInfo tileInfo) {

		TileDataGroup tileDataGroup = TileDataGroup.builder()
				.tileId(tileInfo.getTileId())
				.tilePath(tileInfo.getTilePath())
				.build();
		// 타일 데이터 그룹 타일 경로 갱신
		tileMapper.updateTileDataGroup(tileDataGroup);

		if(TileStatus.SUCCESS == TileStatus.valueOf(tileInfo.getStatus().toUpperCase()))
		{
			updateDataGroupTiling(tileInfo, true);
		}

		TileLog tileLog = TileLog.builder()
				.tileId(tileInfo.getTileId())
				.status(tileInfo.getStatus())
				.userId(tileInfo.getUserId())
				.build();
		// 스마트 타일링 로그 상태 갱신
		tileMapper.updateTileLog(tileLog);

		// 스마트 타일링 타일 경로, 상태 갱신
		return tileMapper.updateTile(tileInfo);
	}

	/**
	 * 데이터 그룹 타일 여부 갱신
	 * @param tileInfo 타일 정보
	 * @param tiling 타일링 여부
	 */
	private void updateDataGroupTiling(TileInfo tileInfo, boolean tiling) {
		List<TileDataGroup> dataGroups = tileMapper.getListTileDataGroup(tileInfo);
		for (TileDataGroup group : dataGroups) {
			DataGroup dataGroup = DataGroup.builder()
					.dataGroupId(group.getDataGroupId())
					.tiling(tiling)
					.build();
			// 데이터 그룹 타일 여부 갱신
			dataGroupService.updateDataGroup(dataGroup);
		}
	}

}
