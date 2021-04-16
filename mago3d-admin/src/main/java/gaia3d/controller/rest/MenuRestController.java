package gaia3d.controller.rest;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.config.CacheConfig;
import gaia3d.domain.cache.CacheName;
import gaia3d.domain.cache.CacheParams;
import gaia3d.domain.cache.CacheType;
import gaia3d.domain.menu.Menu;
import gaia3d.domain.menu.MenuTarget;
import gaia3d.domain.menu.MenuType;
import gaia3d.service.MenuService;
import gaia3d.utils.StringUtil;
import lombok.extern.slf4j.Slf4j;

/**
 * 메뉴 관리
 * @author Jeongdae
 *
 */
@Slf4j
@RestController
@RequestMapping("/menus")
public class MenuRestController {
	
	@Autowired
	private CacheConfig cacheConfig;
	@Autowired
	private MenuService menuService;
	
	/**
	 * 관리자 메뉴
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/admin-tree", produces = "application/json;charset=UTF-8")
	public Map<String, Object> adminTree(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		String menuTree = getMenuTree(getAllListMenu(MenuTarget.ADMIN.getValue()));
		log.info("@@ menuTree = {} ", menuTree);
		int statusCode = HttpStatus.OK.value();
		
		result.put("menuTree", menuTree);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 사용자 메뉴
	 * @param request
	 * @return
	 */
	@GetMapping(value = "/user-tree", produces = "application/json;charset=UTF-8")
	public Map<String, Object> userTree(HttpServletRequest request) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		String menuTree = null;
		
		menuTree = getMenuTree(getAllListMenu(MenuTarget.USER.getValue()));
		log.info("@@ menuTree = {} ", menuTree);
		int statusCode = HttpStatus.OK.value();
		
		result.put("menuTree", menuTree);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 메뉴 추가
	 * @param request
	 * @param menu
	 * @return
	 */
	@PostMapping(produces = "application/json;charset=UTF-8")
	public Map<String, Object> insert(HttpServletRequest request, Menu menu) {
		
		log.info("@@ menu = {} ", menu);
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		String menuTree = null;
		
		if(menu.getName() == null || "".equals(menu.getName())
				|| menu.getNameEn() == null || "".equals(menu.getNameEn())	
				|| menu.getParent() == null
				|| menu.getUseYn() == null || "".equals(menu.getUseYn())) {
			
			menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
			
			result.put("menuTree", menuTree);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "input.invalid");
			result.put("message", message);
            return result;
		}
		
		Menu childMenu = menuService.getMaxViewOrderChildMenu(menu);
		if(childMenu == null) {
			menu.setViewOrder(1);
		} else {
			menu.setViewOrder(childMenu.getViewOrder() + 1);
		}
		
		if("\"null\"".equals(menu.getNameEn()) || "null".equals(menu.getNameEn())) menu.setNameEn("");
		if("\"null\"".equals(menu.getUrl()) || "null".equals(menu.getUrl())) menu.setUrl("");
		if("\"null\"".equals(menu.getUrlAlias()) || "null".equals(menu.getUrlAlias())) menu.setUrlAlias("");
		if("\"null\"".equals(menu.getHtmlId()) || "null".equals(menu.getHtmlId())) menu.setHtmlId("");
		if("\"null\"".equals(menu.getHtmlContentId()) || "null".equals(menu.getHtmlContentId())) menu.setHtmlContentId("");
		if("\"null\"".equals(menu.getImage()) || "null".equals(menu.getImage())) menu.setImage("");
		if("\"null\"".equals(menu.getImageAlt()) || "null".equals(menu.getImageAlt())) menu.setImageAlt("");
		if("\"null\"".equals(menu.getCssClass()) || "null".equals(menu.getCssClass())) menu.setCssClass("");
		if("\"null\"".equals(menu.getDisplayYn()) || "null".equals(menu.getDisplayYn())) menu.setDisplayYn("");
		if("\"null\"".equals(menu.getDescription()) || "null".equals(menu.getDescription())) menu.setDescription("");
		
