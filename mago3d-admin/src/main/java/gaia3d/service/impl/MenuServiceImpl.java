package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.menu.Menu;
import gaia3d.persistence.MenuMapper;
import gaia3d.service.MenuService;

/**
 * 메뉴 처리
 * @author jeongdae
 *
 */
@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	private MenuMapper menuMapper;
	
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
	 * @param menuId
	 * @return
	 */
	@Transactional(readOnly=true)
	public Menu getMenu(Integer menuId) {
		return menuMapper.getMenu(menuId);
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
	 * @param menu
	 * @return
	 */
	@Transactional(readOnly=true)
	public Menu getMaxViewOrderChildMenu(Menu menu) {
		return menuMapper.getMaxViewOrderChildMenu(menu);
	}
	
/**
	 * 메뉴 등록
	 * @param menu
	 * @return
	 */
	@Transactional
	public int insertMenu(Menu menu) {
		return menuMapper.insertMenu(menu);
	}
	
	/**
	 * 메뉴 수정
	 * @param menu
	 * @return
	 */
	@Transactional
	public int updateMenu(Menu menu) {
		if(menu.getDepth() == 1 && "N".equals(menu.getUseYn())) {
			// 1 Depth 이고 미사용일 경우만 자식 메뉴를 전부 미사용으로 수정
			updateChildMenu(menu.getMenuId());
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
		Integer modifyViewOrder = menu.getViewOrder();
		Menu searchMenu = new Menu();
		searchMenu.setMenuTarget(menu.getMenuTarget());
		searchMenu.setUpdateType(menu.getUpdateType());
		searchMenu.setParent(menu.getParent());
		
		if("up".equals(menu.getUpdateType())) {
			// 바로 위 메뉴의 view_order 를 +1
			searchMenu.setViewOrder(menu.getViewOrder());
			searchMenu = getMenuByParentAndViewOrder(searchMenu);
			menu.setViewOrder(searchMenu.getViewOrder());
			searchMenu.setViewOrder(modifyViewOrder);
		} else {
			// 바로 아래 메뉴의 view_order 를 -1 함
			searchMenu.setViewOrder(menu.getViewOrder());
			searchMenu = getMenuByParentAndViewOrder(searchMenu);
			menu.setViewOrder(searchMenu.getViewOrder());
			searchMenu.setViewOrder(modifyViewOrder);
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
	private int updateChildMenu(Integer parent) {
		return menuMapper.updateChildMenu(parent);
	}
	
	/**
	 * 메뉴 삭제
	 * @param menuId
	 * @return
	 */
	@Transactional
	public int deleteMenu(Integer menuId) {
		return deleteMenuList(menuId);
	}
	
	/**
	 * 메뉴 삭제 메소드
	 * @param menuId
	 * @return
	 */
	private int deleteMenuList(Integer menuId) { 
		// 자식 목록 리스트
		List<Integer> childMenuIdList = menuMapper.getListChildMenuId(menuId);
	
		if(childMenuIdList != null && !childMenuIdList.isEmpty()) {
			for(Integer childMenuId : childMenuIdList) {
				deleteMenu(childMenuId);
			}
			
			// 사용자 그룹 메뉴 삭제
			childMenuIdList.add(menuId);
			
			// TODO 사용자 메뉴도 삭제해야 함
			//userGroupService.deleteUserGroupMenuList(childMenuIdList);
		}
		return menuMapper.deleteMenu(menuId);
	}
	
}
