package gaia3d.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.persistence.CommonMapper;
import gaia3d.service.CommonService;
import lombok.extern.slf4j.Slf4j;

/**
 * 공통 처리
 */
@Slf4j
@Service
public class CommonServiceImpl implements CommonService {

    @Autowired
    private CommonMapper commonMapper;

    /**
     *
     * @param tableName
     * @return
     */
    @Transactional(readOnly=true)
    public Boolean isTableExist(String tableName) {
        return commonMapper.isTableExist(tableName);
    }
}
