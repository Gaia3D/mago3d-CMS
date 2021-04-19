package gaia3d.persistence;

import org.springframework.stereotype.Repository;

import gaia3d.domain.data.DataObjectAttribute;
import gaia3d.domain.data.DataObjectAttributeFileInfo;


/**
 * 데이터 속성 파일 관리
 * @author jeongdae
 *
 */
@Repository
public interface DataObjectAttributeMapper {
	
	/**
	 * 데이터 Object 속성 정보를 취득
	 * @param dataId
	 * @return
	 */
	DataObjectAttribute getDataObjectAttribute(Long dataId);
	
	/**
	 * 데이터 Object 속성 정보 등록
	 * @param dataObjectAttribute
	 * @return
	 */
	int insertDataObjectAttribute(DataObjectAttribute dataObjectAttribute);
	
	/**
	 * Data Object Attribute 파일 정보 등록
	 * @param dataObjectAttributeFileInfo
	 * @return
	 */
	int insertDataObjectAttributeFileInfo(DataObjectAttributeFileInfo dataObjectAttributeFileInfo);
	
	/**
	 * 데이터 Object 속성 정보 수정
	 * @param dataObjectAttribute
	 * @return
	 */
	int updateDataObjectAttribute(DataObjectAttribute dataObjectAttribute);
	
	/**
	 * 데이터 Object 속성 파일 정보 수정
	 * @param dataObjectAttributeFileInfo
	 * @return
	 */
	int updateDataObjectAttributeFileInfo(DataObjectAttributeFileInfo dataObjectAttributeFileInfo);
	
}
