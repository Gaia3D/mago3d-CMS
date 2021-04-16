package gaia3d.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import gaia3d.domain.Key;
import gaia3d.domain.YOrN;
import gaia3d.domain.cache.CacheManager;
import gaia3d.domain.menu.Menu;
import gaia3d.domain.policy.Policy;
import gaia3d.domain.user.UserGroupMenu;
import gaia3d.domain.user.UserSession;
import gaia3d.support.URLSupport;
import lombok.extern.slf4j.Slf4j;

/**
 * 사이트 전체 설정 관련 처리를 담당
 *  
 * @author jeongdae
 *
 */
@Slf4j
@Component
public class ConfigInterceptor extends HandlerInterceptorAdapter {
	
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//		log.info("**** 버그 추적용 ConfigInterceptor ****");
    	
    	String uri = request.getRequestURI();
    	HttpSession session = request.getSession();
    	
    	Policy policy = CacheManager.getPolicy();
    	
    	// TODO 너무 비 효율 적이다. 좋은 방법을 찾자.
    	// 세션이 존재하지 않는 경우
    	UserSession userSession = (UserSession)session.getAttribute(Key.USER_SESSION.name());
    	if(userSession != null && userSession.getUserId() != null && !"".equals(userSession.getUserId())) {
	    	List<UserGroupMenu> userGroupMenuList = CacheManager.getUserGroupMenuList(userSession.getUserGroupId());
	    	Integer clickParentId = null;
			Integer clickMenuId = null;
			Integer clickDepth = null;
			
			for(UserGroupMenu userGroupMenu : userGroupMenuList) {
				if(uri.equals(userGroupMenu.getUrl())) {
					clickMenuId = userGroupMenu.getMenuId();
					if(userGroupMenu.getDepth() == 1) {
						clickParentId = userGroupMenu.getMenuId();
					} else {
						clickParentId = Integer.valueOf(userGroupMenu.getParent().toString());
					}
					clickDepth = userGroupMenu.getDepth();
					
					if( userGroupMenu.getDepth() == 1 && (uri.indexOf("/main/index")>=0) ) {
						break;
					} else if( userGroupMenu.getDepth() == 2) {
						break;
					} else {
						// pass
					}
				}
			}
			
			Menu menu = CacheManager.getMenuMap().get(clickMenuId);
			Menu parentMenu = CacheManager.getMenuMap().get(clickParentId);
			if(menu != null) {
				if(YOrN.Y == YOrN.valueOf(menu.getDisplayYn())) {
					menu.setAliasName(null);
					parentMenu.setAliasName(null);
				} else {
					Integer aliasMenuId = CacheManager.getMenuUrlMap().get(menu.getUrlAlias());
					Menu aliasMenu = CacheManager.getMenuMap().get(aliasMenuId);
					menu.setAliasName(aliasMenu.getName());
					menu.setAliasMenuId(aliasMenuId);
					parentMenu.setAliasName(aliasMenu.getName());
				}
			}
			
//			Integer contentLoadBalancingIntervalValue = policy.getContent_load_balancing_interval().intValue() * 1000;
//			request.setAttribute("contentLoadBalancingInterval", contentLoadBalancingIntervalValue);
			
			if(uri.indexOf("/main/index") < 0) {
				Menu originMenu = CacheManager.getMenuByUrl(uri);
//				log.info("+++++++++++++++++++++++ originMenu = {}", originMenu);
				if (originMenu != null) {
					log.info("+++++++++++++++++++++++ 메뉴 테이블에는 있는 메뉴");
					if (clickMenuId == null) {
						log.info("+++++++++++++++++++++++ 권한이 없는 메뉴");
						response.sendRedirect(URLSupport.FORBIDDEN_MENU);
						return false;
					}
				}
			}

			log.info("+++++++++++++++++++++++ clickMenuId = {}", clickMenuId);
//			log.info("+++++++++++++++++++++++ menu = {}", menu);
//			log.info("+++++++++++++++++++++++ parentMenu = {}", parentMenu);

			request.setAttribute("clickMenuId", clickMenuId);
//			request.setAttribute("clickParentId", clickParentId);
//			request.setAttribute("clickDepth", clickDepth);
			request.setAttribute("menu", menu);
			request.setAttribute("parentMenu", parentMenu);
			
			request.setAttribute("cacheUserGroupMenuList", userGroupMenuList);
			request.setAttribute("cacheUserGroupMenuListSize", userGroupMenuList.size());
			request.setAttribute("contentCacheVersion", policy.getContentCacheVersion());
    	}
    	
        return true;
    }
}
