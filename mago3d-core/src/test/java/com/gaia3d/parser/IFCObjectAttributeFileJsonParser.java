package com.gaia3d.parser;

import static org.junit.Assert.*;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.DataObjectAttributeFilter;

public class IFCObjectAttributeFileJsonParser {

	@Test
	public void test() throws IOException {
		String attributeDir = "D:\\mago3d\\sample\\test";
		
		File attributeDirFile = new File(attributeDir);
		if(!attributeDirFile.exists()) {
			System.out.println("디렉토리가 존재하지 않습니다.");
			return;
		}
		
		//File[] fileList = attributeDirFile.listFiles(new DataObjectAttributeFilter());
		File[] fileList = attributeDirFile.listFiles();
		for(File file : fileList) {
			// 1 data_key 를 가지고 정보를 조회
			// attribute table 조회
			// insert or update
			
			String fileName = file.getName();
			System.out.println("file name = " + fileName);
			byte[] jsonData = Files.readAllBytes(Paths.get(file.getAbsolutePath()));
			ObjectMapper objectMapper = new ObjectMapper();
			//read JSON like DOM Parser
			JsonNode rootNode = objectMapper.readTree(jsonData);
			JsonNode objectsNode = rootNode.path("objects");
			int i=0;
			if(objectsNode.isArray() && objectsNode.size() != 0) {
				for(JsonNode node : objectsNode) {
//					System.out.println("i = " + i + ", guid = " + node.path("guid").asText());
//					System.out.println("i = " + i + ", guid = " + node.path("entityType").asText());
					System.out.println("i = " + i + ", propertySets = " + node.path("propertySets").toString());
					i++;
				}
			}
			
			
//			Iterator<Map.Entry<String, JsonNode>> fields = jsonNode.fields();
//			int i=0; 
//			while (fields.hasNext()) {
//				JsonNode childrenNode = jsonNode.path("children");
//				
//				Map.Entry<String, JsonNode> entry = fields.next();
//				if("guid".equals(entry.getKey())) {
//					//System.out.println("-----------" + entry.getKey() + "=================" + entry.getValue());
//					System.out.println("i = " + i + ",guid = " + entry.getValue());
//					i++;
//				}
//			}
		}
		
		
//		if(childrenNode.isArray() && childrenNode.size() != 0) {
//			recusiveParse(dataList, depth, childrenNode);
//		}
	}

	private void recusiveParse(List<DataInfo> dataList, int depth, JsonNode childrenArrayNode) {
	depth++;
	
//	System.out.println();
//	System.out.println("children size = " + childrenArrayNode.size());
	for(JsonNode node : childrenArrayNode) {
		String dataName = node.path("data_name").asText();
		String dataKey = node.path("data_key").asText();
		String latitude = node.path("latitude").asText();
		String longitude = node.path("longitude").asText();
		String height = node.path("height").asText();
		String heading = node.path("heading").asText();
		String pitch = node.path("pitch").asText();
		String roll = node.path("roll").asText();
		JsonNode attributes = node.path("attributes");
		JsonNode childrenNode = node.path("children");
		
//		System.out.println("data_name = " + dataName);
//		System.out.println("data_key = " + dataKey);
//		System.out.println("longitudeNode = " + longitude);
//		System.out.println("depth = " + depth);
		//System.out.println("attributes = " + attributes);
		
		DataInfo dataInfo = new DataInfo();
		dataInfo.setData_name(dataName);
		dataInfo.setData_key(dataKey);
		if(latitude != null && !"".equals(latitude)) dataInfo.setLatitude(new BigDecimal(latitude));
		if(longitude != null && !"".equals(longitude)) dataInfo.setLongitude(new BigDecimal(longitude));
		if(height != null && !"".equals(height)) dataInfo.setHeight(new BigDecimal(height));
		if(heading != null && !"".equals(heading)) dataInfo.setHeading(new BigDecimal(heading));
		if(pitch != null && !"".equals(pitch)) dataInfo.setPitch(new BigDecimal(pitch));
		if(roll != null && !"".equals(roll)) dataInfo.setRoll(new BigDecimal(roll));
		dataInfo.setAttributes(attributes.toString());
		dataInfo.setDepth(depth);
		
		System.out.println(dataInfo.toString());
		
		if(childrenNode.isArray() && childrenNode.size() != 0) {
			recusiveParse(dataList, depth, childrenNode);
		}
	}
}
}
