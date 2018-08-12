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
//		Map<String, String> map = new HashMap<String, String>();
//		String menuTree = null;
//		List<Menu> menuList = new ArrayList<>();
//		menuList.add(getRootMenu());
//		menuTree = getMenuTree(menuList);
//		map.put("menuTree", menuTree);
//		
//		System.out.println(gson.toJson(map));
//		
//		String jsonString = gson.toJson(map);
//		System.out.println("================ " + jsonString.replace("\\", ""));
//		
////		map jsObject = new map();
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
//		StringBuffer buffer = new StringBuffer();
//		
//		int menuCount = menuList.size();
//		Menu menu = menuList.get(0);
//		
//		buffer.append("[");
//		buffer.append("{");
//		
//		buffer.append("menu_id").append(":").append("\"" + menu.getMenu_id() + "\"").append(",");
//		buffer.append("name").append(":").append("\"" + menu.getName() + "\"").append(",");
//		buffer.append("name_en").append(":").append("\"" + menu.getName_en() + "\"").append(",");
//		buffer.append("open").append(":").append("\"" + menu.getOpen() + "\"").append(",");
//		buffer.append("node_type").append(":").append("\"" + menu.getNode_type() + "\"").append(",");
//		buffer.append("parent").append(":").append("\"" + menu.getParent() + "\"").append(",");
//		buffer.append("parent_name").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParent_name()) + "\"").append(",");
//		buffer.append("view_order").append(":").append("\"" + menu.getView_order() + "\"").append(",");
//		buffer.append("depth").append(":").append("\"" + menu.getDepth() + "\"").append(",");
//		buffer.append("default_yn").append(":").append("\"" + menu.getDefault_yn() + "\"").append(",");
//		buffer.append("use_yn").append(":").append("\"" + menu.getUse_yn() + "\"").append(",");
//		buffer.append("url").append(":").append("\"" + menu.getUrl() + "\"").append(",");
//		buffer.append("image").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",");
//		buffer.append("image_alt").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage_alt()) + "\"").append(",");
//		buffer.append("css_class").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCss_class()) + "\"").append(",");
//		buffer.append("description").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
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
//					buffer.append("}");
//					buffer.append(",");
//				} else {
//					if(preDepth > menu.getDepth()) {
//						// 닫힐때
//						int closeCount = preDepth - menu.getDepth();
//						for(int j=0; j<closeCount; j++) {
//							buffer.append("}");
//							buffer.append("]");
//							bigParentheses--;
//						}
//						buffer.append("}");
//						buffer.append(",");
//					} else {
//						// 열릴때
//						buffer.append(",");
//						buffer.append("subTree").append(":").append("[");
//						bigParentheses++;
//					}
//				} 
//				
//				buffer.append("{");
//				buffer.append("menu_id").append(":").append("\"" + menu.getMenu_id() + "\"").append(",");
//				buffer.append("name").append(":").append("\"" + menu.getName() + "\"").append(",");
//				buffer.append("name_en").append(":").append("\"" + menu.getName_en() + "\"").append(",");
//				buffer.append("open").append(":").append("\"" + menu.getOpen() + "\"").append(",");
//				buffer.append("node_type").append(":").append("\"" + menu.getNode_type() + "\"").append(",");
//				buffer.append("parent").append(":").append("\"" + menu.getParent() + "\"").append(",");
//				buffer.append("parent_name").append(":").append("\"" + StringUtil.getDefaultValue(menu.getParent_name()) + "\"").append(",");
//				buffer.append("view_order").append(":").append("\"" + menu.getView_order() + "\"").append(",");
//				buffer.append("depth").append(":").append("\"" + menu.getDepth() + "\"").append(",");
//				buffer.append("default_yn").append(":").append("\"" + menu.getDefault_yn() + "\"").append(",");
//				buffer.append("use_yn").append(":").append("\"" + menu.getUse_yn() + "\"").append(",");
//				buffer.append("url").append(":").append("\"" + menu.getUrl() + "\"").append(",");
//				buffer.append("image").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage()) + "\"").append(",");
//				buffer.append("image_alt").append(":").append("\"" + StringUtil.getDefaultValue(menu.getImage_alt()) + "\"").append(",");
//				buffer.append("css_class").append(":").append("\"" + StringUtil.getDefaultValue(menu.getCss_class()) + "\"").append(",");
//				buffer.append("description").append(":").append("\"" + StringUtil.getDefaultValue(menu.getDescription()) + "\"");
//				
//				if(i == (menuCount-1)) {
//					// 맨 마지막의 경우 괄호를 닫음
//					if(bigParentheses == 0) {
//						buffer.append("}");
//					} else {
//						for(int k=0; k<bigParentheses; k++) {
//							buffer.append("}");
//							buffer.append("]");
//						}
//					}
//				}
//				
//				preParent = menu.getParent();
//				preDepth = menu.getDepth();
//			}
//		}
//		
//		buffer.append("}");
//		buffer.append("]");
//		
//		return buffer.toString();
//	}
//}
