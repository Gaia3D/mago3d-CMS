package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.country.District;
import gaia3d.domain.country.SkEmd;
import gaia3d.domain.country.SkSdo;
import gaia3d.domain.country.SkSgg;
import gaia3d.persistence.SearchMapMapper;
import gaia3d.service.SearchMapService;

@Service
public class SearchMapServiceImpl implements SearchMapService {

	@Autowired
	private SearchMapMapper searchMapMapper;
	
	/**
	 * Sdo 목록(geom 은 제외)
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<SkSdo> getListSdoExceptGeom(District district) {
		return searchMapMapper.getListSdoExceptGeom(district);
	}
	
	/**
	 * Sgg 목록(geom 은 제외)
	 * @param sdo_code
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<SkSgg> getListSggBySdoExceptGeom(District district) {
		return searchMapMapper.getListSggBySdoExceptGeom(district);
	}
	
	/**
	 * emd 목록(geom 은 제외)
	 * @param skEmd
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<SkEmd> getListEmdBySdoAndSggExceptGeom(SkEmd skEmd) {
		return searchMapMapper.getListEmdBySdoAndSggExceptGeom(skEmd);
	}
	
	/**
	 * 선택한 시도의 center point를 구함
	 * @param skSdo
	 * @return
	 */
	@Transactional(readOnly=true)
	public String getCentroidSdo(SkSdo skSdo) {
		return searchMapMapper.getCentroidSdo(skSdo);
	}
	
	/**
	 * 선택한 시군구 center point를 구함
	 * @param skSgg
	 * @return
	 */
	@Transactional(readOnly=true)
	public String getCentroidSgg(SkSgg skSgg) {
		return searchMapMapper.getCentroidSgg(skSgg);
	}
	
	/**
	 * 선택한 읍면동 center point를 구함
	 * @param skEmd
	 * @return
	 */
	@Transactional(readOnly=true)
	public String getCentroidEmd(SkEmd skEmd) {
		return searchMapMapper.getCentroidEmd(skEmd);
	}
	
	/**
	 * 선택한 시도의 BoundingBox를 구함
	 * @param skSdo
	 * @return
	 */
	@Override
	public String getEnvelopSdo(SkSdo skSdo) {
		return searchMapMapper.getEnvelopSdo(skSdo);
	}

	/**
	 * 선택한 시군구 BoundingBox를 구함
	 * @param skSgg
	 * @return
	 */
	@Override
	public String getEnvelopSgg(SkSgg skSgg) {
		return searchMapMapper.getEnvelopSgg(skSgg);
	}

	/**
	 * 선택한 읍면동 BoundingBox를 구함
	 * @param skEmd
	 * @return
	 */
	@Override
	public String getEnvelopEmd(SkEmd skEmd) {
		return searchMapMapper.getEnvelopEmd(skEmd);
	}
	
	/**
	 * 행정구역 검색 총 건수
	 * @param district
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getDistrictTotalCount(District district) {
		return searchMapMapper.getDistrictTotalCount(district);
	}
	
	/**
	 * 행정 구역 검색
	 * @param district
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<District> getListDistrict(District district) {
		return searchMapMapper.getListDistrict(district);
	}

}