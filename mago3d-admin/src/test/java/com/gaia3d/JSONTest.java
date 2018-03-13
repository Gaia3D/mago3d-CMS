//package com.gaia3d;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//import org.junit.Test;
//
//import com.fasterxml.jackson.databind.ObjectMapper;
//import com.gaia3d.domain.CacheManager;
//import com.gaia3d.domain.Menu;
//import com.gaia3d.domain.Policy;
//import com.gaia3d.util.StringUtil;
//import com.google.gson.Gson;
//
//public class JSONTest {
//
//	@Test
//	public void test() throws Exception {
//		Gson gson = new Gson();
//		Map<String, String> jSONObject = new HashMap<String, String>();
//		String menuTree = null;
//		List<Menu> menuList = new ArrayList<>();
//		menuList.add(getRootMenu());
//		menuTree = getMenuTree(menuList);
//		jSONObject.put("menuTree", menuTree);
//		
//		System.out.println(gson.toJson(jSONObject));
//		
//		String jsonString = gson.toJson(jSONObject);
//		System.out.println("================ " + jsonString.replace("\\", ""));
//		
////		JSONObject jsObject = new JSONObject();
////		jsObject.put("menuTree", menuTree);
////		
////		System.out.println(jsObject.toString());
//		
//		
//		ObjectMapper objectMapper = new ObjectMapper();
//		//objectMapper.writeValueAsString(menuTree);
//		Map<String, String> map = new HashMap<>();
//		map.put("menuTree", menuTree);
//		
//		System.out.println(objectMapper.writeValueAsString(map));
//	}
//	
//
//	/**
//	 * 기본 메뉴 트리
//	 * @return
//	 */
//	private Menu getRootMenu() {
//		Policy policy = CacheManager.getPolicy();
//		
//		Menu menu = new Menu();
//		menu.setMenu_id(0l);
//		menu.setName("test");
//		menu.setName_en("TOP");
//		menu.setOpen("true");
//		menu.setNode_type("company");
//		menu.setParent(1l);
//		menu.setParent_name("a");
//		menu.setView_order(1);
//		menu.setDepth(1);
//		menu.setDefault_yn("Y");
//		menu.setUse_yn("Y");
//		menu.setUrl("b");
//		menu.setImage("c");
//		menu.setImage_alt("d");
//		menu.setCss_class("e");
//		menu.setDescription("f");
//		
//		return menu;
//	}
//	
//	private String getMenuTree(List<Menu> menuList) {
//		StringBuilder builder = new StringBuilder();
//		
//		int menuCount = menuList.size();
//		Menu menu = menuList.get(0);
//		
//		builder.append("[");
//		builder.append("{");
//		
//		builder.append("menu_id").append(":").append("\"" + menu.getMenu_id() + "\"").append(",");
//		builder.append("name").append(":").append("\"" + menu.getName() + "\"").append(",");
//		builder.append("name_en").append(":").append("\"" + menu.getName_en() + "\"").append(",");
//		builder.append("open").append(":").append("\"" + menu.getOpen() + "\"").append(",");
//		builder.append("node_type").append(":").append("\"" + menu.getNode_type() + "\"").append(",");
//		builder.append("parent").append(":").append("\"" + menu.getParent() + "\"").append(",");
//		builder.append("parent_name").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParent_name()) + "\"").append(",");
//		builder.append("view_order").append(":").append("\"" + menu.getView_order() + "\"").append(",");
//		builder.append("depth").append(":").append("\"" + menu.getDepth() + "\"").append(",");
//		builder.append("default_yn").append(":").append("\"" + menu.getDefault_yn() + "\"").append(",");
//		builder.append("use_yn").append(":").append("\"" + menu.getUse_yn() + "\"").append(",");
//		builder.append("url").append(":").append("\"" + menu.getUrl() + "\"").append(",");
//		builder.append("image").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",");
//		builder.append("image_alt").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage_alt()) + "\"").append(",");
//		builder.append("css_class").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCss_class()) + "\"").append(",");
//		builder.append("description").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
//	
//		if(menuCount > 1) {
//			long preParent = menu.getParent();
//			int preDepth = menu.getDepth();
//			int bigParentheses = 0;
//			for(int i=1; i<menuCount; i++) {
//				menu = menuList.get(i);
//				
//				if(preParent == menu.getParent()) {
//					// 부모가 같은 경우
//					builder.append("}");
//					builder.append(",");
//				} else {
//					if(preDepth > menu.getDepth()) {
//						// 닫힐때
//						int closeCount = preDepth - menu.getDepth();
//						for(int j=0; j<closeCount; j++) {
//							builder.append("}");
//							builder.append("]");
//							bigParentheses--;
//						}
//						builder.append("}");
//						builder.append(",");
//					} else {
//						// 열릴때
//						builder.append(",");
//						builder.append("subTree").append(":").append("[");
//						bigParentheses++;
//					}
//				} 
//				
//				builder.append("{");
//				builder.append("menu_id").append(":").append("\"" + menu.getMenu_id() + "\"").append(",");
//				builder.append("name").append(":").append("\"" + menu.getName() + "\"").append(",");
//				builder.append("name_en").append(":").append("\"" + menu.getName_en() + "\"").append(",");
//				builder.append("open").append(":").append("\"" + menu.getOpen() + "\"").append(",");
//				builder.append("node_type").append(":").append("\"" + menu.getNode_type() + "\"").append(",");
//				builder.append("parent").append(":").append("\"" + menu.getParent() + "\"").append(",");
//				builder.append("parent_name").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParent_name()) + "\"").append(",");
//				builder.append("view_order").append(":").append("\"" + menu.getView_order() + "\"").append(",");
//				builder.append("depth").append(":").append("\"" + menu.getDepth() + "\"").append(",");
//				builder.append("default_yn").append(":").append("\"" + menu.getDefault_yn() + "\"").append(",");
//				builder.append("use_yn").append(":").append("\"" + menu.getUse_yn() + "\"").append(",");
//				builder.append("url").append(":").append("\"" + menu.getUrl() + "\"").append(",");
//				builder.append("image").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",");
//				builder.append("image_alt").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage_alt()) + "\"").append(",");
//				builder.append("css_class").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCss_class()) + "\"").append(",");
//				builder.append("description").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
//				
//				if(i == (menuCount-1)) {
//					// 맨 마지막의 경우 괄호를 닫음
//					if(bigParentheses == 0) {
//						builder.append("}");
//					} else {
//						for(int k=0; k<bigParentheses; k++) {
//							builder.append("}");
//							builder.append("]");
//						}
//					}
//				}
//				
//				preParent = menu.getParent();
//				preDepth = menu.getDepth();
//			}
//		}
//		
//		builder.append("}");
//		builder.append("]");
//		
//		return builder.toString();
//	}
//}
