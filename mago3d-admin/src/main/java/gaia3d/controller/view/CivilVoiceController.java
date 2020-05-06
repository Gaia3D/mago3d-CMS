package gaia3d.controller.view;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.slf4j.Slf4j;
import gaia3d.controller.AuthorizationController;
import gaia3d.domain.CivilVoice;
import gaia3d.domain.Key;
import gaia3d.domain.PageType;
import gaia3d.domain.Pagination;
import gaia3d.domain.Policy;
import gaia3d.domain.RoleKey;
import gaia3d.domain.UserSession;
import gaia3d.service.CivilVoiceService;
import gaia3d.service.PolicyService;
import gaia3d.support.SQLInjectSupport;
import gaia3d.utils.DateUtils;
import gaia3d.utils.FormatUtils;

@Slf4j
@Controller
@RequestMapping("/civil-voice")
public class CivilVoiceController implements AuthorizationController {

	@Autowired
    private CivilVoiceService civilVoiceService;
	@Autowired
    private PolicyService policyService;

	/**
	 * 시민참여 목록
	 * @param request
	 * @param pageNo
	 * @param civilVoice
	 * @param model
	 * @return
	 */
    @GetMapping(value = "/list")
	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, CivilVoice civilVoice, Model model) {
    	civilVoice.setSearchWord(SQLInjectSupport.replaceSqlInection(civilVoice.getSearchWord()));
    	civilVoice.setOrderWord(SQLInjectSupport.replaceSqlInection(civilVoice.getOrderWord()));

    	UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		String roleCheckResult = roleValidate(request);
    	if(roleValidate(request) != null) return roleCheckResult;

    	String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(civilVoice.getStartDate())) {
			civilVoice.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			civilVoice.setStartDate(civilVoice.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(civilVoice.getEndDate())) {
			civilVoice.setEndDate(today + DateUtils.END_TIME);
		} else {
			civilVoice.setEndDate(civilVoice.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = civilVoiceService.getCivilVoiceTotalCount(civilVoice);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, civilVoice),
				totalCount, Long.parseLong(pageNo), civilVoice.getListCounter());
		civilVoice.setOffset(pagination.getOffset());
		civilVoice.setLimit(pagination.getPageRows());

		List<CivilVoice> civilVoiceList = new ArrayList<>();
		if(totalCount > 0l) {
			civilVoice.setUserId(userSession.getUserId());
			civilVoiceList = civilVoiceService.getListCivilVoice(civilVoice);
		}

		model.addAttribute(pagination);
		model.addAttribute("civilVoiceList", civilVoiceList);
		return "/civil-voice/list";
	}

    /**
     * 시민참여 상세 정보
     * @param request
     * @param civilVoice
     * @param model
     * @return
     */
	@GetMapping(value = "/detail")
	public String detail(HttpServletRequest request, CivilVoice civilVoice, Model model) {
		String listParameters = getSearchParameters(PageType.DETAIL, civilVoice);

		civilVoice =  civilVoiceService.getCivilVocieById(civilVoice);
		Policy policy = policyService.getPolicy();

		if(civilVoice != null) {
			String contents = civilVoice.getContents();
			contents = contents.replaceAll(System.getProperty("line.separator"), "<br />");
			civilVoice.setContents(contents);
		}

		model.addAttribute("policy", policy);
		model.addAttribute("civilVoice", civilVoice);
		model.addAttribute("listParameters", listParameters);
		return "/civil-voice/detail";
	}

	/**
	 * 시민참여 등록 페이지 이동
	 * @param request
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		model.addAttribute("civilVoice", new CivilVoice());
		return "/civil-voice/input";
	}

	/**
	 * 시민참여 수정 페이지 이동
	 * @param request
	 * @param civilVoiceId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam("civilVoiceId") Long civilVoiceId, Model model) {
		CivilVoice civilVoice = new CivilVoice();
		civilVoice.setCivilVoiceId(civilVoiceId);
		civilVoice = civilVoiceService.getCivilVocieById(civilVoice);
		model.addAttribute("civilVoice", civilVoice);
		return "/civil-voice/modify";
	}

	/**
	 * 시민참여 삭제
	 * @param civilVoiceId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/delete")
	public String delete(@RequestParam("civilVoiceId") Long civilVoiceId, Model model) {
		// TODO validation 체크 해야 함
		CivilVoice civilVoice = new CivilVoice();
		civilVoice.setCivilVoiceId(civilVoiceId);
		civilVoiceService.deleteCivilVoice(civilVoice);

		return "redirect:/civil-voice/list";
	}

	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	private String getSearchParameters(PageType pageType, CivilVoice userInfo) {
		StringBuffer buffer = new StringBuffer(userInfo.getParameters());
		boolean isListPage = true;
		if(pageType == PageType.MODIFY || pageType == PageType.DETAIL) {
			isListPage = false;
		}

//		if(!isListPage) {
//			buffer.append("pageNo=" + request.getParameter("pageNo"));
//			buffer.append("&");
//			buffer.append("list_count=" + uploadData.getList_counter());
//		}

		return buffer.toString();
	}

	private String roleValidate(HttpServletRequest request) {
    	UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		int httpStatusCode = getRoleStatusCode(userSession.getUserGroupId(), RoleKey.ADMIN_USER_MANAGE.name());
		if(httpStatusCode > 200) {
			log.info("@@ httpStatusCode = {}", httpStatusCode);
			request.setAttribute("httpStatusCode", httpStatusCode);
			return "/error/error";
		}

		return null;
    }
}
