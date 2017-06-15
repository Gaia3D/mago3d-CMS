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
import com.gaia3d.domain.DataGroup;
import com.gaia3d.domain.Policy;
import com.gaia3d.service.DataGroupService;
import com.gaia3d.util.JSONUtil;
import com.google.gson.Gson;

import lombok.extern.slf4j.Slf4j;

/**
 * Data 그룹
 * @author jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/data/")
public class DataGroupController {
	
	@Autowired
	private DataGroupService dataGroupService;
	
	/**
	 * Data 그룹 목록
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "list-data-group.do", method = RequestMethod.GET)
	public String dataGroupList(Model model) {
		return "/data/list-data-group";
	}
	
	/**
	 * Data 그룹 트리(데이터)
	 * @param request
	 * @return
	 */
	@PostMapping(value = "ajax-list-data-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxListDataGroup(HttpServletRequest request) {
//		Gson gson = new Gson();
//		Map<String, Data> jSONData = new HashMap<String, Data>();
		String result = "success";
		String dataGroupTree = null;
		List<DataGroup> dataGroupList = new ArrayList<DataGroup>();
		dataGroupList.add(getRootDataGroup());
		try {
			dataGroupList.addAll(dataGroupService.getListDataGroup(new DataGroup()));
			dataGroupTree = getDataGroupTree(dataGroupList);
			log.info("@@ dataGroupTree = {} ", dataGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.execption";
		}
		
//		jSONData.put("result", result);
//		jSONData.put("dataGroupTree", dataGroupTree);
//		return gson.toJson(jSONData);
		
		return JSONUtil.getResultTreeString(result, dataGroupTree);
	}
	
	/**
	 * Data 그룹 추가
	 * @param request
	 * @param dataGroup
	 * @return
	 */
	@PostMapping(value = "ajax-insert-data-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxInsertDataGroup(HttpServletRequest request, DataGroup dataGroup) {
//		Gson gson = new Gson();
//		Map<String, Data> jSONData = new HashMap<String, Data>();
		String result = "success";
		String dataGroupTree = null;
		List<DataGroup> dataGroupList = new ArrayList<DataGroup>();
		dataGroupList.add(getRootDataGroup());
		try {
			log.info("@@ dataGroup = {} ", dataGroup);
			
			String parent = request.getParameter("parent");
			String depth = request.getParameter("depth");
			if(dataGroup.getData_group_name() == null || "".equals(dataGroup.getData_group_name())
					|| parent == null || "".equals(parent)
					|| dataGroup.getUse_yn() == null || "".equals(dataGroup.getUse_yn())) {
				
				dataGroupList.addAll(dataGroupService.getListDataGroup(new DataGroup()));
				
				result = "input.invalid";
//				jSONData.put("result", result);
//				jSONData.put("dataGroupTree", getDataGroupTree(dataGroupList));
//				return jSONData.toString();
				
				return JSONUtil.getResultTreeString(result, dataGroupTree);
			}
			
			// TODO group_key 중복 체크 해야 함
			dataGroup.setParent(Long.parseLong(parent));
			dataGroup.setDepth(Integer.parseInt(depth));
			
			DataGroup childGroup = dataGroupService.getMaxViewOrderChildDataGroup(dataGroup.getParent());
			if(childGroup == null) {
				dataGroup.setView_order(1);
			} else {
				dataGroup.setView_order(childGroup.getView_order() + 1);
			}
			
			dataGroupService.insertDataGroup(dataGroup);
			dataGroupList.addAll(dataGroupService.getListDataGroup(new DataGroup()));
			dataGroupTree = getDataGroupTree(dataGroupList);
			log.info("@@ dataGroupTree = {} ", dataGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
//		jSONData.put("result", result);
//		jSONData.put("dataGroupTree", dataGroupTree);
//		return gson.toJson(jSONData);
		
		return JSONUtil.getResultTreeString(result, dataGroupTree);
	}
	
	/**
	 * Data 그룹 수정
	 * @param request
	 * @param dataGroup
	 * @return
	 */
	@PostMapping(value = "ajax-update-data-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxUpdateDataGroup(HttpServletRequest request, DataGroup dataGroup) {
//		Gson gson = new Gson();
//		Map<String, Data> jSONData = new HashMap<String, Data>();
		String result = "success";
		String dataGroupTree = null;
		List<DataGroup> dataGroupList = new ArrayList<DataGroup>();
		dataGroupList.add(getRootDataGroup());
		try {
						
			log.info("@@ dataGroup = {} ", dataGroup);
			if(dataGroup.getData_group_id() == null || dataGroup.getData_group_id().intValue() == 0l
					|| dataGroup.getData_group_name() == null || "".equals(dataGroup.getData_group_name())
					|| dataGroup.getUse_yn() == null || "".equals(dataGroup.getUse_yn())) {
				
				dataGroupList.addAll(dataGroupService.getListDataGroup(new DataGroup()));
				
				result = "input.invalid";
//				jSONData.put("result", result);
//				jSONData.put("dataGroupTree", getDataGroupTree(dataGroupList));
//				return jSONData.toString();
				
				return JSONUtil.getResultTreeString(result, dataGroupTree);
			}
			
			dataGroupService.updateDataGroup(dataGroup);
			dataGroupList.addAll(dataGroupService.getListDataGroup(new DataGroup()));
			
			dataGroupTree = getDataGroupTree(dataGroupList);
			log.info("@@ dataGroupTree = {} ", dataGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
		
//		jSONData.put("result", result);
//		jSONData.put("dataGroupTree", dataGroupTree);
//		return gson.toJson(jSONData);
		
		return JSONUtil.getResultTreeString(result, dataGroupTree);
	}
	
	/**
	 * Data 그룹 순서 수정 - up, down 형태
	 * @param request
	 * @param dataGroup
	 * @return
	 */
	@PostMapping(value = "ajax-update-move-data-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxUpdateMoveDataGroup(HttpServletRequest request, DataGroup dataGroup) {
//		Gson gson = new Gson();
//		Map<String, Data> jSONData = new HashMap<String, Data>();
		String result = "success";
		String dataGroupTree = null;		
		List<DataGroup> dataGroupList = new ArrayList<DataGroup>();
		dataGroupList.add(getRootDataGroup());
		try {
			
			log.info("@@ dataGroup = {} ", dataGroup);
			if(dataGroup.getData_group_id() == null || dataGroup.getData_group_id().longValue() == 0l
					|| dataGroup.getView_order() == null || dataGroup.getView_order().intValue() == 0
					|| dataGroup.getUpdate_type() == null || "".equals(dataGroup.getUpdate_type())) {
				
				dataGroupList.addAll(dataGroupService.getListDataGroup(new DataGroup()));
				
				result = "input.invalid";
//				jSONData.put("result", result);
//				jSONData.put("dataGroupTree", getDataGroupTree(dataGroupList));
//				
//				return jSONData.toString();
				return JSONUtil.getResultTreeString(result, dataGroupTree);
			}
			
			dataGroupService.updateMoveDataGroup(dataGroup);
			dataGroupList.addAll(dataGroupService.getListDataGroup(new DataGroup()));
			
			dataGroupTree = getDataGroupTree(dataGroupList);
			log.info("@@ dataGroupTree = {}", dataGroupTree);			
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
//		jSONData.put("result", result);
//		jSONData.put("dataGroupTree", dataGroupTree);
//		
//		return gson.toJson(jSONData);
		return JSONUtil.getResultTreeString(result, dataGroupTree);
	}
	
	/**
	 * Data 그룹 삭제
	 * @param request
	 * @param dataGroup
	 * @return
	 */
	@PostMapping(value = "ajax-delete-data-group.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public String ajaxDeleteDataGroup(HttpServletRequest request, DataGroup dataGroup) {
//		Gson gson = new Gson();
//		Map<String, Data> jSONData = new HashMap<String, Data>();
		String result = "success";
		String dataGroupTree = null;
		List<DataGroup> dataGroupList = new ArrayList<DataGroup>();
		dataGroupList.add(getRootDataGroup());
		try {
			log.info("@@ dataGroup = {} ", dataGroup);
			if(dataGroup.getData_group_id() == null || dataGroup.getData_group_id().longValue() == 0l) {				
				dataGroupList.addAll(dataGroupService.getListDataGroup(new DataGroup()));
				
				result = "input.invalid";
//				jSONData.put("result", result);
//				jSONData.put("dataGroupTree", getDataGroupTree(dataGroupList));
//				
//				return jSONData.toString();
				return JSONUtil.getResultTreeString(result, dataGroupTree);
			}
			
			dataGroupService.deleteDataGroup(dataGroup.getData_group_id());
			dataGroupList.addAll(dataGroupService.getListDataGroup(new DataGroup()));
			
			dataGroupTree = getDataGroupTree(dataGroupList);
			log.info("@@ dataGroupTree = {} ", dataGroupTree);
		} catch(Exception e) {
			e.printStackTrace();
			result = "db.exception";
		}
//		jSONData.put("result", result);
//		jSONData.put("dataGroupTree", dataGroupTree);
//		
//		return gson.toJson(jSONData);
		return JSONUtil.getResultTreeString(result, dataGroupTree);
	}
	
	/**
	 * 최상위 그룹 생성
	 * @return
	 */
	private DataGroup getRootDataGroup() {
		DataGroup dataGroup = new DataGroup();
		dataGroup.setData_group_id(0l);
		Policy policy = CacheManager.getPolicy();
		if(policy.getContent_data_group_root() != null && !"".equals(policy.getContent_data_group_root())) {
			dataGroup.setData_group_name(policy.getContent_data_group_root());
		} else {
			dataGroup.setData_group_name("Mago3D");
		}
		dataGroup.setData_group_key("Mago3D");
		dataGroup.setOpen("true");
		dataGroup.setNode_type("company");
		dataGroup.setAncestor(-1l);
		dataGroup.setParent(-1l);
		dataGroup.setParent_name("");
		dataGroup.setView_order(0);
		dataGroup.setDepth(0);
		dataGroup.setDefault_yn("Y");
		dataGroup.setUse_yn("Y");		
		dataGroup.setDescription("");
		
		return dataGroup;
	}
	
	/**
	 * Data 그룹 트리 JSON 생성
	 * @param dataGroupList
	 * @return
	 */
	private String getDataGroupTree(List<DataGroup> dataGroupList) {
		
		StringBuilder builder = new StringBuilder(256);
		
		int dataGroupCount = dataGroupList.size();
		DataGroup dataGroup = dataGroupList.get(0);
		
		builder.append("[");
		builder.append("{");
		
		builder.append("\"data_group_id\"").append(":").append("\"" + dataGroup.getData_group_id() + "\"").append(",");
		builder.append("\"data_group_key\"").append(":").append("\"" + dataGroup.getData_group_key() + "\"").append(",");
		builder.append("\"data_group_name\"").append(":").append("\"" + dataGroup.getData_group_name() + "\"").append(",");
		builder.append("\"open\"").append(":").append("\"" + dataGroup.getOpen() + "\"").append(",");
		builder.append("\"node_type\"").append(":").append("\"" + dataGroup.getNode_type() + "\"").append(",");
		builder.append("\"ancestor\"").append(":").append("\"" + dataGroup.getAncestor() + "\"").append(",");
		builder.append("\"parent\"").append(":").append("\"" + dataGroup.getParent() + "\"").append(",");
		builder.append("\"parent_name\"").append(":").append("\"" + dataGroup.getParent_name() + "\"").append(",");
		builder.append("\"view_order\"").append(":").append("\"" + dataGroup.getView_order() + "\"").append(",");
		builder.append("\"depth\"").append(":").append("\"" + dataGroup.getDepth() + "\"").append(",");
		builder.append("\"default_yn\"").append(":").append("\"" + dataGroup.getDefault_yn() + "\"").append(",");
		builder.append("\"use_yn\"").append(":").append("\"" + dataGroup.getUse_yn() + "\"").append(",");
		builder.append("\"child_yn\"").append(":").append("\"" + dataGroup.getUse_yn() + "\"").append(",");
		builder.append("\"description\"").append(":").append("\"" + dataGroup.getDescription() + "\"");
		
		if(dataGroupCount > 1) {
			long preParent = dataGroup.getParent();
			int preDepth = dataGroup.getDepth();
			int bigParentheses = 0;
			for(int i = 1; i < dataGroupCount; i++) {
				dataGroup = dataGroupList.get(i);
				
				if(preParent == dataGroup.getParent()) {
					// 부모가 같은 경우
					builder.append("}");
					builder.append(",");
				} else {
					if(preDepth > dataGroup.getDepth()) {
						// 닫힐때
						int closeCount = preDepth - dataGroup.getDepth();
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
				builder.append("\"data_group_id\"").append(":").append("\"" + dataGroup.getData_group_id() + "\"").append(",");
				builder.append("\"data_group_key\"").append(":").append("\"" + dataGroup.getData_group_key() + "\"").append(",");
				builder.append("\"data_group_name\"").append(":").append("\"" + dataGroup.getData_group_name() + "\"").append(",");
				builder.append("\"open\"").append(":").append("\"" + dataGroup.getOpen() + "\"").append(",");
				builder.append("\"node_type\"").append(":").append("\"" + dataGroup.getNode_type() + "\"").append(",");
				builder.append("\"ancestor\"").append(":").append("\"" + dataGroup.getAncestor() + "\"").append(",");
				builder.append("\"parent\"").append(":").append("\"" + dataGroup.getParent() + "\"").append(",");
				builder.append("\"parent_name\"").append(":").append("\"" + dataGroup.getParent_name() + "\"").append(",");
				builder.append("\"view_order\"").append(":").append("\"" + dataGroup.getView_order() + "\"").append(",");
				builder.append("\"depth\"").append(":").append("\"" + dataGroup.getDepth() + "\"").append(",");
				builder.append("\"default_yn\"").append(":").append("\"" + dataGroup.getDefault_yn() + "\"").append(",");
				builder.append("\"use_yn\"").append(":").append("\"" + dataGroup.getUse_yn() + "\"").append(",");			
				builder.append("\"child_yn\"").append(":").append("\"" + dataGroup.getUse_yn() + "\"").append(",");			
				builder.append("\"description\"").append(":").append("\"" + dataGroup.getDescription() + "\"");
				
				if(i == (dataGroupCount-1)) {
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
				
				preParent = dataGroup.getParent();
				preDepth = dataGroup.getDepth();
			}
		}
		
		builder.append("}");
		builder.append("]");
		
		return builder.toString();
	}
}
