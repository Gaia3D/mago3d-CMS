package gaia3d.service;

import java.util.List;

import gaia3d.domain.tile.TileInfo;

public interface TileService {
	
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
	 * 스마트 타일 수정
	 * @param tileInfo
	 * @return
	 */
	int updateTile(TileInfo tileInfo);

	/**
	 * 스마트 타일 삭제
	 * @param tileInfo
	 * @return
	 */
	int deleteTile(TileInfo tileInfo);

	/**
	 * 스마트 타일 생성 후 결과 갱신
	 * @param tileInfo
	 * @return
	 */
	int updateTileInfo(TileInfo tileInfo);

}
