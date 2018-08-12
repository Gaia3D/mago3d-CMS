package com.gaia3d.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Menu;
import com.gaia3d.domain.Policy;
import com.gaia3d.service.MenuService;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 메뉴
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/config/")
public class MenuController {
	
	@Autowired
	private MenuService menuService;
	
	/**
	 * 메뉴 정책
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-menu.do", method = RequestMethod.GET)
	public String menuList(HttpServletRequest request, Model model) {
		return "/config/list-menu";
	}
	
	/**
	 * 메뉴 목록
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-list-menu.do")
	@ResponseBody
	public Map<String, Object> ajaxListMenu(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String menuTree = null;
		try {
			menuTree = getMenuTree(getAllListMenu());
			log.info("@@ menuTree = {} ", menuTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("menuTree", menuTree);
		return map;
	}
	
	/**
	 * 메뉴 추가
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-insert-menu.do")
	@ResponseBody
	public Map<String, Object> ajaxInsertMenu(HttpServletRequest request, Menu menu) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String menuTree = null;
		try {
			log.info("@@ menu = {} ", menu);
//			String parent = request.getParameter("parent");
//			String depth = request.getParameter("depth");
			if(menu.getName() == null || "".equals(menu.getName())
					|| menu.getName_en() == null || "".equals(menu.getName_en())	
					|| menu.getParent() == null
					|| menu.getUrl() == null || "".equals(menu.getUrl())
					|| menu.getUse_yn() == null || "".equals(menu.getUse_yn())) {
				
				menuTree = getMenuTree(getAllListMenu());
				map.put("result", "policy.menu.invalid");
				map.put("menuTree", menuTree);
				return map;
			}
			
			Menu childMenu = menuService.getMaxViewOrderChildMenu(menu.getParent());
			if(childMenu == null) {
				menu.setView_order(1);
			} else {
				menu.setView_order(childMenu.getView_order() + 1);
			}
			
			if("\"null\"".equals(menu.getName_en()) || "null".equals(menu.getName_en())) menu.setName_en("");
			if("\"null\"".equals(menu.getImage()) || "null".equals(menu.getImage())) menu.setImage("");
			if("\"null\"".equals(menu.getImage_alt()) || "null".equals(menu.getImage_alt())) menu.setImage_alt("");
			if("\"null\"".equals(menu.getCss_class()) || "null".equals(menu.getCss_class())) menu.setCss_class("");
			if("\"null\"".equals(menu.getDescription()) || "null".equals(menu.getDescription())) menu.setDescription("");
			if("\"null\"".equals(menu.getDisplay_yn()) || "null".equals(menu.getDisplay_yn())) menu.setDisplay_yn("");
			if("\"null\"".equals(menu.getUrl_alias()) || "null".equals(menu.getUrl_alias())) menu.setUrl_alias("");
			
			menuService.insertMenu(menu);
			menuTree = getMenuTree(getAllListMenu());
			log.info("@@ menuTree = {} ", menuTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("menuTree", menuTree);
		return map;
	}
	
	/**
	 * 메뉴 수정
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-update-menu.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateMenu(HttpServletRequest request, Menu menu) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String menuTree = null;
		try {
			log.info("@@ menu = {} ", menu);
			if(menu.getMenu_id() == null || menu.getMenu_id().longValue() == 0l
					|| menu.getName() == null || "".equals(menu.getName())
					|| menu.getName_en() == null || "".equals(menu.getName_en())
					|| menu.getUrl() == null || "".equals(menu.getUrl())
					|| menu.getUse_yn() == null || "".equals(menu.getUse_yn())) {
				
				menuTree = getMenuTree(getAllListMenu());
				map.put("result", "policy.menu.invalid");
				map.put("menuTree", menuTree);
				return map;
			}
			
			// TODO null 이라는 문자가 들어가면 트리가 표시되지 않음. 나중에 잡자.
			if("\"null\"".equals(menu.getName_en()) || "null".equals(menu.getName_en())) menu.setName_en("");
			if("\"null\"".equals(menu.getImage()) || "null".equals(menu.getImage())) menu.setImage("");
			if("\"null\"".equals(menu.getImage_alt()) || "null".equals(menu.getImage_alt())) menu.setImage_alt("");
			if("\"null\"".equals(menu.getCss_class()) || "null".equals(menu.getCss_class())) menu.setCss_class("");
			if("\"null\"".equals(menu.getDescription()) || "null".equals(menu.getDescription())) menu.setDescription("");
			if("\"null\"".equals(menu.getDisplay_yn()) || "null".equals(menu.getDisplay_yn())) menu.setDisplay_yn("");
			if("\"null\"".equals(menu.getUrl_alias()) || "null".equals(menu.getUrl_alias())) menu.setUrl_alias("");
			
			menuService.updateMenu(menu);
			menuTree = getMenuTree(getAllListMenu());
			log.info("@@ menuTree = {} ", menuTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("menuTree", menuTree);
		return map;
	}
	
	/**
	 * 메뉴 위로/아래로 수정
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-update-move-menu.do")
	@ResponseBody
	public Map<String, Object> ajaxUpdateMoveMenu(HttpServletRequest request, Menu menu) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String menuTree = null;
		try {
			log.info("@@ menu = {} ", menu);
			if(menu.getMenu_id() == null || menu.getMenu_id().longValue() == 0l
					|| menu.getView_order() == null || menu.getView_order().intValue() == 0
					|| menu.getUpdate_type() == null || "".equals(menu.getUpdate_type())) {
				
				menuTree = getMenuTree(getAllListMenu());
				map.put("result", "menu.invalid");
				map.put("menuTree", menuTree);
				return map;
			}
			
			menuService.updateMoveMenu(menu);
			menuTree = getMenuTree(getAllListMenu());
			log.info("@@ menuTree = {} ", menuTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("menuTree", menuTree);
		return map;
	}
	
	/**
	 * 메뉴 삭제
	 * @param model
	 * @return
	 */
	@PostMapping(value = "ajax-delete-menu.do")
	@ResponseBody
	public Map<String, Object> ajaxDeleteMenu(HttpServletRequest request, Menu menu) {
		Map<String, Object> map = new HashMap<>();
		String result = "success";
		String menuTree = null;
		List<Menu> menuList = new ArrayList<>();
		
		try {
			// 관리자 메뉴
			menuList.add(getRootMenu(Menu.ADMIN));
			
			
			log.info("@@ menu = {} ", menu);
			if(menu.getMenu_id() == null || menu.getMenu_id().longValue() == 0l) {
				
				menuTree = getMenuTree(getAllListMenu());
				map.put("result", "menu.invalid");
				map.put("menuTree", menuTree);
				return map;
			}
			
			menuService.deleteMenu(menu.getMenu_id());
			menuTree = getMenuTree(getAllListMenu());
			log.info("@@ menuTree = {} ", menuTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
	
		map.put("result", result);
		map.put("menuTree", menuTree);
		return map;
	}
	
	/**
	 * 기본 메뉴 트리
	 * @param menuType
	 * @return
	 */
	private Menu getRootMenu(String menuType) {
		Policy policy = CacheManager.getPolicy();
		
		Menu menu = new Menu();
		menu.setMenu_id(0l);
		menu.setMenu_type(menuType);
		if(policy.getContent_menu_group_root() != null && !"".equals(policy.getContent_menu_group_root())) {
			if(Menu.ADMIN.equals(menuType)) {
				menu.setName(policy.getContent_menu_group_root() + " [ADMIN]");
			} else {
				menu.setName(policy.getContent_menu_group_root() + " [USER]");
			}
		} else {
			if(Menu.ADMIN.equals(menuType)) {
				menu.setName("TOP [ADMIN]");
			} else {
				menu.setName("TOP [USER]");
			}
		}
		if(Menu.ADMIN.equals(menuType)) {
			menu.setName_en("TOP [ADMIN]");
		} else {
			menu.setName_en("TOP [USER]");
		}
		menu.setOpen("true");
		menu.setNode_type("company");
		menu.setParent(-1l);
		menu.setParent_name("");
		menu.setView_order(0);
		menu.setDepth(0);
		menu.setDefault_yn("Y");
		menu.setUse_yn("Y");
		menu.setUrl("");
		menu.setImage("");
		menu.setImage_alt("");
		menu.setCss_class("");
		menu.setDescription("");
		
		return menu;
	}
	
	private String getMenuTree(List<Menu> menuList) {
		StringBuffer buffer = new StringBuffer();
		
		int menuCount = menuList.size();
		Menu menu = menuList.get(0);
		
		buffer.append("[");
		buffer.append("{");
		
		buffer.append("\"menu_id\"").append(":").append("\"" + menu.getMenu_id() + "\"").append(",");
		buffer.append("\"menu_type\"").append(":").append("\"" + menu.getMenu_type() + "\"").append(",");
		buffer.append("\"name\"").append(":").append("\"" + menu.getName() + "\"").append(",");
		buffer.append("\"name_en\"").append(":").append("\"" + menu.getName_en() + "\"").append(",");
		buffer.append("\"open\"").append(":").append("\"" + menu.getOpen() + "\"").append(",");
		buffer.append("\"node_type\"").append(":").append("\"" + menu.getNode_type() + "\"").append(",");
		buffer.append("\"parent\"").append(":").append("\"" + menu.getParent() + "\"").append(",");
		buffer.append("\"parent_name\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParent_name()) + "\"").append(",");
		buffer.append("\"view_order\"").append(":").append("\"" + menu.getView_order() + "\"").append(",");
		buffer.append("\"depth\"").append(":").append("\"" + menu.getDepth() + "\"").append(",");
		buffer.append("\"default_yn\"").append(":").append("\"" + menu.getDefault_yn() + "\"").append(",");
		buffer.append("\"use_yn\"").append(":").append("\"" + menu.getUse_yn() + "\"").append(",");
		buffer.append("\"display_yn\"").append(":").append("\"" + menu.getDisplay_yn() + "\"").append(",");
		buffer.append("\"url\"").append(":").append("\"" + menu.getUrl() + "\"").append(",");
		buffer.append("\"url_alias\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrl_alias()) + "\"").append(",");
		buffer.append("\"image\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",");
		buffer.append("\"image_alt\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage_alt()) + "\"").append(",");
		buffer.append("\"css_class\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCss_class()) + "\"").append(",");
		buffer.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
	
		if(menuCount > 1) {
			long preParent = menu.getParent();
			int preDepth = menu.getDepth();
			int bigParentheses = 0;
			for(int i=1; i<menuCount; i++) {
				menu = menuList.get(i);
				
				if(preParent == menu.getParent()) {
					// 부모가 같은 경우
					buffer.append("}");
					buffer.append(",");
				} else {
					if(preDepth > menu.getDepth()) {
						// 닫힐때
						int closeCount = preDepth - menu.getDepth();
						for(int j=0; j<closeCount; j++) {
							buffer.append("}");
							buffer.append("]");
							bigParentheses--;
						}
						buffer.append("}");
						buffer.append(",");
					} else {
						// 열릴때
						buffer.append(",");
						buffer.append("\"subTree\"").append(":").append("[");
						bigParentheses++;
					}
				} 
				
				buffer.append("{");
				buffer.append("\"menu_id\"").append(":").append("\"" + menu.getMenu_id() + "\"").append(",");
				buffer.append("\"menu_type\"").append(":").append("\"" + menu.getMenu_type() + "\"").append(",");
				buffer.append("\"name\"").append(":").append("\"" + menu.getName() + "\"").append(",");
				buffer.append("\"name_en\"").append(":").append("\"" + menu.getName_en() + "\"").append(",");
				buffer.append("\"open\"").append(":").append("\"" + menu.getOpen() + "\"").append(",");
				buffer.append("\"node_type\"").append(":").append("\"" + menu.getNode_type() + "\"").append(",");
				buffer.append("\"parent\"").append(":").append("\"" + menu.getParent() + "\"").append(",");
				buffer.append("\"parent_name\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParent_name()) + "\"").append(",");
				buffer.append("\"view_order\"").append(":").append("\"" + menu.getView_order() + "\"").append(",");
				buffer.append("\"depth\"").append(":").append("\"" + menu.getDepth() + "\"").append(",");
				buffer.append("\"default_yn\"").append(":").append("\"" + menu.getDefault_yn() + "\"").append(",");
				buffer.append("\"use_yn\"").append(":").append("\"" + menu.getUse_yn() + "\"").append(",");
				buffer.append("\"display_yn\"").append(":").append("\"" + menu.getDisplay_yn() + "\"").append(",");
				buffer.append("\"url\"").append(":").append("\"" + menu.getUrl() + "\"").append(",");
				buffer.append("\"url_alias\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrl_alias()) + "\"").append(",");
				buffer.append("\"image\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",");
				buffer.append("\"image_alt\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage_alt()) + "\"").append(",");
				buffer.append("\"css_class\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCss_class()) + "\"").append(",");
				buffer.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
				
				if(i == (menuCount-1)) {
					// 맨 마지막의 경우 괄호를 닫음
					if(bigParentheses == 0) {
						buffer.append("}");
					} else {
						for(int k=0; k<bigParentheses; k++) {
							buffer.append("}");
							buffer.append("]");
						}
					}
				}
				
				preParent = menu.getParent();
				preDepth = menu.getDepth();
			}
		}
		
		buffer.append("}");
		buffer.append("]");
		
		return buffer.toString();
	}
	
	private List<Menu> getAllListMenu() {
		List<Menu> menuList = new ArrayList<>();
		Menu menu = new Menu();
		menu.setDefault_yn(null);
		menu.setMenu_type(Menu.ADMIN);
		menuList.add(getRootMenu(menu.getMenu_type()));
		menuList.addAll(menuService.getListMenu(menu));
		menu.setMenu_type(Menu.USER);
		menuList.add(getRootMenu(menu.getMenu_type()));
		menuList.addAll(menuService.getListMenu(menu));
		return menuList;
	}
}
