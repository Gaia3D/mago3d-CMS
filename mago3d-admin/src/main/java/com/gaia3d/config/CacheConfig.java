package com.gaia3d.config;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Policy;
import com.gaia3d.service.PolicyService;

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
//	@Autowired
//	private MenuService menuService;
//	@Autowired
//	private UserGroupService userGroupService;
	@Autowired
	private PolicyService policyService;
//	@Autowired
//	private APIService aPIService;
//	@Autowired
//	private CommonCodeService commonCodeService;
//	@Autowired
//	private ServerService serverService;	
	
	public static final String LOCALHOST = "localhost";

	@PostConstruct
	public void init() {
		log.info("**************** Admin 캐시 초기화 시작 *****************");

		// 라이선스 유호성 체크
		loadLicense();

		// 운영 정책 캐시 갱신
		loadPolicy();
		// 메뉴, 사용자 그룹 메뉴 갱신
		loadMenu();
		// 사용자 그룹 캐시, 확장용
		// loadUserGroup();
		// 서버 그룹 캐시 갱신, 확장용
		// loadServerGroup();
		// 공통 코드 캐시 갱신
		loadCommonCode();

		log.info("**************** Admin 캐시 초기화 종료 *****************");
	}

	private void loadLicense() {

	}

	private void loadPolicy() {
		Policy policy = policyService.getPolicy();
		CacheManager.setPolicy(policy);
	}

	private void loadMenu() {

	}

	private void loadCommonCode() {

	}

	enum CacheType {
		LICENSE, POLICY, MENU, USER_GROUP, SERVER_GROUP, COMMON_CODE, EXTERNAL
	};
}
