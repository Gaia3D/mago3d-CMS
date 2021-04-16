package gaia3d.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.data.DataRelationInfo;
import gaia3d.persistence.DataRelationMapper;
import gaia3d.service.DataRelationService;
import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class DataRelationServiceImpl implements DataRelationService {

    private final DataRelationMapper dataRelationMapper;

    @Transactional(readOnly = true)
    @Override
    public DataRelationInfo getDataRelation(Long dataRelationId) {
        return dataRelationMapper.getDataRelation(dataRelationId);
    }

    @Transactional
    @Override
    public int insertDataRelation(DataRelationInfo dataRelationInfo) {
        int result = 0;
        DataRelationInfo data = dataRelationMapper.getDataRelation(dataRelationInfo.getDataRelationId());
        if (data == null) {
            result = dataRelationMapper.insertDataRelation(dataRelationInfo);
        }
        return result;
    }

//    @Transactional
//    @Override
//    public int updateDataRelation(DataRelationInfo dataRelationInfo) {
//        return dataRelationMapper.updateDataRelation(dataRelationInfo);
//    }

    @Transactional
    @Override
    public int deleteDataRelation(Long dataRelationId) {
        return dataRelationMapper.deleteDataRelation(dataRelationId);
    }
}
