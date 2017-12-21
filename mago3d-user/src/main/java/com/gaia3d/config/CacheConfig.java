package com.gaia3d.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.CacheName;
import com.gaia3d.domain.CacheType;
import com.gaia3d.domain.CommonCode;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.Menu;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.Project;
import com.gaia3d.domain.UserGroup;
import com.gaia3d.domain.UserGroupMenu;
import com.gaia3d.service.CommonCodeService;
import com.gaia3d.service.DataService;
import com.gaia3d.service.MenuService;
import com.gaia3d.service.PolicyService;
import com.gaia3d.service.ProjectService;
import com.gaia3d.service.UserGroupService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class CacheConfig {

	@Autowired
	private DataService dataService;
	@Autowired
	private ProjectService projectService;
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
		log.info("*************************************************");
		log.info("************* User Cache Init Start *************");
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
		
		commonCode(CacheType.SELF);

		log.info("*************************************************");
		log.info("************* User Cache Init End ***************");
		log.info("*************************************************");
	}

	public void loadCache(CacheName cacheName, CacheType cacheType) {
		log.info(" *************** loadCache cacheName = {}, cacheType = {}", cacheName.name(), cacheType.name());
		
		if(cacheName == CacheName.LICENSE) license(cacheType);
		else if(cacheName == CacheName.POLICY) policy(cacheType);
		else if(cacheName == CacheName.MENU) menu(cacheType);
		else if(cacheName == CacheName.COMMON_CODE) commonCode(cacheType);
		else if(cacheName == CacheName.PROJECT) data(cacheType);
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
	
	/**
	 * @param cacheType
	 */
	private void data(CacheType cacheType) {
		List<Project> projectList = projectService.getListProject(new Project());
		Map<Long, Project> projectMap = new HashMap<>();
		Map<Long, List<DataInfo>> projectDataMap = new HashMap<>();
		Map<Long, String> projectDataJsonMap = new HashMap<>();
		for(Project project : projectList) {
			projectMap.put(project.getProject_id(), project);
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setProject_id(project.getProject_id());
			List<DataInfo> dataInfoList = dataService.getListDataByProjectId(dataInfo);
			projectDataMap.put(project.getProject_id(), dataInfoList);
		
			projectDataJsonMap.put(project.getProject_id(), getProjectDataJson(project, dataInfoList));
		}
		
		CacheManager.setProjectList(projectList);
		CacheManager.setProjectMap(projectMap);
		CacheManager.setProjectDataMap(projectDataMap);
		CacheManager.setProjectDataJsonMap(projectDataJsonMap);
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
	
	private String getProjectDataJson(Project project, List<DataInfo> dataInfoList) {
		
		if(dataInfoList == null || dataInfoList.isEmpty()) return null;
		
		StringBuilder builder = new StringBuilder(256);
		
		int dataInfoCount = dataInfoList.size();
		int preDepth = 0;
		int brackets = 0;
		for(int i = 0; i < dataInfoCount; i++) {
			DataInfo dataInfo = dataInfoList.get(i);
			
			// 자식들 정보
			if(preDepth < dataInfo.getDepth()) {
				// 시작
				builder.append("{");
				// location 정보 및 attributes
				builder = getLocationAndAttributes(builder, dataInfo);
				// 자식 노드
				builder.append("\"children\"").append(":").append("[");
				brackets++;
			} else if(preDepth == dataInfo.getDepth()) {
				// 형제 노드, 닫는 처리
				builder.append("]");
				builder.append("}");
				
				builder.append(",");
				builder.append("{");
				// location 정보 및 attributes
				builder = getLocationAndAttributes(builder, dataInfo);
				// 자식 노드
				builder.append("\"children\"").append(":").append("[");
			} else {
				// 종료, 닫는처리
				int closeCount = preDepth - dataInfo.getDepth();
				for(int j=0; j<=closeCount; j++) {
					builder.append("]");
					builder.append("}");
					brackets--;
				}
				
				builder.append(",");
				builder.append("{");
				// location 정보 및 attributes
				builder = getLocationAndAttributes(builder, dataInfo);
				// 자식 노드
				builder.append("\"children\"").append(":").append("[");
			}
				
			if(dataInfoCount == (i+1)) {
				// 맨 마지막의 경우 괄호를 닫음
				for(int k=0; k<brackets; k++) {
					builder.append("]");
					builder.append("}");
				}
			}
			
			preDepth = dataInfo.getDepth();
		}
		
		log.info(" ************** {} json file **********", project.getProject_name());
		log.info(" ========= {} ", builder.toString());
		return builder.toString();
	}
	
	private StringBuilder getLocationAndAttributes(StringBuilder builder, DataInfo dataInfo) {
		builder.append("\"data_key\"").append(":").append("\"").append(dataInfo.getData_key()).append("\"").append(",");
		builder.append("\"data_name\"").append(":").append("\"").append(dataInfo.getData_name()).append("\"").append(",");
		builder.append("\"parent\"").append(":").append(dataInfo.getParent()).append(",");
		builder.append("\"depth\"").append(":").append(dataInfo.getDepth()).append(",");
		builder.append("\"view_order\"").append(":").append(dataInfo.getView_order()).append(",");
		if(dataInfo.getLatitude() != null) builder.append("\"latitude\"").append(":").append(dataInfo.getLatitude()).append(",");
		if(dataInfo.getLongitude() != null) builder.append("\"longitude\"").append(":").append(dataInfo.getLongitude()).append(",");
		if(dataInfo.getHeight() != null) builder.append("\"height\"").append(":").append(dataInfo.getHeight()).append(",");
		if(dataInfo.getHeading() != null) builder.append("\"heading\"").append(":").append(dataInfo.getHeading()).append(",");
		if(dataInfo.getPitch() != null) builder.append("\"pitch\"").append(":").append(dataInfo.getPitch()).append(",");
		if(dataInfo.getRoll() != null) builder.append("\"roll\"").append(":").append(dataInfo.getRoll()).append(",");
		builder.append("\"attributes\"").append(":").append(dataInfo.getAttributes()).append(",");
		
		return builder;
	}
}
