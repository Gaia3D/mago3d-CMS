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
	 * 자식 메뉴 중에 순서가 최대인 메뉴를 검색
	 * @param menu
	 * @return
	 */
	@Transactional(readOnly=true)
	public Menu getMaxViewOrderChildMenu(Menu menu) {
		return menuMapper.getMaxViewOrderChildMenu(menu);
	}
}
