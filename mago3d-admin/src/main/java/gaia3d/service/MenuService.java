package gaia3d.service;

import java.util.List;

import gaia3d.domain.menu.Menu;

/**
 * 메뉴 관리
 * @author jeongdae
 *
 */
public interface MenuService {
	
	/**
	 * 메뉴 목록
	 * @param menu
	 * @return
	 */
	public List<Menu> getListMenu(Menu menu);
	
	/**
	 * 메뉴 조회
	 * @param menuId
	 * @return
	 */
	Menu getMenu(Integer menuId);
	
	/**
	 * 자식 메뉴 중에 순서가 최대인 메뉴를 검색
	 * @param menu
	 * @return
	 */
	Menu getMaxViewOrderChildMenu(Menu menu);
	
	/**
	 * 메뉴 등록
	 * @param menu
	 * @return
	 */
	int insertMenu(Menu menu);
	
	/**
	 * 메뉴 수정
	 * @param menu
	 * @return
	 */
	int updateMenu(Menu menu);
	
	/**
	 * 메뉴 위로/아래로 수정
	 * @param menu
	 * @return
	 */
	int updateMoveMenu(Menu menu);
	
	/**
	 * 메뉴 삭제
	 * @param menuId
	 * @return
	 */
	int deleteMenu(Integer menuId);
	
}
