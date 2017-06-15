package com.gaia3d.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.Menu;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserGroup;
import com.gaia3d.domain.UserGroupMenu;
import com.gaia3d.service.CommonCodeService;
import com.gaia3d.service.MenuService;
import com.gaia3d.service.PolicyService;
import com.gaia3d.service.UserGroupService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CacheConfig {

	@Autowired
	private ApplicationContext context;
	@Autowired
	private PropertiesConfig propertiesConfig;

//	@Autowired
//	private LicenseService licenseService;
	@Autowired
	private MenuService menuService;
	@Autowired
	private UserGroupService userGroupService;
	@Autowired
	private PolicyService policyService;
//	@Autowired
//	private APIService aPIService;
	@Autowired
	private CommonCodeService commonCodeService;
//	@Autowired
//	private ServerService serverService;	
	
	public static final String LOCALHOST = "localhost";

	@PostConstruct
	public void init() {
		log.info("**************** Admin 캐시 초기화 시작 *****************");

		// 라이선스 유호성 체크
		license(CacheType.SELF);
		// 운영 정책 캐시 갱신
		policy(CacheType.SELF);
		// 메뉴, 사용자 그룹 메뉴 갱신
		menu(CacheType.SELF);
		// 사용자 그룹 캐시, 확장용
		// loadUserGroup();
		// 서버 그룹 캐시 갱신, 확장용
		// loadServerGroup();
		// 공통 코드 캐시 갱신
		commonCode(CacheType.SELF);

		log.info("**************** Admin 캐시 초기화 종료 *****************");
	}

	public void loadCache(CacheName cacheName, CacheType cacheType) {
		if(cacheName == CacheName.LICENSE) license(cacheType);
		else if(cacheName == CacheName.POLICY) policy(cacheType);
		else if(cacheName == CacheName.MENU) menu(cacheType);
		else if(cacheName == CacheName.COMMON_CODE) commonCode(cacheType);
	}
	
	private void license(CacheType cacheType) {
		// 사용자 도메인 cache를 갱신
		if(cacheType == CacheType.USER || cacheType == CacheType.BROADCAST) {
			
		}
		// 이중화 도메인 사용자, 관리자 cache를 갱신
		if(cacheType == CacheType.BROADCAST) {
			
		}
	}

	private void policy(CacheType cacheType) {
		Policy policy = policyService.getPolicy();
		CacheManager.setPolicy(policy);
		// 사용자 도메인 cache를 갱신
		if(cacheType == CacheType.USER || cacheType == CacheType.BROADCAST) {
			
		}
		// 이중화 도메인 사용자, 관리자 cache를 갱신
		if(cacheType == CacheType.BROADCAST) {
			
		}
	}

	private void menu(CacheType cacheType) {
		Map<Long, Menu> menuMap = new HashMap<Long, Menu>();
		List<Menu> menuList = menuService.getListMenu(null);
		for(Menu menu : menuList) {
			menuMap.put(menu.getMenu_id(), menu);
		}
		
		Map<Long, List<UserGroupMenu>> userGroupMenuMap = new HashMap<Long, List<UserGroupMenu>>();
		List<UserGroup> userGroupList = userGroupService.getListUserGroup(new UserGroup());
		for(UserGroup userGroup : userGroupList) {
			List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroup);
			userGroupMenuMap.put(userGroup.getUser_group_id(), userGroupMenuList);
		}
		
		CacheManager.setMenuMap(menuMap);
		CacheManager.setUserGroupMenuMap(userGroupMenuMap);
		
		// 사용자 도메인 cache를 갱신
		if(cacheType == CacheType.USER || cacheType == CacheType.BROADCAST) {
			
		}
		// 이중화 도메인 사용자, 관리자 cache를 갱신
		if(cacheType == CacheType.BROADCAST) {
			
		}
	}

	private void commonCode(CacheType cacheType) {
		List<CommonCode> commonCodeList = commonCodeService.getListCommonCode();
		Map<String, Object> commonCodeMap = new HashMap<>();
		
		List<CommonCode> emailList = new ArrayList<CommonCode>();
		List<CommonCode> issuePriorityList = new ArrayList<CommonCode>();
		List<CommonCode> issueTypeList = new ArrayList<CommonCode>();
		List<CommonCode> issueStatusList = new ArrayList<CommonCode>();
		
		for(CommonCode commonCode : commonCodeList) {
			if(CommonCode.USER_REGISTER_EMAIL.equals(commonCode.getCode_key())) {
				// 이메일
				emailList.add(commonCode);
			} else if(CommonCode.ISSUE_PRIORITY.equals(commonCode.getCode_key())) {
				// 이슈 우선순위
				issuePriorityList.add(commonCode);
			} else if(CommonCode.ISSUE_TYPE.equals(commonCode.getCode_key())) {
				// 이슈 유형
				issueTypeList.add(commonCode);
			} else if(CommonCode.ISSUE_STATUS.equals(commonCode.getCode_key())) {
				// 이슈 상태
				issueStatusList.add(commonCode);
			} else {
				commonCodeMap.put(commonCode.getCode_key(), commonCode);
			}
		}
		
		// TODO 여기 다시 설계 해야 할거 같다. 
		commonCodeMap.put(CommonCode.USER_REGISTER_EMAIL, emailList);
		commonCodeMap.put(CommonCode.ISSUE_PRIORITY, issuePriorityList);
		commonCodeMap.put(CommonCode.ISSUE_TYPE, issueTypeList);
		commonCodeMap.put(CommonCode.ISSUE_STATUS, issueStatusList);
		CacheManager.setCommonCodeMap(commonCodeMap);
		
		// 사용자 도메인 cache를 갱신
		if(cacheType == CacheType.USER || cacheType == CacheType.BROADCAST) {
			
		}
		// 이중화 도메인 사용자, 관리자 cache를 갱신
		if(cacheType == CacheType.BROADCAST) {
			
		}
	}

	enum CacheName {
		LICENSE, POLICY, MENU, USER_GROUP, SERVER_GROUP, COMMON_CODE, EXTERNAL
	};
	
	enum CacheType {
		SELF, USER, BROADCAST
	}
}
