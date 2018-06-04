package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.Menu;
import com.gaia3d.persistence.MenuMapper;
import com.gaia3d.service.MenuService;
import com.gaia3d.service.UserGroupService;

/**
 * 메뉴 처리
 * @author jeongdae
 *
 */
@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuMapper menuMapper;
	@Autowired
	private UserGroupService userGroupService;

	/**
	 * 메뉴 목록
	 * @param menu
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Menu> getListMenu(Menu menu) {
		return menuMapper.getListMenu(menu);
	}
	
	/**
	 * 메뉴 조회
	 * @param menu_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public Menu getMenu(Long menu_id) {
		return menuMapper.getMenu(menu_id);
	}
	
	/**
	 * 부모와 표시 순서로 메뉴 조회
	 * @param menu
	 * @return
	 */
	private Menu getMenuByParentAndViewOrder(Menu menu) {
		return menuMapper.getMenuByParentAndViewOrder(menu);
	}
	
	/**
	 * 자식 메뉴 중에 순서가 최대인 메뉴를 검색
	 * @param parent
	 * @return
	 */
	@Transactional(readOnly=true)
	public Menu getMaxViewOrderChildMenu(Long parent) {
		return menuMapper.getMaxViewOrderChildMenu(parent);
	}
	
//	/**
//	 * 화면 표시용 왼쪽 1Depth 메뉴 정보
//	 * @return
//	 */
//	public List<Menu> getListFirstDepthMenu() {
//		return menuMapper.getListFirstDepthMenu();
//	}
	
	/**
	 * 메뉴 등록
	 * @param menu
	 * @return
	 */
	@Transactional
	public Menu insertMenu(Menu menu) {
		menu.setMenu_id(menuMapper.getMaxMenuId());
		menuMapper.insertMenu(menu);
		userGroupService.insertUserGroupMenu(menu.getMenu_id());
		return menu;
	}
	
	/**
	 * 메뉴 수정
	 * @param menu
	 * @return
	 */
	@Transactional
	public int updateMenu(Menu menu) {
		if(menu.getDepth().intValue() == 1 && "N".equals(menu.getUse_yn())) {
			// 1 Depth 이고 미사용일 경우만 자식 메뉴를 전부 미사용으로 수정
			updateChildMenu(menu.getMenu_id());
		}
		return menuMapper.updateMenu(menu);
	}
	
	/**
	 * 메뉴 위로/아래로 수정
	 * @param menu
	 * @return
	 */
	@Transactional
	public int updateMoveMenu(Menu menu) {
		Integer modifyViewOrder = menu.getView_order();
		Menu searchMenu = new Menu();
		searchMenu.setUpdate_type(menu.getUpdate_type());
		searchMenu.setParent(menu.getParent());
		if("up".equals(menu.getUpdate_type())) {
			// 바로 위 메뉴의 view_order 를 +1
			searchMenu.setView_order(menu.getView_order());
			searchMenu = getMenuByParentAndViewOrder(searchMenu);
			menu.setView_order(searchMenu.getView_order());
			searchMenu.setView_order(modifyViewOrder);
		} else {
			// 바로 아래 메뉴의 view_order 를 -1 함
			searchMenu.setView_order(menu.getView_order());
			searchMenu = getMenuByParentAndViewOrder(searchMenu);
			menu.setView_order(searchMenu.getView_order());
			searchMenu.setView_order(modifyViewOrder);
		}
		updateViewOrderMenu(searchMenu);
		
		return updateViewOrderMenu(menu);
	}
	
	private int updateViewOrderMenu(Menu menu) {
		return menuMapper.updateViewOrderMenu(menu);
	}
	
	/**
	 * 자식 메뉴 일괄 수정
	 * @param parent
	 * @return
	 */
	private int updateChildMenu(Long parent) {
		return menuMapper.updateChildMenu(parent);
	}
	
	/**
	 * 메뉴 삭제
	 * @param menu_id
	 * @return
	 */
	@Transactional
	public int deleteMenu(Long menu_id) {
		return deleteMenuList(menu_id);
	}
	
	/**
	 * 메뉴 삭제 메소드
	 * @param menu_id
	 * @return
	 */
	private int deleteMenuList(Long menu_id) { 
		// 자식 목록 리스트
		List<Long> childMenuIdList = menuMapper.getListChildMenuId(menu_id);
	
		if(childMenuIdList != null && !childMenuIdList.isEmpty()) {
			for(Long childMenuId : childMenuIdList) {
				deleteMenu(childMenuId);
			}
			
			// 사용자 그룹 메뉴 삭제
			childMenuIdList.add(menu_id);
			userGroupService.deleteUserGroupMenuList(childMenuIdList);
		}
		return menuMapper.deleteMenu(menu_id);
	}
}
