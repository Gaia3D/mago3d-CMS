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

import gaia3d.domain.PageType;
import gaia3d.domain.common.Pagination;
import gaia3d.domain.role.Role;
import gaia3d.service.RoleService;
import gaia3d.support.SQLInjectSupport;
import gaia3d.utils.DateUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/role")
public class RoleController {

	@Autowired
	private RoleService roleService;

	/**
	 * Role 목록
	 * @param request
	 * @param pageNo
	 * @param role
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, @RequestParam(defaultValue="1") String pageNo, Role role, Model model) {
		role.setSearchWord(SQLInjectSupport.replaceSqlInection(role.getSearchWord()));
		role.setOrderWord(SQLInjectSupport.replaceSqlInection(role.getOrderWord()));
		
		if(!StringUtils.isEmpty(role.getStartDate())) {
			role.setStartDate(role.getStartDate().substring(0, 8) + DateUtils.START_TIME);
		}
		if(!StringUtils.isEmpty(role.getEndDate())) {
			role.setEndDate(role.getEndDate().substring(0, 8) + DateUtils.END_TIME);
		}

		long totalCount = roleService.getRoleTotalCount(role);
		Pagination pagination = new Pagination(request.getRequestURI(), getSearchParameters(PageType.LIST, role),
				totalCount, Long.parseLong(pageNo), role.getListCounter());
		role.setOffset(pagination.getOffset());
		role.setLimit(pagination.getPageRows());

		List<Role> roleList = new ArrayList<>();
		if(totalCount > 0l) {
			roleList = roleService.getListRole(role);
		}

		model.addAttribute(pagination);
		model.addAttribute("role", role);
		model.addAttribute("roleList", roleList);

		return "/role/list";
	}

	/**
	 * Role 등록 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(Model model) {
		Role role = new Role();
		role.setMethodMode("insert");

		model.addAttribute("role", role);
		return "/role/input";
	}

	/**
	 * 수정 페이지로 이동
	 * @param request
	 * @param roleId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam Integer roleId, Model model) {
		Role role = roleService.getRole(roleId);

		model.addAttribute(role);

		return "/role/modify";
	}

	/**
	 * 검색 조건
	 * @param pageType
	 * @param role
	 * @return
	 */
	private String getSearchParameters(PageType pageType, Role role) {
		return role.getParameters();
	}
}