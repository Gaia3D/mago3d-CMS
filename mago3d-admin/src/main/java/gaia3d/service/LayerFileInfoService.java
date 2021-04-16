package gaia3d.service;

import java.util.List;
import java.util.Map;

import gaia3d.domain.layer.LayerFileInfo;

public interface LayerFileInfoService {

	/**
	 * layer shape 파일 목록
	 * @return
	 */
	List<LayerFileInfo> getListLayerFileInfo(Integer layerId);
	
	/**
	 * layerId에 해당하는 모든 파일 경로 목록 
	 * @param layerId
	 * @return
	 */
	List<String> getListLayerFilePath(Integer layerId);
	
	/**
	 * 파일 정보 취득
	 * @param layerFileInfoId
	 * @return
	 */
	LayerFileInfo getLayerFileInfo(Integer layerFileInfoId);
	
	/**
	 * layer shape 파일 그룹 정보 취득
	 * @param layerFileInfoGroupId
	 * @return
	 */
	List<LayerFileInfo> getLayerFileInfoGroup(Integer layerFileInfoGroupId);
	
	/**
	 * layer shape 파일 version
	 * @param layerFileInfoId
	 * @return
	 */
	Integer getLayerShapeFileVersion(Integer layerFileInfoId);
	
	/**
	 * 레이어 이력이 존재하는지 검사
	 * @param layerId
	 * @return
	 */
	boolean isLayerFileInfoExist(Integer layerId);
	
	/**
	 * 레이어 이력내 활성화 된 데이터 정보를 취득
	 * @param layerId
	 * @return
	 */
	LayerFileInfo getEnableLayerFileInfo(Integer layerId);

	/**
	 * layer shape 파일 정보 수정
	 * @param layerFileInfo
	 * @return
	 * @throws Exception 
	 */
	int updateLayerFileInfo(LayerFileInfo layerFileInfo);
	
	/**
	 * org2org를 이용해서 생성한 테이블을 데이터 version 갱신
	 * @param map
	 * @return
	 */
	int updateOgr2OgrDataFileVersion(Map<String, String> map);
	
	/**
	 * group id 로 레이어 파일 이력을 삭제
	 * @param deleteLayerFileInfoGroupId
	 * @return
	 */
	int deleteLayerFileInfoByGroupId(Integer deleteLayerFileInfoGroupId);
	
}
