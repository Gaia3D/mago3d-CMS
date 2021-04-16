package gaia3d.service;

import gaia3d.domain.data.DataObjectAttribute;
import gaia3d.domain.data.DataObjectAttributeFileInfo;

/**
 * 데이터 파일 속성 관리
 * @author jeongdae
 *
 */
public interface DataObjectAttributeService {
	
	/**
	 * 데이터 Object 속성 정보를 취득
	 * @param dataId
	 * @return
	 */
	DataObjectAttribute getDataObjectAttribute(Long dataId);
	
	/**
	 * Data Object Attribute 등록
	 * @param dataId
	 * @param dataObjectAttributeFileInfo
	 * @return
	 */
	DataObjectAttributeFileInfo insertDataObjectAttribute(Long dataId, DataObjectAttributeFileInfo dataObjectAttributeFileInfo);
}
