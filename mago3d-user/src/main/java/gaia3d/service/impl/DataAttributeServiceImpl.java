package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.data.DataAttribute;
import gaia3d.persistence.DataAttributeMapper;
import gaia3d.service.DataAttributeService;

/**
 * 데이터 속성 관리
 * @author jeongdae
 *
 */
@Service
public class DataAttributeServiceImpl implements DataAttributeService {
	
	@Autowired
	private DataAttributeMapper dataAttributeMapper;
	
	/**
	 * 데이터 속성 정보를 취득
	 * @param dataId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataAttribute getDataAttribute(Long dataId) {
		return dataAttributeMapper.getDataAttribute(dataId);
	}
	
	/**
	 * 데이터 속성 등록
	 * @param dataAttribute
	 * @return
	 */
	@Transactional
	public int insertDataAttribute(DataAttribute dataAttribute) {
		return dataAttributeMapper.insertDataAttribute(dataAttribute);
	}
	
	/**
	 * 데이터 속성 수정
	 * @param dataAttribute
	 * @return
	 */
	@Transactional
	public int updateDataAttribute(DataAttribute dataAttribute) {
		return dataAttributeMapper.updateDataAttribute(dataAttribute);
	}
}
