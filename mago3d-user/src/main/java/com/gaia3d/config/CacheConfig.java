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
import com.gaia3d.domain.CacheParams;
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
		
		CacheParams cacheParams = new CacheParams();
		cacheParams.setCacheType(CacheType.SELF);

		// 라이선스 유호성 체크
		license(cacheParams);
		// 운영 정책 캐시 갱신
		policy(cacheParams);
		// 메뉴, 사용자 그룹 메뉴 갱신
		menu(cacheParams);
		// 사용자 그룹 캐시, 확장용
		// loadUserGroup();
		// 서버 그룹 캐시 갱신, 확장용
		// loadServerGroup();
		// 공통 코드 캐시 갱신
		
		// 프로젝트 갱신
		project(cacheParams);
		// 데이터를 프로젝트별로 로딩
		data(cacheParams);
		
		commonCode(cacheParams);

		log.info("*************************************************");
		log.info("************* User Cache Init End ***************");
		log.info("*************************************************");
	}

	public void loadCache(CacheParams cacheParams) {
		CacheName cacheName = cacheParams.getCacheName();
		log.info(" *************** loadCache cacheName = {}", cacheName.name());
		
		if(cacheName == CacheName.LICENSE) license(cacheParams);
		else if(cacheName == CacheName.POLICY) policy(cacheParams);
		else if(cacheName == CacheName.MENU) menu(cacheParams);
		else if(cacheName == CacheName.COMMON_CODE) commonCode(cacheParams);
		else if(cacheName == CacheName.PROJECT) project(cacheParams);
		else if(cacheName == CacheName.DATA_INFO) data(cacheParams);
	}
	
	private void license(CacheParams cacheParams) {
		//CacheType cacheType = cacheParams.getCacheType();
	}

	private void policy(CacheParams cacheParams) {
		Policy policy = policyService.getPolicy();
		CacheManager.setPolicy(policy);
	}

	private void menu(CacheParams cacheParams) {
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
	}
	
	/**
	 * @param cacheType
	 */
	private void project(CacheParams cacheParams) {
		List<Project> projectList = projectService.getListProject(new Project());
		Map<Long, Project> projectMap = new HashMap<>();
		for(Project project : projectList) {
			projectMap.put(project.getProject_id(), project);
		}
		
		CacheManager.setProjectList(projectList);
		CacheManager.setProjectMap(projectMap);
	}
	
	/**
	 * @param cacheType
	 */
	private void data(CacheParams cacheParams) {
		Long projectId = cacheParams.getProject_id();
		
		Map<Long, List<DataInfo>> projectDataMap = null;
		Map<Long, String> projectDataJsonMap = null;
		if(projectId == null) {
			// 최초 로딩시
			projectDataMap = new HashMap<>();
			projectDataJsonMap = new HashMap<>();
			
			List<Project> projectList = projectService.getListProject(new Project());
			for(Project project : projectList) {
				DataInfo dataInfo = new DataInfo();
				dataInfo.setProject_id(project.getProject_id());
				List<DataInfo> dataInfoList = dataService.getListDataByProjectId(dataInfo);
				
				projectDataMap.put(project.getProject_id(), dataInfoList);
				projectDataJsonMap.put(project.getProject_id(), getProjectDataJson(project, dataInfoList));
			}
		} else {
			// 관리자 페이지에서 data 정보가 갱신되었을때
			Project project = projectService.getProject(projectId);
			DataInfo dataInfo = new DataInfo();
			dataInfo.setProject_id(projectId);
			List<DataInfo> dataInfoList = dataService.getListDataByProjectId(dataInfo);
			
			projectDataMap = CacheManager.getProjectDataMap();
			projectDataJsonMap = CacheManager.getProjectDataJsonMap();
			
			projectDataMap.put(projectId, dataInfoList);
			projectDataJsonMap.put(projectId, getProjectDataJson(project, dataInfoList));
		}
		
		CacheManager.setProjectDataMap(projectDataMap);
		CacheManager.setProjectDataJsonMap(projectDataJsonMap);
	}

	private void commonCode(CacheParams cacheParams) {
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
