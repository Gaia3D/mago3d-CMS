package com.gaia3d.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Menu;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.SessionKey;
import com.gaia3d.domain.UserGroupMenu;
import com.gaia3d.domain.UserSession;
import com.gaia3d.helper.URLHelper;

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
    	
    	String uri = request.getRequestURI();
    	HttpSession session = request.getSession();
    	String sessionSiteName = (String)session.getAttribute(SessionKey.SESSION_SITE_NAME.name());
    	if(sessionSiteName == null || "".equals(sessionSiteName)) {
    		Policy policy = CacheManager.getPolicy();
    		session.setAttribute(SessionKey.SESSION_SITE_NAME.name(), policy.getSite_name());
    	}
    	
    	request.setAttribute("sessionSiteName", sessionSiteName);
    	
    	// TODO 너무 비 효율 적이다. 좋은 방법을 찾자.
    	// 세션이 존재하지 않는 경우
    	UserSession userSession = (UserSession)session.getAttribute(UserSession.KEY);
    	if(userSession != null && userSession.getUser_id() != null && !"".equals(userSession.getUser_id())) {
	    	List<UserGroupMenu> userGroupMenuList = CacheManager.getListUserGroupMenu(userSession.getUser_group_id());
			Long clickParentId = null;
			Long clickMenuId = null;
			Integer clickDepth = null;
			Menu menu = null;
			Menu parentMenu = null;
			
			for(UserGroupMenu userGroupMenu : userGroupMenuList) {
				if(uri.equals(userGroupMenu.getUrl())) {
					clickMenuId = userGroupMenu.getMenu_id();
					if(userGroupMenu.getDepth() == 1) {
						clickParentId = userGroupMenu.getMenu_id();
					} else {
						clickParentId = Long.valueOf(userGroupMenu.getParent().toString());
					}
					clickDepth = userGroupMenu.getDepth();
					
					if( userGroupMenu.getDepth() == 1 && (uri.indexOf("/main/index.do")>=0) ) {
						break;
					} else if( userGroupMenu.getDepth() == 2) {
						break;
					} else {
						continue;
					}
				}
			}
			
			menu = CacheManager.getMenuMap().get(clickMenuId);
			parentMenu = CacheManager.getMenuMap().get(clickParentId);
			
			if(menu != null) {
				if(Menu.Y.equals(menu.getDisplay_yn())) {
					menu.setAlias_name(null);
					parentMenu.setAlias_name(null);
				} else {
					Long aliasMenuId = CacheManager.getMenuUrlMap().get(menu.getUrl_alias());
					Menu aliasMenu = CacheManager.getMenuMap().get(aliasMenuId);
					menu.setAlias_name(aliasMenu.getName());
					parentMenu.setAlias_name(aliasMenu.getName());
				}
			}
			
			String standByServerStatus = CacheManager.getStandByServerStatus();
			if(standByServerStatus == null || "".equals(standByServerStatus)) standByServerStatus = "OFF";
			
			request.setAttribute("standByServerStatus", standByServerStatus);
			
//			Integer contentLoadBalancingIntervalValue = policy.getContent_load_balancing_interval().intValue() * 1000;
//			request.setAttribute("contentLoadBalancingInterval", contentLoadBalancingIntervalValue);
			
			request.setAttribute("clickMenuId", clickMenuId);
//			request.setAttribute("clickParentId", clickParentId);
//			request.setAttribute("clickDepth", clickDepth);
			request.setAttribute("menu", menu);
			request.setAttribute("parentMenu", parentMenu);
			
			request.setAttribute("cacheUserGroupMenuList", userGroupMenuList);
			request.setAttribute("cacheUserGroupMenuListSize", userGroupMenuList.size());
    	}
    	
        return true;
    }
}
