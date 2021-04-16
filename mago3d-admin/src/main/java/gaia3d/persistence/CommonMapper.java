package gaia3d.persistence;

import org.springframework.stereotype.Repository;

/**
 * 공통 처리
 * @author jeongdae
 *
 */
@Repository
public interface CommonMapper {

	/**
	 * 테이블 존재 유무 체크
	 * @param tableName
	 * @return
	 */
	Boolean isTableExist(String tableName);

}
