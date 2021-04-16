package gaia3d.controller.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.domain.Key;
import gaia3d.domain.LocationUdateType;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfoLegacy;
import gaia3d.domain.data.DataInfoLegacyWrapper;
import gaia3d.domain.data.DataInfoSimple;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataGroupService;
import gaia3d.service.DataService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/data-groups")
public class DataGroupRestController {

	@Autowired
	private DataService dataService;
	@Autowired
	private DataGroupService dataGroupService;

	@Autowired
	private ObjectMapper objectMapper;

	/**
	 * 그룹Key 중복 체크
	 * @param request
	 * @param dataGroup
	 * @return
	 */
	@GetMapping(value = "/duplication")
	public Map<String, Object> dataGroupKeyDuplicationCheck(HttpServletRequest request, DataGroup dataGroup) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		// TODO @Valid 로 구현해야 함
		if(StringUtils.isEmpty(dataGroup.getDataGroupKey())) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "data.group.key.empty");
			result.put("message", message);
			return result;
		}
		
		Boolean duplication = dataGroupService.isDataGroupKeyDuplication(dataGroup);
		log.info("@@ duplication = {}", duplication);
		int statusCode = HttpStatus.OK.value();
		
		result.put("duplication", duplication);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 사용자 데이터 그룹 정보
	 * @param dataGroup
	 * @return
	 */
	@GetMapping("/{dataGroupId:[0-9]+}")
	public Map<String, Object> detail(	HttpServletRequest request, @PathVariable Integer dataGroupId, DataGroup dataGroup ) {
		log.info("@@@@@ detail dataGroup = {}, dataGroupId = {}", dataGroup, dataGroupId);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		int statusCode = HttpStatus.OK.value();
		
		result.put("dataGroup", dataGroup);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 데이터 그룹 등록
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute DataGroup dataGroup, BindingResult bindingResult) {
		log.info("@@@@@ insert-group dataGroup = {}", dataGroup);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}

		dataGroup.setUserId(userSession.getUserId());
		if(dataGroup.getLongitude() != null && dataGroup.getLatitude() != null) {
			dataGroup.setLocationUpdateType(LocationUdateType.USER.name().toLowerCase());
			dataGroup.setLocation("POINT(" + dataGroup.getLongitude() + " " + dataGroup.getLatitude() + ")");
		}
		
		dataGroupService.insertDataGroup(dataGroup);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 데이터 그룹 수정
	 * @param request
	 * @param dataGroup
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("/{dataGroupId:[0-9]+}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Integer dataGroupId, @Valid DataGroup dataGroup, BindingResult bindingResult) {
		log.info("@@ dataGroup = {}", dataGroup);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		if(dataGroup.getLongitude() != null && dataGroup.getLatitude() != null) {
			dataGroup.setLocationUpdateType(LocationUdateType.USER.name().toLowerCase());
			dataGroup.setLocation("POINT(" + dataGroup.getLongitude() + " " + dataGroup.getLatitude() + ")");
		}
		
		dataGroupService.updateDataGroup(dataGroup);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 데이터 그룹 트리 순서 수정 (up/down)
	 * @param request
	 * @param dataGroupId
	 * @param dataGroup
	 * @return
	 */
	@PostMapping(value = "/view-order/{dataGroupId:[0-9]+}")
	public Map<String, Object> moveDataGroup(HttpServletRequest request, @PathVariable Integer dataGroupId, @ModelAttribute DataGroup dataGroup) {
		log.info("@@ dataGroup = {}", dataGroup);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		dataGroup.setDataGroupId(dataGroupId);
		int updateCount = dataGroupService.updateDataGroupViewOrder(dataGroup);
		int statusCode = HttpStatus.OK.value();
		if(updateCount == 0) {
			statusCode = HttpStatus.BAD_REQUEST.value();
			errorCode = "data.group.view-order.invalid";
		}

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * Smart Tiling 데이터 다운로드
	 * @param request
	 * @param response
	 * @param dataGroupId
	 * @return
	 */
	@GetMapping(value = "/download/{dataGroupId:[0-9]+}")
	public String downloadSmartTiling(HttpServletRequest request, HttpServletResponse response, @PathVariable Integer dataGroupId) {
		log.info("@@ dataGroupId = {}", dataGroupId);
		
		response.setContentType("application/force-download");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + dataGroupId + ".json\"");
		
		DataGroup dataGroup = DataGroup.builder().dataGroupId(dataGroupId).build();
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		List<DataInfoSimple> dataInfoList = dataService.getListAllDataByDataGroupId(dataGroupId);
		dataGroup.setDatas(dataInfoList);
		try {
			objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
			String dataJson = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(dataGroup);
			
			// 불필요한 코드
			dataJson = dataJson.replaceAll("<", "&lt;");
			dataJson = dataJson.replaceAll(">", "&gt;");
			response.getWriter().write(dataJson);
		} catch(JsonProcessingException e) {
			log.info("@@@@@@@@@@@@ jsonProcessing exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(RuntimeException e) {
			log.info("@@@@@@@@@@@@ runtime exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@@@@@@ exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
			
		return null;
	}
	
	/**
	 * Smart Tiling Converter용 JSON 다운로드
	 * @param request
	 * @param response
	 * @param dataGroupId
	 * @return
	 */
	@GetMapping(value = "/download/converter/{dataGroupId:[0-9]+}")
	public String downloadSmartTilingConverter(HttpServletRequest request, HttpServletResponse response, @PathVariable Integer dataGroupId) {
		log.info("@@ dataGroupId = {}", dataGroupId);
		
		response.setContentType("application/force-download");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Content-Disposition", "attachment; filename=\"converter_" + dataGroupId + ".json\"");
		
		DataGroup dataGroup = DataGroup.builder().dataGroupId(dataGroupId).build();
		dataGroup = dataGroupService.getDataGroup(dataGroup);
		
		List<DataInfoSimple> dataInfoList = dataService.getListAllDataByDataGroupId(dataGroupId);
		dataGroup.setDatas(dataInfoList);
		
		try {
			
			DataInfoLegacyWrapper tgt = new DataInfoLegacyWrapper();
			List<DataInfoLegacy> childrens = new ArrayList<>();
			
			for (DataInfoSimple info : dataInfoList) {
				DataInfoLegacy children = new DataInfoLegacy();
				children.setLatitude(info.getLatitude());
				children.setLongitude(info.getLongitude());
				children.setDataId(info.getDataId());
				children.setDataGroupId(info.getDataGroupId());
				children.setData_key(info.getDataKey());
				children.setData_name(info.getDataName());
				children.setMapping_type(info.getMappingType());
				children.setHeight(info.getAltitude());
				children.setHeading(info.getHeading());
				children.setPitch(info.getPitch());
				children.setRoll(info.getRoll());
				children.setAttributes(info.getMetainfo());
				childrens.add(children);
			}
			tgt.setChildren(childrens);
			objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
			String result = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(tgt);
			
			// 불필요한 코드
			//dataJson = dataJson.replaceAll("<", "&lt;");
			//dataJson = dataJson.replaceAll(">", "&gt;");
			response.getWriter().write(result);
		} catch(JsonProcessingException e) {
			log.info("@@@@@@@@@@@@ jsonProcessing exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(RuntimeException e) {
			log.info("@@@@@@@@@@@@ runtime exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@@@@@@ exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
			
		return null;
	}
}
