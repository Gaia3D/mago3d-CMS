package com.gaia3d.persistence;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.gaia3d.domain.DataInfo;

/**
 * Data
 * @author jeongdae
 *
 */
@Repository
public interface DataMapper {

	/**
	 * Data 수
	 * @param dataInfo
	 * @return
	 */
	Long getDataTotalCount(DataInfo dataInfo);
	
	/**
	 * data_group_id 그룹을 제외한 Data 수
	 * @param dataInfo
	 * @return
	 */
	Long getExceptDataGroupDataByGroupIdTotalCount(DataInfo dataInfo);
	
	/**
	 * Data 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getListData(DataInfo dataInfo);
	
	/**
	 * data_group_id를 제외한 Data 목록
	 * @param dataInfo
	 * @return
	 */
	List<DataInfo> getListExceptDataGroupDataByGroupId(DataInfo dataInfo);
	
	/**
	 * Data Key 중복 건수
	 * @param data_key
	 * @return
	 */
	Integer getDuplicationKeyCount(String data_key);
	
	/**
	 * Data 정보 취득
	 * @param data_id
	 * @return
	 */
	DataInfo getData(Long data_id);
	
	/**
	 * Data 등록
	 * @param dataInfo
	 * @return
	 */
	int insertData(DataInfo dataInfo);
	
	/**
	 * Data 수정
	 * @param dataInfo
	 * @return
	 */
	int updateData(DataInfo dataInfo);
	
	/**
	 * Data 테이블의 Data 그룹 정보 변경
	 * @param dataInfo
	 * @return
	 */
	int updateDataGroupData(DataInfo dataInfo);
	
	/**
	 * Data 상태 수정
	 * @param dataInfo
	 * @return
	 */
	int updateDataStatus(DataInfo dataInfo);
	
	/**
	 * Data 삭제
	 * @param data_id
	 * @return
	 */
	int deleteData(Long data_id);
}
