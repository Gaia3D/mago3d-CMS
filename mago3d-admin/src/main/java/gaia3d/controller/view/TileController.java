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

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.Key;
import gaia3d.domain.PageType;
import gaia3d.domain.common.Pagination;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.tile.TileInfo;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataGroupService;
import gaia3d.service.PolicyService;
import gaia3d.service.TileService;
import gaia3d.support.SQLInjectSupport;
import gaia3d.utils.DateUtils;
import gaia3d.utils.FormatUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/tile")
public class TileController {

	@Autowired
	private DataGroupService dataGroupService;
	@Autowired
	private TileService tileService;
	@Autowired
	private PolicyService policyService;
	@Autowired
	private PropertiesConfig propertiesConfig;

	/**
	 * 타일링 목록
	 * @param request
	 * @param tileInfo
	 * @param pageNo
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, TileInfo tileInfo, Model model) {
		tileInfo.setSearchWord(SQLInjectSupport.replaceSqlInection(tileInfo.getSearchWord()));
		tileInfo.setOrderWord(SQLInjectSupport.replaceSqlInection(tileInfo.getOrderWord()));

		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY);
		if(StringUtils.isEmpty(tileInfo.getStartDate())) {
			tileInfo.setStartDate(today.substring(0,4) + DateUtils.START_DAY_TIME);
		} else {
			tileInfo.setStartDate(tileInfo.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(StringUtils.isEmpty(tileInfo.getEndDate())) {
			tileInfo.setEndDate(today + DateUtils.END_TIME);
		} else {
			tileInfo.setEndDate(tileInfo.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = tileService.getTileTotalCount(tileInfo);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, tileInfo), totalCount, Long.parseLong(pageNo), tileInfo.getListCounter());
		tileInfo.setOffset(pagination.getOffset());
		tileInfo.setLimit(pagination.getPageRows());

		List<TileInfo> tileInfoList = new ArrayList<>();
		if(totalCount > 0l) {
			tileInfoList = tileService.getListTile(tileInfo);
		}

		model.addAttribute(pagination);
		model.addAttribute("tileInfoList", tileInfoList);
		return "/tile/list";
	}

	/**
	 * 타일 등록 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(HttpServletRequest request, Model model) {
		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		TileInfo tileInfo = new TileInfo();
		tileInfo.setUserId(userSession.getUserId());

		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);

		model.addAttribute("tileInfo", tileInfo);
		model.addAttribute("dataGroupList", dataGroupList);

		return "/tile/input";
	}

	/**
	 * 타일 수정 페이지 이동
	 * @param request
	 * @param tileId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam("tileId") Integer tileId, Model model) {
		log.info("@@ tileId = {}", tileId);

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());

		TileInfo tileInfo = new TileInfo();
		tileInfo.setTileId(tileId);
		tileInfo = tileService.getTile(tileInfo);

		DataGroup dataGroup = new DataGroup();
		dataGroup.setUserId(userSession.getUserId());
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroup(dataGroup);
		
		model.addAttribute("tileInfo", tileInfo);
		model.addAttribute("dataGroupList", dataGroupList);
		
		return "/tile/modify";
	}

	/**
	 * 타일 삭제
	 * @param tileId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/delete")
	public String delete(@RequestParam("tileId") Integer tileId, Model model) {
		// TODO validation 체크 해야 함
		if(tileId == null) {
			log.info("@@@ validation error tileId = {}", tileId);
			return "redirect:/tile/list";
		}
		
		TileInfo tileInfo = new TileInfo();
		tileInfo.setTileId(tileId);

		tileService.deleteTile(tileInfo);
		
		return "redirect:/tile/list";
	}

	/**
	 * 검색 조건
	 * @param tileInfo
	 * @return
	 */
	private String getSearchParameters(PageType pageType, TileInfo tileInfo) {
		StringBuffer buffer = new StringBuffer(tileInfo.getParameters());
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
}
