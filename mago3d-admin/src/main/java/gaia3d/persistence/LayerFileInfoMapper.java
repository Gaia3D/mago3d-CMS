package gaia3d.persistence;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import gaia3d.domain.layer.LayerFileInfo;

/**
 * layer shape 파일 정보
 * @author Cheon JeongDae
 *
 */
@Repository
public interface LayerFileInfoMapper {
	
	/**
	 * 레이어 shape 파일 version
	 * @param layerFileInfoId
	 * @return
	 */
	Integer getLayerShapeFileVersion(Integer layerFileInfoId);
	
	/**
	 * layerId에 해당하는 모든 파일 경로 목록 
	 * @param layerId
	 * @return
	 */
	List<String> getListLayerFilePath(Integer layerId);
	
	/**
	 * layer shape 파일 목록
	 * @return
	 */
	List<LayerFileInfo> getListLayerFileInfo(Integer layerId);
	
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
	 * 레이어별 shape 파일 version 최대값 + 1 을 취득
	 * @param layerId
	 * @return
	 */
	Integer getMaxFileVersion(Integer layerId);
	
	/**
	 * layer shape 파일이 있는지 확인
	 * @param layerId
	 * @return
	 */
	boolean isLayerFileInfoExist(Integer layerId);
	
	/**
	 * layer shape 파일 업데이트 날짜
	 * @param layerFileInfoId
	 * @return
	 */
	String getLayerShapeFileUpdateDate(Integer layerFileInfoId);
	
	/**
	 * 레이어 이력내 활성화 된 데이터 정보를 취득
	 * @param layerId
	 * @return
	 */
	LayerFileInfo getEnableLayerFileInfo(Integer layerId);
	
	/**
	 * layer shape 파일 정보 등록
	 * @param layerFileInfo
	 * @return
	 */
	int insertLayerFileInfoMapper(LayerFileInfo layerFileInfo);
	
	/**
	 * layerId와 일치하는 모든 shape 파일의 상태를 layer 비활성화로 함
	 * @param layerId
	 * @return
	 */
	int updateLayerFileInfoAllDisabledByLayerId(Integer layerId);
	
	/**
	 * 동일 그룹 layerFileInfo 정보 활성화로 수정
	 * @param layerFileInfoGroupMap
	 * @return
	 */
	int updateLayerFileInfoGroup(Map<String, Object> layerFileInfoGroupMap);
	
	/**
	 * layer shape 파일 정보 수정
	 * @param layerFileInfo
	 * @return
	 */
	int updateLayerFileInfo(LayerFileInfo layerFileInfo);
	
	/**
	 * layerFileInfoGroupId에 의한 layer shape 파일 정보 수정
	 * @param layerFileInfo
	 * @return
	 */
	int updateLayerFileInfoByGroupId(LayerFileInfo layerFileInfo);
	
	/**
	 * 해당 레이어의 이전 데이터를 전부 비활성화 상태로 수정
	 * @param tableName
	 * @return
	 */
	int updateShapePreDataDisable(String tableName);
	
	/**
	 * org2org를 이용해서 생성한 테이블을 데이터 version 갱신
	 * @param map
	 * @return
	 */
	int updateOgr2OgrDataFileVersion(Map<String, String> map);
	
	/**
	 * shape 테이블 데이터 상태 변경
	 * @param map
	 * @return
	 */
	int updateOgr2OgrStatus(Map<String, String> map);
	
	/**
	 * 레이어 삭제
	 * @param layerId
	 * @return
	 */
	int deleteLayerFileInfo(Integer layerId);
	
	/**
	 * group id 로 레이어 파일 이력을 삭제
	 * @param deleteLayerFileInfoGroupId
	 * @return
	 */
	int deleteLayerFileInfoByGroupId(Integer layerFileInfoGroupId);
}
