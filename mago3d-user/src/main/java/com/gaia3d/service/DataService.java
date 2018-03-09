package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataInfoAttribute;
import com.gaia3d.domain.DataInfoLog;

/**
 * Data 관리
 * @author jeongdae
 *
 */
public interface DataService {
	
	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	Long getDataTotalCount(DataInfo dataInfo);
	
	/**
	 * 데이터 상태별 통계 정보
	 * @param status
	 * @return
	 */
	Long getDataTotalCountByStatus(String status);
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getListData(DataInfo dataInfo);
	
	/**
	 * 프로젝트별 Data 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getListDataByProjectId(DataInfo dataInfo);
	
	/**
	 * Data 정보 취득
	 * @param data_id
	 * @return
	 */
	DataInfo getData(Long data_id);
	
	/**
	 * Data 정보 취득
	 * @param dataInfo
	 * @return
	 */
	DataInfo getDataByDataKey(DataInfo dataInfo);
	
	/**
	 * Data Attribute 정보 취득
	 * @param data_id
	 * @return
	 */
	DataInfoAttribute getDataAttribute(Long data_id);
	
	/**
	 * 데이터 공간 정보 변경 요청
	 * @return
	 */
	int updateDataLocationAndRotation(DataInfoLog dataInfoLog);
}
