package gaia3d.service;

import java.util.List;

import gaia3d.domain.country.District;
import gaia3d.domain.country.SkEmd;
import gaia3d.domain.country.SkSdo;
import gaia3d.domain.country.SkSgg;

public interface SearchMapService {

	/**
	 * Sdo 목록(geom 은 제외)
	 * @return
	 */
	public List<SkSdo> getListSdoExceptGeom(District district);
	
	/**
	 * Sgg 목록(geom 은 제외)
	 * @param sdo_code
	 * @return
	 */
	public List<SkSgg> getListSggBySdoExceptGeom(District district);
	
	/**
	 * emd 목록(geom 은 제외)
	 * @param skEmd
	 * @return
	 */
	public List<SkEmd> getListEmdBySdoAndSggExceptGeom(SkEmd skEmd);
	
	/**
	 * 선택한 시도의 center point를 구함
	 * @param skSdo
	 * @return
	 */
	public String getCentroidSdo(SkSdo skSdo);
	
	/**
	 * 선택한 시군구 center point를 구함
	 * @param skSgg
	 * @return
	 */
	public String getCentroidSgg(SkSgg skSgg);
	
	/**
	 * 선택한 읍면동 center point를 구함
	 * @param skEmd
	 * @return
	 */
	public String getCentroidEmd(SkEmd skEmd);
	
	/**
	 * 선택한 시도의 BoundingBox를 구함
	 * @param skSdo
	 * @return
	 */
	public String getEnvelopSdo(SkSdo skSdo);
	
	/**
	 * 선택한 시군구 BoundingBox를 구함
	 * @param skSgg
	 * @return
	 */
	public String getEnvelopSgg(SkSgg skSgg);
	
	/**
	 * 선택한 읍면동 BoundingBox를 구함
	 * @param skEmd
	 * @return
	 */
	public String getEnvelopEmd(SkEmd skEmd);
	
	/**
	 * 행정구역 검색 총 건수
	 * @param district
	 * @return
	 */
	Long getDistrictTotalCount(District district);
	
	/**
	 * 행정 구역 검색
	 * @param district
	 * @return
	 */
	List<District> getListDistrict(District district);
}
