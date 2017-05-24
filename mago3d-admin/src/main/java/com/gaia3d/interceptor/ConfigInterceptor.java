package com.gaia3d.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


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
    	String sessionSiteName = (String)session.getAttribute("SESSION_SITE_NAME");
//    	if(sessionSiteName == null || "".equals(sessionSiteName)) {
//    		Policy policy = ConfigCache.getPolicy();
//    		session.setAttribute("SESSION_SITE_NAME", policy.getSite_name());
//    	}
//    	
//    	request.setAttribute("sessionSiteName", sessionSiteName);
//    	
//    	// TODO 너무 비 효율 적이다. 좋은 방법을 찾자.
//    	// 세션이 존재하지 않는 경우
//    	UserSession userSession = (UserSession)session.getAttribute(UserSession.KEY);
//    	if(userSession != null && userSession.getUser_id() != null && !"".equals(userSession.getUser_id())) {
//	    	List<UserGroupMenu> userGroupMenuList = ConfigCache.getListUserGroupMenu(userSession.getUser_group_id());
//			Long clickParentId = null;
//			Long clickMenuId = null;
//			Integer clickDepth = null;
//			Menu menu = null;
//			Menu parentMenu = null;
//			
//			// aliasURL을 먼저 찾음
//			String[][] arrayURI = URLHelper.ALIAS_URI;
//			String aliasURI = null;
//			String aliasName = null;
//			int count = arrayURI.length;
//			for(int i=0; i<count; i++) {
//				if(uri.equals(arrayURI[i][0])) {
//					aliasURI = arrayURI[i][1];
//					aliasName = arrayURI[i][2];
//					break;
//				}
//			}
//			if(aliasURI != null) uri = aliasURI;
//			
////			log.info("## userGroupMenuList = {}", userGroupMenuList);
//			for(UserGroupMenu userGroupMenu : userGroupMenuList) {
//				if(uri.equals(userGroupMenu.getUrl())) {
//					clickMenuId = userGroupMenu.getMenu_id();
//					if(userGroupMenu.getDepth() == 1) {
//						clickParentId = userGroupMenu.getMenu_id();
//					} else {
//						clickParentId = Long.valueOf(userGroupMenu.getParent().toString());
//					}
//					clickDepth = userGroupMenu.getDepth();
//					
//					if( userGroupMenu.getDepth() == 1 && (uri.indexOf("/main/index.do")>=0) ) {
//						break;
//					} else if( userGroupMenu.getDepth() == 2) {
//						break;
//					} else {
//						continue;
//					}
//				}
//			}
//			
//			menu = ConfigCache.getMapMenu().get(clickMenuId);
//			parentMenu = ConfigCache.getMapMenu().get(clickParentId);
//			if(aliasURI == null) {
//				if(menu != null) {
//					menu.setAlias_name(null);
//					parentMenu.setAlias_name(null);
//				}
//			} else {
//				menu.setAlias_name(aliasName);
//				parentMenu.setAlias_name(aliasName);
//			}
//			
//			String standByServerStatus = ConfigCache.getStandByServerStatus();
//			if(standByServerStatus == null || "".equals(standByServerStatus)) standByServerStatus = "OFF";
//			
//			request.setAttribute("standByServerStatus", standByServerStatus);
//			
////			Integer contentLoadBalancingIntervalValue = policy.getContent_load_balancing_interval().intValue() * 1000;
////			request.setAttribute("contentLoadBalancingInterval", contentLoadBalancingIntervalValue);
//			
//			request.setAttribute("clickMenuId", clickMenuId);
////			request.setAttribute("clickParentId", clickParentId);
////			request.setAttribute("clickDepth", clickDepth);
//			request.setAttribute("menu", menu);
//			request.setAttribute("parentMenu", parentMenu);
//			
//			request.setAttribute("cacheUserGroupMenuList", userGroupMenuList);
//			request.setAttribute("cacheUserGroupMenuListSize", userGroupMenuList);
//    	}
    	
        return true;
    }
}
