package gaia3d.controller.rest;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.Key;
import gaia3d.domain.common.Pagination;
import gaia3d.domain.country.District;
import gaia3d.domain.country.SkEmd;
import gaia3d.domain.country.SkSdo;
import gaia3d.domain.country.SkSgg;
import gaia3d.service.SearchMapService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/searchmap")
@RestController
public class SearchMapRestController {

	@Autowired
	private SearchMapService searchMapService;

	/*HttpServletRequest request;
	String lang = (String)request.getSession().getAttribute(Key.LANG.name());*/

	/**
	 * 시도 목록
	 * @return
	 */
	@GetMapping("/sdos")
	public Map<String, Object> getListSdo(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		District district = new District();
		String lang = (String)request.getSession().getAttribute(Key.LANG.name());
		if(lang!=null) {
			district.setKoname("enname");
		}else {
			district.setKoname("koname");
		}
		List<SkSdo> sdoList = searchMapService.getListSdoExceptGeom(district);
		int statusCode = HttpStatus.OK.value();
		
		result.put("sdoList", sdoList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시군구 목록
	 * @param sdoCode
	 * @return
	 */
	@GetMapping("/sdos/{sdoCode:[0-9]+}/sggs")
	public Map<String, Object> getListSggBySdo(HttpServletRequest request, @PathVariable String sdoCode) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		District district = new District();
		district.setSidoCd(sdoCode);
	/*	String lang = (String)request.getSession().getAttribute(Key.LANG.name());
		if(lang!=null) {
			district.setName("enname");
		}else {
			district.setName("koname");
		}*/
		
		List<SkSgg> sggList = searchMapService.getListSggBySdoExceptGeom(district);
		int statusCode = HttpStatus.OK.value();
		
		result.put("sggList", sggList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 읍면동 목록 TODO PathVariable 대신 SkEmd으로 받고 싶다.
	 * @param sdoCode
	 * @param sggCode
	 * @return
	 */
	@GetMapping("/sdos/{sdoCode:[0-9]+}/sggs/{sggCode:[0-9]+}/emds")
	public Map<String, Object> getListEmdBySdoAndSgg(HttpServletRequest request, @PathVariable String sdoCode, @PathVariable String sggCode) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		String lang = (String)request.getSession().getAttribute(Key.LANG.name());
		
		SkEmd mapEmd = new SkEmd();
		mapEmd.setSdoCode(sdoCode);
		mapEmd.setSggCode(sggCode);

		List<SkEmd> emdList = searchMapService.getListEmdBySdoAndSggExceptGeom(mapEmd);
		int statusCode = HttpStatus.OK.value();
		
		result.put("emdList", emdList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 선택 한 위치의 center point를 구함
	 * 
	 * @param skEmd
	 * @return
	 */
	@GetMapping("/centroids")
	public Map<String, Object> getCentroid(SkEmd skEmd) {
		log.info("@@@@ skEmd = {}", skEmd);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
		String centerPoint = null;
		if (skEmd.getLayerType() == 1) {
			// 시도
			SkSdo skSdo = new SkSdo();
			skSdo.setKoname(skEmd.getKoname());
			skSdo.setBjcd(skEmd.getBjcd());
			centerPoint = searchMapService.getCentroidSdo(skSdo);
			log.info("@@@@ sdo center point {}", centerPoint);
		} else if (skEmd.getLayerType() == 2) {
			// 시군구
			SkSgg skSgg = new SkSgg();
			skSgg.setKoname(skEmd.getKoname());
			skSgg.setBjcd(skEmd.getBjcd());
			centerPoint = searchMapService.getCentroidSgg(skSgg);
			log.info("@@@@ sgg center point {}", centerPoint);
		} else if (skEmd.getLayerType() == 3) {
			// 읍면동
			centerPoint = searchMapService.getCentroidEmd(skEmd);
			log.info("@@@@ emd center point {}", centerPoint);
		}

		String[] location = centerPoint.substring(centerPoint.indexOf("(") + 1, centerPoint.indexOf(")")).split(" ");
		int statusCode = HttpStatus.OK.value();
		
		result.put("longitude", location[0]);
		result.put("latitude", location[1]);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 선택 한 위치의 BoundingBox를 구함
	 * 
	 * @param skEmd
	 * @return
	 */
	@GetMapping("/envelope")
	public Map<String, Object> getEnvelope(SkEmd skEmd) {
		log.info("@@@@ skEmd = {}", skEmd);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		// TODO 여기 들어 오지 않음. PathVariable 은 불칠전해서 이렇게 하고 싶음
		String bboxWkt = null;
		if (skEmd.getLayerType() == 1) {
			// 시도
			SkSdo skSdo = new SkSdo();
			skSdo.setKoname(skEmd.getKoname());
			skSdo.setBjcd(skEmd.getBjcd());
			System.out.println(skSdo.getBjcd());
			bboxWkt = searchMapService.getEnvelopSdo(skSdo);
			log.info("@@@@ sdo bbox {}", bboxWkt);
		} else if (skEmd.getLayerType() == 2) {
			// 시군구
			SkSgg skSgg = new SkSgg();
			skSgg.setKoname(skEmd.getKoname());
			skSgg.setBjcd(skEmd.getBjcd());
			bboxWkt = searchMapService.getEnvelopSgg(skSgg);
			log.info("@@@@ sgg bbox {}", bboxWkt);
		} else if (skEmd.getLayerType() == 3) {
			// 읍면동
			System.out.println(skEmd.getBjcd());
			bboxWkt = searchMapService.getEnvelopEmd(skEmd);
			log.info("@@@@ emd bbox {}", bboxWkt);
		}
		
		if (bboxWkt == null) {
			bboxWkt = "POLYGON((124.609708885853 33.1137120723124,124.609708885853 38.6151323380178,131.872766214216 38.6151323380178,131.872766214216 33.1137120723124,124.609708885853 33.1137120723124))";
		}

		bboxWkt = bboxWkt.replace("POLYGON((", "");
		bboxWkt = bboxWkt.replace("))", "");
		
		String[] points = bboxWkt.split(",");
		String[] minPoint = new String[2];
		String[] maxPoint = new String[2];
		
		minPoint[0] = points[0].split(" ")[0];
		minPoint[1] = points[0].split(" ")[1];
		
		maxPoint[0] = points[2].split(" ")[0];
		maxPoint[1] = points[2].split(" ")[1];
		
		int statusCode = HttpStatus.OK.value();
		
		result.put("minPoint", minPoint);
		result.put("maxPoint", maxPoint);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 행정구역
	 * @param district
	 * @return
	 */
	@GetMapping("/district")
	public Map<String, Object> districts(HttpServletRequest request, District district, @RequestParam(defaultValue = "1") String pageNo) {

		// TODO 아직 정리가 안되서.... fullTextSearch라는 변수를 임시로 추가해 두었음. 다음에 고쳐야 함
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		String lang = (String)request.getSession().getAttribute(Key.LANG.name());
		if(lang!=null) {
			district.setKoname("enname");
		}else {
			district.setKoname("koname");
		}
		
		log.info("@@ district = {}", district);
		district.setSearchValue(district.getFullTextSearch());
		district.setSearchWord(district.getFullTextSearch());
		String searchKey = request.getParameter("searchKey");

		result.put("searchWord", district.getFullTextSearch());
		result.put("searchKey", searchKey);

		if (district.getSearchValue() == null || "".equals(district.getSearchValue())) {
			log.info("@@@@@ message = {}", "search.word.invalid");
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "search.word.invalid");
			result.put("message", message);
            return result;
		}

		long totalCount = searchMapService.getDistrictTotalCount(district);
		Pagination pagination = new Pagination(request.getRequestURI(),
				getSearchParameters(district.getFullTextSearch()), totalCount, Long.parseLong(pageNo));
		log.info("@@ pagination = {}", pagination);

		district.setOffset(pagination.getOffset());
		district.setLimit(pagination.getPageRows());
		List<District> districtList = new ArrayList<>();
		if (totalCount > 0L) {
			districtList = searchMapService.getListDistrict(district);
		}

		int statusCode = HttpStatus.OK.value();
		result.put("pagination", pagination);
		result.put("totalCount", totalCount);
		result.put("districtList", districtList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	private String getSearchParameters(String fullTextSearch) {
		StringBuilder builder = new StringBuilder();
		builder.append("&searchValue=" + URLEncoder.encode(fullTextSearch, StandardCharsets.UTF_8));
		return builder.toString();
	}
}