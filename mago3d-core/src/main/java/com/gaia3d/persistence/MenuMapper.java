package com.gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.gaia3d.domain.Menu;


/**
 * 메뉴 처리
 * @author jeongdae
 *
 */
@Repository
public interface MenuMapper {

	/**
	 * menu_id 최대값
	 * @return
	 */
	Long getMaxMenuId();
	
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
	Menu getMenu(Long menu_id);
	
	/**
	 * 부모와 표시 순서로 메뉴 조회
	 * @param menu
	 * @return
	 */
	Menu getMenuByParentAndViewOrder(Menu menu);
	
	/**
	 * 자식 메뉴 중에 순서가 최대인 메뉴를 검색
	 * @param parent
	 * @return
	 */
	Menu getMaxViewOrderChildMenu(Long parent);
	
//	/**
//	 * 화면 표시용 왼쪽 1Depth 메뉴 정보
//	 * @return
//	 */
//	List<Menu> getListFirstDepthMenu();
	
	/**
	 * 자식 메뉴 목록
	 * @param parent
	 * @return
	 */
	List<Long> getListChildMenuId(Long parent);
	
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
	int updateChildMenu(Long parent);
	
	/**
	 * 메뉴 삭제
	 * @param menu_id
	 * @return
	 */
	int deleteMenu(Long menu_id);
}