		menuService.insertMenu(menu);
		menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
		log.info("@@ menuTree = {} ", menuTree);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("menuTree", menuTree);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 사용자 그룹 트리 수정
	 * @param request
	 * @param menuId
	 * @param menu
	 * @return
	 */
	@PostMapping(value = "/{menuId:[0-9]+}", produces = "application/json;charset=UTF-8")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Integer menuId, @ModelAttribute Menu menu) {
		
		log.info("@@ menu = {}", menu);
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		String menuTree = null;
		
		if(menu.getName() == null || "".equals(menu.getName())
				|| menu.getNameEn() == null || "".equals(menu.getNameEn())	
				|| menu.getParent() == null
				|| menu.getUseYn() == null || "".equals(menu.getUseYn())) {
			
			menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
			
			result.put("menuTree", menuTree);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "input.invalid");
			result.put("message", message);
            return result;
		}
		
		if("\"null\"".equals(menu.getNameEn()) || "null".equals(menu.getNameEn())) menu.setNameEn("");
		if("\"null\"".equals(menu.getUrl()) || "null".equals(menu.getUrl())) menu.setUrl("");
		if("\"null\"".equals(menu.getUrlAlias()) || "null".equals(menu.getUrlAlias())) menu.setUrlAlias("");
		if("\"null\"".equals(menu.getHtmlId()) || "null".equals(menu.getHtmlId())) menu.setHtmlId("");
		if("\"null\"".equals(menu.getHtmlContentId()) || "null".equals(menu.getHtmlContentId())) menu.setHtmlContentId("");
		if("\"null\"".equals(menu.getImage()) || "null".equals(menu.getImage())) menu.setImage("");
		if("\"null\"".equals(menu.getImageAlt()) || "null".equals(menu.getImageAlt())) menu.setImageAlt("");
		if("\"null\"".equals(menu.getCssClass()) || "null".equals(menu.getCssClass())) menu.setCssClass("");
		if("\"null\"".equals(menu.getDisplayYn()) || "null".equals(menu.getDisplayYn())) menu.setDisplayYn("");
		if("\"null\"".equals(menu.getDescription()) || "null".equals(menu.getDescription())) menu.setDescription("");
		
		menu.setMenuId(menuId);
		menuService.updateMenu(menu);
		menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
		log.info("@@ menuTree = {} ", menuTree);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("menuTree", menuTree);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 사용자 그룹 트리 순서 수정, up, down
	 * @param request
	 * @param menuId
	 * @param menu
	 * @return
	 */
	@PostMapping(value = "/{menuId:[0-9]+}/move", produces = "application/json;charset=UTF-8")
	public Map<String, Object> move(HttpServletRequest request, @PathVariable Integer menuId, @ModelAttribute Menu menu) {
		log.info("@@ move. menuId = {}, menu = {}", menuId, menu);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		String menuTree = null;
		
		if(	menu.getViewOrder() == null || menu.getViewOrder() == 0
			|| menu.getUpdateType() == null || "".equals(menu.getUpdateType())) {
			
			menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
			
			result.put("menuTree", menuTree);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "input.invalid");
			result.put("message", message);
            return result;
		}
		
		menuService.updateMoveMenu(menu);
		menuTree = getMenuTree(getAllListMenu(menu.getMenuTarget()));
		log.info("@@ menuTree = {} ", menuTree);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
	
		result.put("menuTree", menuTree);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 메뉴 삭제
	 * @param request
	 * @param menuId
	 * @return
	 */
	@DeleteMapping(value = "/admin/{menuId:[0-9]+}", produces = "application/json;charset=UTF-8")
	public Map<String, Object> adminMenudelete(HttpServletRequest request, @PathVariable Integer menuId) {
		log.info("@@ menuId = {} ", menuId);
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		String menuTree = null;
		
		menuService.deleteMenu(menuId);
		menuTree = getMenuTree(getAllListMenu(MenuTarget.ADMIN.getValue()));
		log.info("@@ menuTree = {} ", menuTree);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("menuTree", menuTree);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	/**
	 * 메뉴 삭제
	 * @param request
	 * @param menuId
	 * @return
	 */
	@DeleteMapping(value = "/user/{menuId:[0-9]+}", produces = "application/json;charset=UTF-8")
	public Map<String, Object> userMenudelete(HttpServletRequest request, @PathVariable Integer menuId) {
		log.info("@@ menuId = {} ", menuId);
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		
		menuService.deleteMenu(menuId);
		String menuTree = getMenuTree(getAllListMenu(MenuTarget.USER.getValue()));
		log.info("@@ menuTree = {} ", menuTree);
		int statusCode = HttpStatus.OK.value();
		
		reloadCache();
		
		result.put("menuTree", menuTree);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
	
	private String getMenuTree(List<Menu> menuList) {
		if(menuList.isEmpty()) return "{}";
		
		StringBuilder builder = new StringBuilder();
		
		int count = menuList.size();
		int lastDepth = 0;
		Menu menu = menuList.get(0);
		
		// TODO + 를 append 로 변경 할것
		builder.append("[")
		.append("{")
		.append("\"menuId\"").append(":").append("\"" + menu.getMenuId() + "\"").append(",")
		.append("\"menuType\"").append(":").append("\"" + menu.getMenuType() + "\"").append(",")
		.append("\"menuTarget\"").append(":").append("\"" + menu.getMenuTarget() + "\"").append(",")
		.append("\"name\"").append(":").append("\"" + menu.getName() + "\"").append(",")
		.append("\"nameEn\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNameEn()) + "\"").append(",")
		.append("\"open\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getOpen()) + "\"").append(",")
		.append("\"nodeType\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNodeType()) + "\"").append(",")
		.append("\"ancestor\"").append(":").append("\"" + menu.getAncestor() + "\"").append(",")
		.append("\"parent\"").append(":").append("\"" + menu.getParent() + "\"").append(",")
		.append("\"parentName\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParentName()) + "\"").append(",")
		.append("\"depth\"").append(":").append("\"" + menu.getDepth() + "\"").append(",")
		.append("\"viewOrder\"").append(":").append("\"" + menu.getViewOrder() + "\"").append(",")
		.append("\"url\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrl()) + "\"").append(",")
		.append("\"urlAlias\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrlAlias()) + "\"").append(",")
		.append("\"aliasMenuId\"").append(":").append("\"" + menu.getAliasMenuId() + "\"").append(",")
		.append("\"htmlId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlId()) + "\"").append(",")
		.append("\"htmlContentId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlContentId()) + "\"").append(",")
		.append("\"image\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",")
		.append("\"imageAlt\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImageAlt()) + "\"").append(",")
		.append("\"cssClass\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCssClass()) + "\"").append(",")
		.append("\"defaultYn\"").append(":").append("\"" + menu.getDefaultYn() + "\"").append(",")
		.append("\"useYn\"").append(":").append("\"" + menu.getUseYn() + "\"").append(",")
		.append("\"displayYn\"").append(":").append("\"" + menu.getDisplayYn() + "\"").append(",")
		.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
		
		if(count > 1) {
			long preParent = menu.getParent();
			int preDepth = menu.getDepth();
			int bigParentheses = 0;
			for(int i=1; i<count; i++) {
				menu = menuList.get(i);
				lastDepth = menu.getDepth();
				
				if(preParent == menu.getParent()) {
					// 부모가 같은 경우
					builder.append("}");
					builder.append(",");
				} else {
					if(preDepth > menu.getDepth()) {
						// 닫힐때
						int closeCount = preDepth - menu.getDepth();
						for(int j=0; j<closeCount; j++) {
							builder.append("}");
							builder.append("]");
							bigParentheses--;
						}
						builder.append("}");
						builder.append(",");
					} else {
						// 열릴때
						builder.append(",");
						builder.append("\"subTree\"").append(":").append("[");
						bigParentheses++;
					}
				} 
				
				builder.append("{")
				.append("\"menuId\"").append(":").append("\"" + menu.getMenuId() + "\"").append(",")
				.append("\"menuType\"").append(":").append("\"" + menu.getMenuType() + "\"").append(",")
				.append("\"menuTarget\"").append(":").append("\"" + menu.getMenuTarget() + "\"").append(",")
				.append("\"name\"").append(":").append("\"" + menu.getName() + "\"").append(",")
				.append("\"nameEn\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNameEn()) + "\"").append(",")
				.append("\"open\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getOpen()) + "\"").append(",")
				.append("\"nodeType\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getNodeType()) + "\"").append(",")
				.append("\"ancestor\"").append(":").append("\"" + menu.getAncestor() + "\"").append(",")
				.append("\"parent\"").append(":").append("\"" + menu.getParent() + "\"").append(",")
				.append("\"parentName\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParentName()) + "\"").append(",")
				.append("\"depth\"").append(":").append("\"" + menu.getDepth() + "\"").append(",")
				.append("\"viewOrder\"").append(":").append("\"" + menu.getViewOrder() + "\"").append(",")
				.append("\"url\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrl()) + "\"").append(",")
				.append("\"urlAlias\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getUrlAlias()) + "\"").append(",")
				.append("\"aliasMenuId\"").append(":").append("\"" + menu.getUrlAlias() + "\"").append(",")
				.append("\"htmlId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlId()) + "\"").append(",")
				.append("\"htmlContentId\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getHtmlContentId()) + "\"").append(",")
				.append("\"image\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",")
				.append("\"imageAlt\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImageAlt()) + "\"").append(",")
				.append("\"cssClass\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCssClass()) + "\"").append(",")
				.append("\"defaultYn\"").append(":").append("\"" + menu.getDefaultYn() + "\"").append(",")
				.append("\"useYn\"").append(":").append("\"" + menu.getUseYn() + "\"").append(",")
				.append("\"displayYn\"").append(":").append("\"" + menu.getDisplayYn() + "\"").append(",")
				.append("\"description\"").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
				
				if(i == (count-1)) {
					// 맨 마지막의 경우 괄호를 닫음
					if(bigParentheses == 0) {
						if(preParent == 0) {
							builder.append("}");
						} else {
							builder.append("}");
						}
					} else {
						for(int k=0; k<bigParentheses; k++) {
							builder.append("}");
							builder.append("]");
						}
					}
				}
				
				preParent = menu.getParent();
				preDepth = menu.getDepth();
			}
		}
		
		if(lastDepth == 1) {
			builder.append("]");
		} else if(lastDepth == 2) {
			builder.append("}");
			builder.append("]");
		}
			
		return builder.toString();
	}
	
	private List<Menu> getAllListMenu(String target) {
		List<Menu> menuList = new ArrayList<>();
		Menu menu = new Menu();
		
		if (target.equals(MenuTarget.ADMIN.getValue())) {
			menu.setMenuType(MenuType.URL.getValue());
			menu.setMenuTarget(MenuTarget.ADMIN.getValue());
			menuList.addAll(menuService.getListMenu(menu));
		} else if (target.equals(MenuTarget.USER.getValue())) {
			// TODO 사용자의 경우 섞이는 경우가 대부분
			//menu.setMenuType(MenuType.HTMLID.getValue());
			menu.setMenuTarget(MenuTarget.USER.getValue());
			menuList.addAll(menuService.getListMenu(menu));
		} 
		
		return menuList;
	}
	
	private void reloadCache() {
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheName(CacheName.MENU);
		cacheParams.setCacheType(CacheType.BROADCAST);
		cacheConfig.loadCache(cacheParams);
	}
}
