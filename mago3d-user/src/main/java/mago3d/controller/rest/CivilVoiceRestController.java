package mago3d.controller.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import mago3d.domain.CacheManager;
import mago3d.domain.CivilVoice;
import mago3d.domain.Key;
import mago3d.domain.PageType;
import mago3d.domain.Pagination;
import mago3d.domain.RoleKey;
import mago3d.domain.UserSession;
import mago3d.service.CivilVoiceService;
import mago3d.support.SQLInjectSupport;
import mago3d.utils.WebUtils;

@Slf4j
@RestController
@RequestMapping("/civil-voices")
public class CivilVoiceRestController {

	private static final long PAGE_ROWS = 5l;
	private static final long PAGE_LIST_COUNT = 5l;
	private final CivilVoiceService civilVoiceService;

	public CivilVoiceRestController(CivilVoiceService civilVoiceService) {
		this.civilVoiceService = civilVoiceService;
	}

	/**
	 * 시민 참여 목록 조회
	 * @param request
	 * @param civilVoice
	 * @param pageNo
	 * @return
	 */
	@GetMapping
	public Map<String, Object> list(HttpServletRequest request, CivilVoice civilVoice, @RequestParam(defaultValue="1") String pageNo) {
		civilVoice.setSearchWord(SQLInjectSupport.replaceSqlInection(civilVoice.getSearchWord()));
		civilVoice.setOrderWord(SQLInjectSupport.replaceSqlInection(civilVoice.getOrderWord()));
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		civilVoice.setUserId(userSession.getUserId());
		civilVoice.setClientIp(WebUtils.getClientIp(request));
		
		long totalCount = civilVoiceService.getCivilVoiceTotalCount(civilVoice);
		Pagination pagination = new Pagination(	request.getRequestURI(),
												getSearchParameters(PageType.LIST, civilVoice),
												totalCount,
												Long.parseLong(pageNo),
												PAGE_ROWS,
												PAGE_LIST_COUNT);
		log.info("@@ pagination = {}", pagination);

		civilVoice.setOffset(pagination.getOffset());
		civilVoice.setLimit(pagination.getPageRows());
		List<CivilVoice> civilVoiceList = new ArrayList<>();
		if(totalCount > 0l) {
			civilVoiceList = civilVoiceService.getListCivilVoice(civilVoice);
		}

		int statusCode = HttpStatus.OK.value();
		
		result.put("totalCount", totalCount);
		result.put("pagination", pagination);
		result.put("civilVoiceList", civilVoiceList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시민 참여 전체 목록 조회
	 * @param request
	 * @param civilVoice
	 * @param pageNo
	 * @return
	 */
	@GetMapping("/all")
	public Map<String, Object> listAll(HttpServletRequest request, CivilVoice civilVoice) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		civilVoice.setUserId(userSession.getUserId());
		civilVoice.setClientIp(WebUtils.getClientIp(request));
		
		long totalCount = civilVoiceService.getCivilVoiceTotalCount(civilVoice);
		List<CivilVoice> civilVoiceList = new ArrayList<>();
		if(totalCount > 0l) {
			civilVoiceList = civilVoiceService.getListAllCivilVoice(civilVoice);
		}

		int statusCode = HttpStatus.OK.value();
		
		result.put("totalCount", totalCount);
		result.put("civilVoiceList", civilVoiceList);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시민 참여 상세 조회
	 * @param request
	 * @param civilVoiceId
	 * @param civilVoice
	 * @return
	 */
	@GetMapping("/{civilVoiceId:[0-9]+}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable Long civilVoiceId,
			@RequestParam(value="readOnly",required=false) Boolean readOnly, CivilVoice civilVoice) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		
		civilVoice.setCivilVoiceId(civilVoiceId);
		civilVoice.setUserId(userSession.getUserId());
		civilVoice = civilVoiceService.getCivilVocieById(civilVoice);
		List<String> userGroupRoleKeyList = CacheManager.getUserGroupRoleKeyList(userSession.getUserGroupId());
		// 시민 참여 관리 권한이 있을 경우 자신이 쓴 글이 아니여도 삭제 가능
		for(String roleName : userGroupRoleKeyList) {
			if(RoleKey.USER_CIVIL_VOICE_MANAGE == RoleKey.valueOf(roleName)) {
				civilVoice.setEditable(true);
			}
		}
		result.put("civilVoice", civilVoice);

		// 조회 수 수정
		if(readOnly==null || readOnly) {
			civilVoiceService.updateCivilVoiceViewCount(civilVoice);
		}
		
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시민참여 등록
	 * @param request
	 * @param civilVoice
	 * @param bindingResult
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute CivilVoice civilVoice, BindingResult bindingResult) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		civilVoice.setUserId(userSession.getUserId());
		if(civilVoice.getLongitude() != null && civilVoice.getLatitude() != null) {
			civilVoice.setLocation("POINT(" + civilVoice.getLongitude() + " " + civilVoice.getLatitude() + ")");
		}
		
		civilVoice = civilVoiceService.insertCivilVoice(civilVoice);
		int statusCode = HttpStatus.OK.value();
		
		result.put("civilVoiceId", civilVoice.getCivilVoiceId());
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시민참여 수정
	 * @param request
	 * @param civilVoiceId
	 * @param civilVoice
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("/{civilVoiceId:[0-9]+}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Long civilVoiceId, @Valid @ModelAttribute CivilVoice civilVoice, BindingResult bindingResult) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
            return result;
		}
		
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		civilVoice.setUserId(userSession.getUserId());
		civilVoice.setCivilVoiceId(civilVoiceId);
		if(civilVoice.getLongitude() != null && civilVoice.getLatitude() != null) {
			civilVoice.setLocation("POINT(" + civilVoice.getLongitude() + " " + civilVoice.getLatitude() + ")");
		}
		
		civilVoice = civilVoiceService.updateCivilVoice(civilVoice);
		int statusCode = HttpStatus.OK.value();
		
		result.put("civilVoiceId", civilVoice.getCivilVoiceId());
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 시민참여 삭제
	 * @param request
	 * @param civilVoiceId
	 * @return
	 */
	@DeleteMapping("/{civilVoiceId:[0-9]+}")
	public Map<String, Object> delete(HttpServletRequest request, @PathVariable Long civilVoiceId, CivilVoice civilVoice) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		// TODO 버그, userId 를 사용하지 않고 있음
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		civilVoice.setUserId(userSession.getUserId());
		civilVoice.setCivilVoiceId(civilVoiceId);
		civilVoiceService.deleteCivilVoice(civilVoice);
		int statusCode = HttpStatus.OK.value();
		
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 검색 조건
	 * @param pageType
	 * @param dataGroup
	 * @return
	 */
	private String getSearchParameters(PageType pageType, CivilVoice civilVoice) {
		StringBuffer buffer = new StringBuffer(civilVoice.getParameters());
		return buffer.toString();
	}
}
