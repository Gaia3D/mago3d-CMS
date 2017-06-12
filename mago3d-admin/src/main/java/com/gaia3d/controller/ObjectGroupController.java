package com.gaia3d.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.ObjectGroup;
import com.gaia3d.domain.Policy;
import com.gaia3d.service.ObjectGroupService;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

/**
 * Object 그룹
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/object/")
public class ObjectGroupController {
	
	@Autowired
	private ObjectGroupService objectGroupService;
	
	/**
	 * Object 그룹 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-object-group.do", method = RequestMethod.GET)
	public String objectGroupList(Model model) {
		return "/object/list-object-group";
	}
	
	/**
	 * Object 그룹 트리(데이터)
	 * @param request
	 * @return
	 */
	@PostMapping(value = "ajax-list-object-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxListObjectGroup(HttpServletRequest request) {
//		Gson gson = new Gson();
//		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String objectGroupTree = null;
		List<ObjectGroup> objectGroupList = new ArrayList<ObjectGroup>();
		objectGroupList.add(getRootObjectGroup());
		try {
			objectGroupList.addAll(objectGroupService.getListObjectGroup(new ObjectGroup()));
			objectGroupTree = getObjectGroupTree(objectGroupList);
			log.info("@@ objectGroupTree = {} ", objectGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.execption";
		}
		
//		jSONObject.put("result", result);
//		jSONObject.put("objectGroupTree", objectGroupTree);
		
		String jsonResult = "{\"result\": \"" + result + "\",\"objectGroupTree\":" + objectGroupTree + "}";
		return jsonResult;
		
//		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 그룹 추가
	 * @param request
	 * @param objectGroup
	 * @return
	 */
	@RequestMapping(value = "ajax-insert-object-group.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxInsertObjectGroup(HttpServletRequest request, ObjectGroup objectGroup) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String objectGroupTree = null;
		List<ObjectGroup> objectGroupList = new ArrayList<ObjectGroup>();
		objectGroupList.add(getRootObjectGroup());
		try {
			log.info("@@ objectGroup = {} ", objectGroup);
			
			String parent = request.getParameter("parent");
			String depth = request.getParameter("depth");
			if(objectGroup.getObject_group_name() == null || "".equals(objectGroup.getObject_group_name())
					|| parent == null || "".equals(parent)
					|| objectGroup.getUse_yn() == null || "".equals(objectGroup.getUse_yn())) {
				
				objectGroupList.addAll(objectGroupService.getListObjectGroup(new ObjectGroup()));
				
				result = "input.invalid";
				jSONObject.put("result", result);
				jSONObject.put("objectGroupTree", getObjectGroupTree(objectGroupList));
				
				return jSONObject.toString();
			}
			
			// TODO group_key 중복 체크 해야 함
			objectGroup.setParent(Long.parseLong(parent));
			objectGroup.setDepth(Integer.parseInt(depth));
			
			ObjectGroup childGroup = objectGroupService.getMaxViewOrderChildObjectGroup(objectGroup.getParent());
			if(childGroup == null) {
				objectGroup.setView_order(1);
			} else {
				objectGroup.setView_order(childGroup.getView_order() + 1);
			}
			
			objectGroupService.insertObjectGroup(objectGroup);
			objectGroupList.addAll(objectGroupService.getListObjectGroup(new ObjectGroup()));
			objectGroupTree = getObjectGroupTree(objectGroupList);
			log.info("@@ objectGroupTree = {} ", objectGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		jSONObject.put("objectGroupTree", objectGroupTree);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 그룹 수정
	 * @param request
	 * @param objectGroup
	 * @return
	 */
	@RequestMapping(value = "ajax-update-object-group.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxUpdateObjectGroup(HttpServletRequest request, ObjectGroup objectGroup) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String objectGroupTree = null;
		List<ObjectGroup> objectGroupList = new ArrayList<ObjectGroup>();
		objectGroupList.add(getRootObjectGroup());
		try {
						
			log.info("@@ objectGroup = {} ", objectGroup);
			if(objectGroup.getObject_group_id() == null || objectGroup.getObject_group_id().intValue() == 0l
					|| objectGroup.getObject_group_name() == null || "".equals(objectGroup.getObject_group_name())
					|| objectGroup.getUse_yn() == null || "".equals(objectGroup.getUse_yn())) {
				
				objectGroupList.addAll(objectGroupService.getListObjectGroup(new ObjectGroup()));
				
				result = "input.invalid";
				jSONObject.put("result", result);
				jSONObject.put("objectGroupTree", getObjectGroupTree(objectGroupList));
				
				return jSONObject.toString();
			}
			
			objectGroupService.updateObjectGroup(objectGroup);
			objectGroupList.addAll(objectGroupService.getListObjectGroup(new ObjectGroup()));
			
			objectGroupTree = getObjectGroupTree(objectGroupList);
			log.info("@@ objectGroupTree = {} ", objectGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
		jSONObject.put("result", result);
		jSONObject.put("objectGroupTree", objectGroupTree);
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 그룹 순서 수정 - up, down 형태
	 * @param request
	 * @param objectGroup
	 * @return
	 */
	@RequestMapping(value = "ajax-update-move-object-group.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxUpdateMoveObjectGroup(HttpServletRequest request, ObjectGroup objectGroup) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String objectGroupTree = null;		
		List<ObjectGroup> objectGroupList = new ArrayList<ObjectGroup>();
		objectGroupList.add(getRootObjectGroup());
		try {
			
			log.info("@@ objectGroup = {} ", objectGroup);
			if(objectGroup.getObject_group_id() == null || objectGroup.getObject_group_id().longValue() == 0l
					|| objectGroup.getView_order() == null || objectGroup.getView_order().intValue() == 0
					|| objectGroup.getUpdate_type() == null || "".equals(objectGroup.getUpdate_type())) {
				
				objectGroupList.addAll(objectGroupService.getListObjectGroup(new ObjectGroup()));
				
				result = "input.invalid";
				jSONObject.put("result", result);
				jSONObject.put("objectGroupTree", getObjectGroupTree(objectGroupList));
				
				return jSONObject.toString();
			}
			
			objectGroupService.updateMoveObjectGroup(objectGroup);
			objectGroupList.addAll(objectGroupService.getListObjectGroup(new ObjectGroup()));
			
			objectGroupTree = getObjectGroupTree(objectGroupList);
			log.info("@@ objectGroupTree = {}", objectGroupTree);			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		jSONObject.put("result", result);
		jSONObject.put("objectGroupTree", objectGroupTree);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * Object 그룹 삭제
	 * @param request
	 * @param objectGroup
	 * @return
	 */
	@RequestMapping(value = "ajax-delete-object-group.do", method = RequestMethod.POST)
	@ResponseBody
	public String ajaxDeleteObjectGroup(HttpServletRequest request, ObjectGroup objectGroup) {
		Gson gson = new Gson();
		Map<String, Object> jSONObject = new HashMap<String, Object>();
		String result = "success";
		String objectGroupTree = null;
		List<ObjectGroup> objectGroupList = new ArrayList<ObjectGroup>();
		objectGroupList.add(getRootObjectGroup());
		try {
			log.info("@@ objectGroup = {} ", objectGroup);
			if(objectGroup.getObject_group_id() == null || objectGroup.getObject_group_id().longValue() == 0l) {				
				objectGroupList.addAll(objectGroupService.getListObjectGroup(new ObjectGroup()));
				
				result = "input.invalid";
				jSONObject.put("result", result);
				jSONObject.put("objectGroupTree", getObjectGroupTree(objectGroupList));
				
				return jSONObject.toString();
			}
			
			objectGroupService.deleteObjectGroup(objectGroup.getObject_group_id());
			objectGroupList.addAll(objectGroupService.getListObjectGroup(new ObjectGroup()));
			
			objectGroupTree = getObjectGroupTree(objectGroupList);
			log.info("@@ objectGroupTree = {} ", objectGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		jSONObject.put("result", result);
		jSONObject.put("objectGroupTree", objectGroupTree);
		
		return gson.toJson(jSONObject);
	}
	
	/**
	 * 최상위 그룹 생성
	 * @return
	 */
	private ObjectGroup getRootObjectGroup() {
		ObjectGroup objectGroup = new ObjectGroup();
		objectGroup.setObject_group_id(0l);
		Policy policy = CacheManager.getPolicy();
		if(policy.getContent_object_group_root() != null && !"".equals(policy.getContent_object_group_root())) {
			objectGroup.setObject_group_name(policy.getContent_object_group_root());
		} else {
			objectGroup.setObject_group_name("Mago3D");
		}
		objectGroup.setObject_group_key("Mago3D");
		objectGroup.setOpen("true");
		objectGroup.setNode_type("company");
		objectGroup.setAncestor(-1l);
		objectGroup.setParent(-1l);
		objectGroup.setParent_name("");
		objectGroup.setView_order(0);
		objectGroup.setDepth(0);
		objectGroup.setDefault_yn("Y");
		objectGroup.setUse_yn("Y");		
		objectGroup.setDescription("");
		
		return objectGroup;
	}
	
	/**
	 * Object 그룹 트리 JSON 생성
	 * @param objectGroupList
	 * @return
	 */
	private String getObjectGroupTree(List<ObjectGroup> objectGroupList) {
		
		StringBuilder builder = new StringBuilder(256);
		
		int objectGroupCount = objectGroupList.size();
		ObjectGroup objectGroup = objectGroupList.get(0);
		
		builder.append("[");
		builder.append("{");
		
		builder.append("\"object_group_id\"").append(":").append("\"" + objectGroup.getObject_group_id() + "\"").append(",");
		builder.append("\"object_group_key\"").append(":").append("\"" + objectGroup.getObject_group_key() + "\"").append(",");
		builder.append("\"object_group_name\"").append(":").append("\"" + objectGroup.getObject_group_name() + "\"").append(",");
		builder.append("\"open\"").append(":").append("\"" + objectGroup.getOpen() + "\"").append(",");
		builder.append("\"node_type\"").append(":").append("\"" + objectGroup.getNode_type() + "\"").append(",");
		builder.append("\"ancestor\"").append(":").append("\"" + objectGroup.getAncestor() + "\"").append(",");
		builder.append("\"parent\"").append(":").append("\"" + objectGroup.getParent() + "\"").append(",");
		builder.append("\"parent_name\"").append(":").append("\"" + objectGroup.getParent_name() + "\"").append(",");
		builder.append("\"view_order\"").append(":").append("\"" + objectGroup.getView_order() + "\"").append(",");
		builder.append("\"depth\"").append(":").append("\"" + objectGroup.getDepth() + "\"").append(",");
		builder.append("\"default_yn\"").append(":").append("\"" + objectGroup.getDefault_yn() + "\"").append(",");
		builder.append("\"use_yn\"").append(":").append("\"" + objectGroup.getUse_yn() + "\"").append(",");
		builder.append("\"child_yn\"").append(":").append("\"" + objectGroup.getUse_yn() + "\"").append(",");
		builder.append("\"description\"").append(":").append("\"" + objectGroup.getDescription() + "\"");
		
		if(objectGroupCount > 1) {
			long preParent = objectGroup.getParent();
			int preDepth = objectGroup.getDepth();
			int bigParentheses = 0;
			for(int i = 1; i < objectGroupCount; i++) {
				objectGroup = objectGroupList.get(i);
				
				if(preParent == objectGroup.getParent()) {
					// 부모가 같은 경우
					builder.append("}");
					builder.append(",");
				} else {
					if(preDepth > objectGroup.getDepth()) {
						// 닫힐때
						int closeCount = preDepth - objectGroup.getDepth();
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
				builder.append("\"object_group_id\"").append(":").append("\"" + objectGroup.getObject_group_id() + "\"").append(",");
				builder.append("\"object_group_key\"").append(":").append("\"" + objectGroup.getObject_group_key() + "\"").append(",");
				builder.append("\"object_group_name\"").append(":").append("\"" + objectGroup.getObject_group_name() + "\"").append(",");
				builder.append("\"open\"").append(":").append("\"" + objectGroup.getOpen() + "\"").append(",");
				builder.append("\"node_type\"").append(":").append("\"" + objectGroup.getNode_type() + "\"").append(",");
				builder.append("\"ancestor\"").append(":").append("\"" + objectGroup.getAncestor() + "\"").append(",");
				builder.append("\"parent\"").append(":").append("\"" + objectGroup.getParent() + "\"").append(",");
				builder.append("\"parent_name\"").append(":").append("\"" + objectGroup.getParent_name() + "\"").append(",");
				builder.append("\"view_order\"").append(":").append("\"" + objectGroup.getView_order() + "\"").append(",");
				builder.append("\"depth\"").append(":").append("\"" + objectGroup.getDepth() + "\"").append(",");
				builder.append("\"default_yn\"").append(":").append("\"" + objectGroup.getDefault_yn() + "\"").append(",");
				builder.append("\"use_yn\"").append(":").append("\"" + objectGroup.getUse_yn() + "\"").append(",");			
				builder.append("\"child_yn\"").append(":").append("\"" + objectGroup.getUse_yn() + "\"").append(",");			
				builder.append("\"description\"").append(":").append("\"" + objectGroup.getDescription() + "\"");
				
				if(i == (objectGroupCount-1)) {
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
				
				preParent = objectGroup.getParent();
				preDepth = objectGroup.getDepth();
			}
		}
		
		builder.append("}");
		builder.append("]");
		
		return builder.toString();
	}
}
