package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.persistence.DataMapper;
import com.gaia3d.service.DataService;

/**
 * Data
 * @author jeongdae
 *
 */
@Service
public class DataServiceImpl implements DataService {

	@Autowired
	private DataMapper dataMapper;
	
	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDataTotalCount(DataInfo dataInfo) {
		return dataMapper.getDataTotalCount(dataInfo);
	}
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListData(DataInfo dataInfo) {
		return dataMapper.getListData(dataInfo);
	}
	
	/**
	 * 프로젝트별 Data 목록
	 * @param dataInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<DataInfo> getListDataByProjectId(DataInfo dataInfo) {
		return dataMapper.getListDataByProjectId(dataInfo);
	}
	
	/**
	 * Data 정보 취득
	 * @param data_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataInfo getData(Long data_id) {
		return dataMapper.getData(data_id);
	}
}
