package com.gaia3d.service;

import java.util.List;

import com.gaia3d.domain.Menu;

/**
 * 메뉴 관리
 * @author jeongdae
 *
 */
public interface MenuService {
	
	/**
	 * 메뉴 목록
	 * @param default_yn
	 * @return
	 */
	public List<Menu> getListMenu(String default_yn);
	
	/**
	 * 메뉴 조회
	 * @param menu_id
	 * @return
	 */
	Menu getMenu(Long menu_id);
	
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
//	public List<Menu> getListFirstDepthMenu();
	
	/**
	 * 메뉴 등록
	 * @param menu
	 * @return
	 */
	Menu insertMenu(Menu menu);
	
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
	 * @param menu_id
	 * @return
	 */
	int deleteMenu(Long menu_id);
}
