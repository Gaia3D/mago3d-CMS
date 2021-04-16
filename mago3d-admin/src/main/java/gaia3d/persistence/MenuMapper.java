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
	List<Menu> getListMenu(Menu menu);
	
	/**
	 * 메뉴 조회
	 * @param menuId
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
	int updateViewOrderMenu(Menu menu);
	
	/**
	 * 자식 메뉴 일괄 수정
	 * @param parent
	 * @return
	 */
	int updateChildMenu(Integer parent);
	
	/**
	 * 메뉴 삭제
	 * @param menuId
	 * @return
	 */
	int deleteMenu(Integer menuId);
}
