package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.menu.Menu;


/**
 * 메뉴 처리
 * @author jeongdae
 *
 */
@Repository
public interface MenuMapper {

	/**
	 * 메뉴 목록
	 * @param menu
	 * @return
	 */
	public List<Menu> getListMenu(Menu menu);
	
	/**
	 * 메뉴 조회
	 * @param menu_id
	 * @return
	 */
	Menu getMenu(Integer menuId);
	
	/**
	 * 부모와 표시 순서로 메뉴 조회
	 * @param menu
	 * @return
	 */
	Menu getMenuByParentAndViewOrder(Menu menu);
	
	/**
	 * 자식 메뉴 중에 순서가 최대인 메뉴를 검색
	 * @param menu
	 * @return
	 */
	Menu getMaxViewOrderChildMenu(Menu menu);
	
/**
	 * 자식 메뉴 목록
	 * @param parent
	 * @return
	 */
	List<Integer> getListChildMenuId(Integer parent);
}
