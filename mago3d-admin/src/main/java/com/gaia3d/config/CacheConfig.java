package com.gaia3d.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheType;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.DataGroup;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.ExternalService;
import com.gaia3d.domain.Menu;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserGroup;
import com.gaia3d.domain.UserGroupMenu;
import com.gaia3d.helper.HttpClientHelper;
import com.gaia3d.security.Crypt;
import com.gaia3d.service.APIService;
import com.gaia3d.service.CommonCodeService;
import com.gaia3d.service.DataGroupService;
import com.gaia3d.service.DataService;
import com.gaia3d.service.MenuService;
import com.gaia3d.service.PolicyService;
import com.gaia3d.service.UserGroupService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CacheConfig {

	@Autowired
	private APIService aPIService;
	@Autowired
	private DataService dataService;
	@Autowired
	private DataGroupService dataGroupService;
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
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	
	public static final String LOCALHOST = "localhost";

	@PostConstruct
	public void init() {
		log.info("**************** Admin 캐시 초기화 시작 *****************");
		log.info("*************************************************");

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
		
		// 데이터를 그룹별로 로딩
		data(CacheType.SELF);
		
		// Private API Cache 갱신
		externalServiceCache(CacheType.SELF);
		
		commonCode(CacheType.SELF);

		log.info("**************** Admin 캐시 초기화 종료 *****************");
	}

	public void loadCache(CacheName cacheName, CacheType cacheType) {
		if(cacheName == CacheName.LICENSE) license(cacheType);
		else if(cacheName == CacheName.POLICY) policy(cacheType);
		else if(cacheName == CacheName.MENU) menu(cacheType);
		else if(cacheName == CacheName.COMMON_CODE) commonCode(cacheType);
		else if(cacheName == CacheName.DATA_GROUP) data(cacheType);
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
			callRemoteCache(CacheName.POLICY);
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
	
	/**
	 * @param cacheType
	 */
	private void data(CacheType cacheType) {
		Map<String, Map<String, DataInfo>> dataGroupMap = new HashMap<>();
		List<DataInfo> allDataInfoList = new ArrayList<>();
		
		// 1 Depth group 정보를 전부 가져옴
		List<DataGroup> dataGroupList = dataGroupService.getListDataGroupByDepth(1);
		// 1 그룹별 하위 object 정보들을 전부 가져옴
		for(DataGroup dataGroup : dataGroupList) {
			List<DataGroup> childGroupList = dataGroupService.getListDataGroupByAncestor(dataGroup.getData_group_id());
//			List<DataInfo> allChildDataInfoList = new ArrayList<>();
			for(DataGroup childDataGroup : childGroupList) {
				DataInfo dataInfo = new DataInfo();
				dataInfo.setData_group_id(childDataGroup.getData_group_id());
//				allChildDataInfoList.addAll(dataService.getListDataByDataGroupId(dataInfo));
				allDataInfoList.addAll(dataService.getListDataByDataGroupId(dataInfo));
			}
//			dataGroupMap.put(dataGroup.getData_group_key(), allChildDataInfoList);
		}
		
		Map<String, DataInfo> allDataInfoMap = new HashMap<>();
		for(DataInfo dataInfo : allDataInfoList) {
			allDataInfoMap.put(dataInfo.getData_key(), dataInfo);
		}
		
		dataGroupMap.put("alldata", allDataInfoMap);
		
		CacheManager.setProjectDataGroupList(dataGroupList);
		CacheManager.setDataGroupMap(dataGroupMap);
		
		if(cacheType == CacheType.BROADCAST) {
			callRemoteCache(CacheName.DATA_GROUP);
		}
	}

	private void commonCode(CacheType cacheType) {
		List<CommonCode> commonCodeList = commonCodeService.getListCommonCode();
		log.info(" commonCodeList size = {}", commonCodeList.size());
		Map<String, Object> commonCodeMap = new HashMap<>();
		
		List<CommonCode> emailList = new ArrayList<>();
		List<CommonCode> issuePriorityList = new ArrayList<>();
		List<CommonCode> issueTypeList = new ArrayList<>();
		List<CommonCode> issueStatusList = new ArrayList<>();
		List<CommonCode> userRegisterTypeList = new ArrayList<>();
		List<CommonCode> dataRegisterTypeList = new ArrayList<>();
		
		for(CommonCode commonCode : commonCodeList) {
			if(CommonCode.USER_EMAIL.equals(commonCode.getCode_type())) {
				// 이메일
				emailList.add(commonCode);
			} else if(CommonCode.USER_REGISTER_TYPE.equals(commonCode.getCode_type())) {
				// 사용자 등록 타입
				userRegisterTypeList.add(commonCode);
			} else if(CommonCode.ISSUE_PRIORITY.equals(commonCode.getCode_type())) {
				// 이슈 우선순위
				issuePriorityList.add(commonCode);
			} else if(CommonCode.ISSUE_TYPE.equals(commonCode.getCode_type())) {
				// 이슈 유형
				issueTypeList.add(commonCode);
			} else if(CommonCode.ISSUE_STATUS.equals(commonCode.getCode_type())) {
				// 이슈 상태
				issueStatusList.add(commonCode);
			} else if(CommonCode.DATA_REGISTER_TYPE.equals(commonCode.getCode_type())) {
				// data 등록 타입
				dataRegisterTypeList.add(commonCode);
			}
			commonCodeMap.put(commonCode.getCode_key(), commonCode);
		}
		
		// TODO 여기 다시 설계 해야 할거 같다. 
		commonCodeMap.put(CommonCode.USER_EMAIL, emailList);
		commonCodeMap.put(CommonCode.USER_REGISTER_TYPE, userRegisterTypeList);
		commonCodeMap.put(CommonCode.ISSUE_PRIORITY, issuePriorityList);
		commonCodeMap.put(CommonCode.ISSUE_TYPE, issueTypeList);
		commonCodeMap.put(CommonCode.ISSUE_STATUS, issueStatusList);
		commonCodeMap.put(CommonCode.DATA_REGISTER_TYPE, dataRegisterTypeList);
		CacheManager.setCommonCodeMap(commonCodeMap);
		
		// 사용자 도메인 cache를 갱신
		if(cacheType == CacheType.USER || cacheType == CacheType.BROADCAST) {
			
		}
		// 이중화 도메인 사용자, 관리자 cache를 갱신
		if(cacheType == CacheType.BROADCAST) {
			
		}
	}
	
	/**
	 * Private API Cache 갱신
	 */
	private void externalServiceCache(CacheType cacheType) {
		ExternalService service = new ExternalService();
		service.setStatus(ExternalService.STATUS_USE);
		List<ExternalService> externalCacheList = aPIService.getListExternalService(service);
		
//		List<ExternalService> remoteCacheServiceList = new ArrayList<ExternalService>();
//		for(ExternalService externalService : externalCacheList) {
//			if(ExternalService.EXTERNAL_CACHE.equals(externalService.getService_type())) {
//				remoteCacheServiceList.add(externalService);
//			} else if(ExternalService.HA.equals(externalService.getService_type())) {
//				//remoteHAServiceList.add(externalService);
//			}
//		}
		
		CacheManager.setRemoteCacheServiceList(externalCacheList);
	}
	
	/**
	 * Remote Cache 갱신 요청
	 * @param cacheName
	 */
	private void callRemoteCache(CacheName cacheName) {
		
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ callRemoteCache start! ");
		// TODO 로컬, 이중화 등의 분기 처리가 생략되어 있음
		List<ExternalService> remoteCacheServerList = CacheManager.getRemoteCacheServiceList();
		for(ExternalService externalService : remoteCacheServerList) {
			// TODO 환경 설정으로 빼서 로컬이거나 단독 서버인 경우 호출하지 않게 설계해야 함
			String authData = "api-key=" + Crypt.decrypt(propertiesConfig.getRestAuthKey()) + "&cache_name=" + cacheName.toString() + "&time=" + System.nanoTime();
			authData = Crypt.encrypt(authData);
			try {
				Map<String, Object> resultObject = HttpClientHelper.httpPost(externalService, authData);
				if(resultObject != null && !resultObject.isEmpty() ) {
					int statusCode = (Integer)resultObject.get("statusCode");
					String statusCodeValue = (String)resultObject.get("statusCodeValue");
					String result = (String)resultObject.get("result");
					log.error("@@@ statusCode = {}.", statusCode);
					log.error("@@@ statusCodeValue = {}.", statusCodeValue);
					log.error("@@@ result = {}.", result);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
}
