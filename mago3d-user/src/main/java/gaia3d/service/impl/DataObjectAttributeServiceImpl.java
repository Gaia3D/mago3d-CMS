package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.data.DataObjectAttribute;
import gaia3d.persistence.DataObjectAttributeMapper;
import gaia3d.service.DataObjectAttributeService;
import gaia3d.service.DataService;
import lombok.extern.slf4j.Slf4j;

/**
 * 데이터 Object 속성 관리
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class DataObjectAttributeServiceImpl implements DataObjectAttributeService {
	
	@Autowired
	private DataService dataService;
	@Autowired
	private DataObjectAttributeMapper dataObjectAttributeMapper;
	
	/**
	 * 데이터 Object 속성 정보를 취득
	 * @param dataId
	 * @return
	 */
	@Transactional(readOnly=true)
	public DataObjectAttribute getDataObjectAttribute(Long dataId) {
		return dataObjectAttributeMapper.getDataObjectAttribute(dataId);
	}
}
