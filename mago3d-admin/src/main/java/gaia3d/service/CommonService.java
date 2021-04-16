package gaia3d.service;

/**
 * 공통 처리
 */
public interface CommonService {

    /**
     * 테이블 존재 유무 체크
     * @param tableName
     * @return
     */
    Boolean isTableExist(String tableName);
}
