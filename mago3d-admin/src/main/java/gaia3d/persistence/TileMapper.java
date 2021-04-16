package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.tile.TileDataGroup;
import gaia3d.domain.tile.TileInfo;
import gaia3d.domain.tile.TileLog;

@Repository
public interface TileMapper {

	/**
	 * 스마트 타일 총건수
	 * @param tileInfo
	 * @return
	 */
	Long getTileTotalCount(TileInfo tileInfo);

	/**
	 * 스마트 타일 목록
	 * @param tileInfo
	 * @return
	 */
	List<TileInfo> getListTile(TileInfo tileInfo);

	/**
	 * 스마트 타일 정보 조회
	 * @param tileInfo
	 * @return
	 */
	TileInfo getTile(TileInfo tileInfo);

	/**
	 * 스마트 타일에 해당하는 데이터 그룹 목록 조회
	 * @param tileInfo
	 * @return
	 */
	List<TileDataGroup> getListTileDataGroup(TileInfo tileInfo);

	/**
	 * 스마트 타일 Key 중복 확인
	 * @param tileInfo
	 * @return
	 */
	Boolean isTileKeyDuplication(TileInfo tileInfo);

	/**
	 * 스마트 타일 등록
	 * @param tileInfo
	 * @return
	 */
	int insertTile(TileInfo tileInfo);

	/**
	 * 스마트 타일 데이터 그룹 등록
	 * @param tileDataGroup
	 * @return
	 */
	int insertTileDataGroup(TileDataGroup tileDataGroup);

	/**
	 * 스마트 타일링 변경 이력
	 * @param tileLog
	 * @return
	 */
	int insertTileLog(TileLog tileLog);

	/**
	 * 스마트 타일 수정
	 * @param tileInfo
	 * @return
	 */
	int updateTile(TileInfo tileInfo);

	/**
	 * 스마트 타일 데이터 그룹 수정
	 * @param tileDataGroup
	 * @return
	 */
	int updateTileDataGroup(TileDataGroup tileDataGroup);

	/**
	 * 스마트 타일링 변경 이력 수정
	 * @param tileLog
	 * @return
	 */
	int updateTileLog(TileLog tileLog);

	/**
	 * 스마트 타일 삭제
	 * @param tileInfo
	 * @return
	 */
	int deleteTile(TileInfo tileInfo);

	/**
	 * 스마트 타일 데이터 그룹 삭제
	 * @param tileDataGroup
	 * @return
	 */
	int deleteTileDataGroup(TileDataGroup tileDataGroup);
}
