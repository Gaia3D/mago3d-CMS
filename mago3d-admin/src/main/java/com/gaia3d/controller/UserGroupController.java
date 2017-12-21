package com.gaia3d.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserGroup;
import com.gaia3d.domain.UserGroupMenu;
import com.gaia3d.service.UserGroupService;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 사용자 그룹
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/user/")
public class UserGroupController {
	
	@Autowired
	private UserGroupService userGroupService;
	
	/**
	 * 사용자 그룹 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-user-group.do")
	public String userGroupList(Model model) {
		return "/user/list-user-group";
	}
	
	/**
	 * 사용자 그룹 메뉴 권한 목록
	 * @param model
	 * @return
	 */
	@GetMapping(value = "list-user-group-menu.do")
	public String listUserGroupMenu(@RequestParam("user_group_id") Long user_group_id, Model model) {
		UserGroup userGroup = userGroupService.getUserGroup(user_group_id);
		
		List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroup);
		
		model.addAttribute(userGroup);
		model.addAttribute(userGroupMenuList);
		return "/user/list-user-group-menu";
	}
	
	/**
	 * 사용자 그룹 메뉴 권한 수정 화면
	 * @param model
	 * @return
	 */
	@GetMapping(value = "modify-user-group-menu.do")
	public String userGroupMenuModify(@RequestParam("user_group_id") Long user_group_id, Model model) {
		UserGroup userGroup = userGroupService.getUserGroup(user_group_id);
		List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroup);
		
		model.addAttribute(userGroup);
		model.addAttribute(userGroupMenuList);
		return "/user/modify-user-group-menu";
	}
	
	/**
	 * 사용자 그룹 메뉴 권한 수정
	 * @param request
	 * @param user_group_id
	 * @param all_yn
	 * @param read_yn
	 * @param write_yn
	 * @param update_yn
	 * @param delete_yn
	 * @param model
	 * @return
	 */
	@PostMapping(value = "update-user-group-menu.do")
	public String updateUserGroupMenu( 	HttpServletRequest request,
										@RequestParam("user_group_id") Long user_group_id,
										@RequestParam("all_yn") String all_yn,
										@RequestParam("read_yn") String read_yn,
										@RequestParam("write_yn") String write_yn,
										@RequestParam("update_yn") String update_yn,
										@RequestParam("delete_yn") String delete_yn,
										Model model) {

		log.info("@@ all_yn = {}", all_yn);
		log.info("@@ read_yn = {}", read_yn);
		log.info("@@ write_yn = {}", write_yn);
		log.info("@@ update_yn = {}", update_yn);
		log.info("@@ delete_yn = {}", delete_yn);
		
		if(all_yn == null || "".equals(all_yn)) {
			return "redirect:/user/list-user-group-menu.do?user_group_id=" + user_group_id;
		}
		
		userGroupService.updateUserGroupMenu(user_group_id, all_yn, read_yn, write_yn, update_yn, delete_yn);
		
		return "redirect:/user/result-user-group-menu.do?method_mode=update&user_group_id=" + user_group_id;
	}
	
	/**
	 * 사용자 그룹 권한 메뉴 등록, 수정, 삭제 처리 결과 페이지
	 * @param user_group_id
	 * @param method_mode insert 는 등록, update 수정, delete 는 삭제
	 * @param model
	 * @return
	 */
	@GetMapping(value = "result-user-group-menu.do")
	public String resultUserGroupMenu(@RequestParam("user_group_id") Long user_group_id, @RequestParam("method_mode") String method_mode, Model model) {
		
		UserGroup userGroup = userGroupService.getUserGroup(user_group_id);
		List<UserGroupMenu> userGroupMenuList = userGroupService.getListUserGroupMenu(userGroup);
		
		model.addAttribute(userGroup);
		model.addAttribute(userGroupMenuList);
		model.addAttribute("method_mode", method_mode);
		
		return "/user/result-user-group-menu";
	}
	
	/**
	 * 사용자 그룹 트리(데이터)
	 * @param request
	 * @return
	 */
	@PostMapping(value = "ajax-list-user-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxListUserGroup(HttpServletRequest request) {
		String result = "success";
		String userGroupTree = null;
		List<UserGroup> userGroupList = new ArrayList<UserGroup>();
		userGroupList.add(getRootUserGroup());
		try {
			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
			userGroupTree = getUserGroupTree(userGroupList);
			log.info("@@ userGroupTree = {} ", userGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.execption";
		}
		
		return "{\"result\": \"" + result + "\",\"userGroupTree\":" + userGroupTree + "}";
	}
	
	/**
	 * 사용자 그룹 추가
	 * @param request
	 * @param userGroup
	 * @return
	 */
	@PostMapping(value = "ajax-insert-user-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxInsertUserGroup(HttpServletRequest request, UserGroup userGroup) {
		String result = "success";
		String userGroupTree = null;
		List<UserGroup> userGroupList = new ArrayList<UserGroup>();
		userGroupList.add(getRootUserGroup());
		try {
			log.info("@@ userGroup = {} ", userGroup);
			
			String parent = request.getParameter("parent");
			String depth = request.getParameter("depth");
			if(userGroup.getGroup_name() == null || "".equals(userGroup.getGroup_name())
					|| parent == null || "".equals(parent)
					|| userGroup.getUse_yn() == null || "".equals(userGroup.getUse_yn())) {
				
				userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
				userGroupTree = getUserGroupTree(userGroupList);
				
				result = "input.invalid";
				return "{\"result\": \"" + result + "\",\"userGroupTree\":" + userGroupTree + "}";
			}
			
			// TODO group_key 중복 체크 해야 함
			userGroup.setParent(Long.parseLong(parent));
			userGroup.setDepth(Integer.parseInt(depth));
			
			UserGroup childGroup = userGroupService.getMaxViewOrderChildUserGroup(userGroup.getParent());
			if(childGroup == null) {
				userGroup.setView_order(1);
			} else {
				userGroup.setView_order(childGroup.getView_order() + 1);
			}
			
			userGroupService.insertUserGroup(userGroup);
			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
			userGroupTree = getUserGroupTree(userGroupList);
			log.info("@@ userGroupTree = {} ", userGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		return "{\"result\": \"" + result + "\",\"userGroupTree\":" + userGroupTree + "}";
	}
	
	/**
	 * 사용자 그룹 수정
	 * @param request
	 * @param userGroup
	 * @return
	 */
	@PostMapping(value = "ajax-update-user-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxUpdateUserGroup(HttpServletRequest request, UserGroup userGroup) {
		String result = "success";
		String userGroupTree = null;
		List<UserGroup> userGroupList = new ArrayList<UserGroup>();
		userGroupList.add(getRootUserGroup());
		try {
						
			log.info("@@ userGroup = {} ", userGroup);
			if(userGroup.getUser_group_id() == null || userGroup.getUser_group_id().intValue() == 0l
					|| userGroup.getGroup_name() == null || "".equals(userGroup.getGroup_name())
					|| userGroup.getUse_yn() == null || "".equals(userGroup.getUse_yn())) {
				
				userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
				userGroupTree = getUserGroupTree(userGroupList);
				
				result = "input.invalid";
				return "{\"result\": \"" + result + "\",\"userGroupTree\":" + userGroupTree + "}";
			}
			
			userGroupService.updateUserGroup(userGroup);
			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
			
			userGroupTree = getUserGroupTree(userGroupList);
			log.info("@@ userGroupTree = {} ", userGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		return "{\"result\": \"" + result + "\",\"userGroupTree\":" + userGroupTree + "}";
	}
	
	/**
	 * 사용자 그룹 순서 수정 - up, down 형태
	 * @param request
	 * @param userGroup
	 * @return
	 */
	@PostMapping(value = "ajax-update-move-user-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxUpdateMoveUserGroup(HttpServletRequest request, UserGroup userGroup) {
		String result = "success";
		String userGroupTree = null;		
		List<UserGroup> userGroupList = new ArrayList<UserGroup>();
		userGroupList.add(getRootUserGroup());
		try {
			log.info("@@ userGroup = {} ", userGroup);
			if(userGroup.getUser_group_id() == null || userGroup.getUser_group_id().longValue() == 0l
					|| userGroup.getView_order() == null || userGroup.getView_order().intValue() == 0
					|| userGroup.getUpdate_type() == null || "".equals(userGroup.getUpdate_type())) {
				
				userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
				
				result = "input.invalid";
				return "{\"result\": \"" + result + "\",\"userGroupTree\":" + userGroupTree + "}";
			}
			
			userGroupService.updateMoveUserGroup(userGroup);
			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
			
			userGroupTree = getUserGroupTree(userGroupList);
			log.info("@@ userGroupTree = {}", userGroupTree);			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		return "{\"result\": \"" + result + "\",\"userGroupTree\":" + userGroupTree + "}";
	}
	
	/**
	 * 사용자 그룹 삭제
	 * @param request
	 * @param userGroup
	 * @return
	 */
	@PostMapping(value = "ajax-delete-user-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxDeleteUserGroup(HttpServletRequest request, UserGroup userGroup) {
		String result = "success";
		String userGroupTree = null;
		List<UserGroup> userGroupList = new ArrayList<UserGroup>();
		userGroupList.add(getRootUserGroup());
		try {
			log.info("@@ userGroup = {} ", userGroup);
			if(userGroup.getUser_group_id() == null || userGroup.getUser_group_id().longValue() == 0l) {				
				userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
				
				result = "input.invalid";
				return "{\"result\": \"" + result + "\",\"userGroupTree\":" + userGroupTree + "}";
			}
			
			userGroupService.deleteUserGroup(userGroup.getUser_group_id());
			userGroupList.addAll(userGroupService.getListUserGroup(new UserGroup()));
			
			userGroupTree = getUserGroupTree(userGroupList);
			log.info("@@ userGroupTree = {} ", userGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		return "{\"result\": \"" + result + "\",\"userGroupTree\":" + userGroupTree + "}";
	}
	
	/**
	 * 최상위 그룹 생성
	 * @return
	 */
	private UserGroup getRootUserGroup() {
		UserGroup userGroup = new UserGroup();
		userGroup.setUser_group_id(0l);
		Policy policy = CacheManager.getPolicy();
		if(policy.getContent_user_group_root() != null && !"".equals(policy.getContent_user_group_root())) {
			userGroup.setGroup_name(policy.getContent_user_group_root());
		} else {
			userGroup.setGroup_name("Gaia3D");
		}
		userGroup.setGroup_key("Gaia3D");
		userGroup.setOpen("true");
		userGroup.setNode_type("company");
		userGroup.setAncestor(-1l);
		userGroup.setParent(-1l);
		userGroup.setParent_name("");
		userGroup.setView_order(0);
		userGroup.setDepth(0);
		userGroup.setDefault_yn("Y");
		userGroup.setUse_yn("Y");		
		userGroup.setDescription("");
		
		return userGroup;
	}
	
	/**
	 * 사용자 그룹 트리 JSON 생성
	 * @param userGroupList
	 * @return
	 */
	private String getUserGroupTree(List<UserGroup> userGroupList) {
		
		StringBuilder builder = new StringBuilder(256);
		
		int userGroupCount = userGroupList.size();
		UserGroup userGroup = userGroupList.get(0);
		
		builder.append("[");
		builder.append("{");
		
		builder.append("\"user_group_id\"").append(":").append("\"" + userGroup.getUser_group_id() + "\"").append(",");
		builder.append("\"group_key\"").append(":").append("\"" + userGroup.getGroup_key() + "\"").append(",");
		builder.append("\"group_name\"").append(":").append("\"" + userGroup.getGroup_name() + "\"").append(",");
		builder.append("\"open\"").append(":").append("\"" + userGroup.getOpen() + "\"").append(",");
		builder.append("\"node_type\"").append(":").append("\"" + userGroup.getNode_type() + "\"").append(",");
		builder.append("\"ancestor\"").append(":").append("\"" + userGroup.getAncestor() + "\"").append(",");
		builder.append("\"parent\"").append(":").append("\"" + userGroup.getParent() + "\"").append(",");
		builder.append("\"parent_name\"").append(":").append("\"" + userGroup.getParent_name() + "\"").append(",");
		builder.append("\"view_order\"").append(":").append("\"" + userGroup.getView_order() + "\"").append(",");
		builder.append("\"depth\"").append(":").append("\"" + userGroup.getDepth() + "\"").append(",");
		builder.append("\"default_yn\"").append(":").append("\"" + userGroup.getDefault_yn() + "\"").append(",");
		builder.append("\"use_yn\"").append(":").append("\"" + userGroup.getUse_yn() + "\"").append(",");
		builder.append("\"child_yn\"").append(":").append("\"" + userGroup.getUse_yn() + "\"").append(",");
		builder.append("\"description\"").append(":").append("\"" + userGroup.getDescription() + "\"");
		
		if(userGroupCount > 1) {
			long preParent = userGroup.getParent();
			int preDepth = userGroup.getDepth();
			int bigParentheses = 0;
			for(int i = 1; i < userGroupCount; i++) {
				userGroup = userGroupList.get(i);
				
				if(preParent == userGroup.getParent()) {
					// 부모가 같은 경우
					builder.append("}");
					builder.append(",");
				} else {
					if(preDepth > userGroup.getDepth()) {
						// 닫힐때
						int closeCount = preDepth - userGroup.getDepth();
						for(int j=0; j<closeCount; j++) {
							builder.append("}");
							builder.append("]");
							bigParentheses--;
						}
						builder.append("}");
						builder.append(",");
					} else {
						// 열릴때
						builder.append(",");
						builder.append("\"subTree\"").append(":").append("[");
						bigParentheses++;
					}
				} 
				
				builder.append("{");
				builder.append("\"user_group_id\"").append(":").append("\"" + userGroup.getUser_group_id() + "\"").append(",");
				builder.append("\"group_key\"").append(":").append("\"" + userGroup.getGroup_key() + "\"").append(",");
				builder.append("\"group_name\"").append(":").append("\"" + userGroup.getGroup_name() + "\"").append(",");
				builder.append("\"open\"").append(":").append("\"" + userGroup.getOpen() + "\"").append(",");
				builder.append("\"node_type\"").append(":").append("\"" + userGroup.getNode_type() + "\"").append(",");
				builder.append("\"ancestor\"").append(":").append("\"" + userGroup.getAncestor() + "\"").append(",");
				builder.append("\"parent\"").append(":").append("\"" + userGroup.getParent() + "\"").append(",");
				builder.append("\"parent_name\"").append(":").append("\"" + StringUtil.getDefaultValue(userGroup.getParent_name()) + "\"").append(",");
				builder.append("\"view_order\"").append(":").append("\"" + userGroup.getView_order() + "\"").append(",");
				builder.append("\"depth\"").append(":").append("\"" + userGroup.getDepth() + "\"").append(",");
				builder.append("\"default_yn\"").append(":").append("\"" + userGroup.getDefault_yn() + "\"").append(",");
				builder.append("\"use_yn\"").append(":").append("\"" + userGroup.getUse_yn() + "\"").append(",");			
				builder.append("\"child_yn\"").append(":").append("\"" + userGroup.getUse_yn() + "\"").append(",");			
				builder.append("\"description\"").append(":").append("\"" + userGroup.getDescription() + "\"");
				
				if(i == (userGroupCount-1)) {
					// 맨 마지막의 경우 괄호를 닫음
					if(bigParentheses == 0) {
						builder.append("}");
					} else {
						for(int k=0; k<bigParentheses; k++) {
							builder.append("}");
							builder.append("]");
						}
					}
				}
				
				preParent = userGroup.getParent();
				preDepth = userGroup.getDepth();
			}
		}
		
		builder.append("}");
		builder.append("]");
		
		return builder.toString();
	}
}
