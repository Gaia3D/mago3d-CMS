package com.gaia3d.parser;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.junit.Ignore;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaia3d.domain.DataInfo;

public class DataFileJsonParser {

	@Ignore
	public void parse() throws Exception {
		byte[] jsonData = Files.readAllBytes(
				Paths.get("C:\\git\\repository\\mago3d\\mago3d-core\\src\\test\\java\\com\\gaia3d\\parser\\2119_fullship.json"));

		//create ObjectMapper instance
		ObjectMapper objectMapper = new ObjectMapper();
		List<DataInfo> dataList = new ArrayList<>();

		//read JSON like DOM Parser
		JsonNode rootNode = objectMapper.readTree(jsonData);
		JsonNode dataNameNode = rootNode.path("data_name");
		JsonNode dataKeyNode = rootNode.path("data_key");
		JsonNode latitudeNode = rootNode.path("latitude");
		JsonNode longitudeNode = rootNode.path("longitude");
		JsonNode heightNode = rootNode.path("height");
		JsonNode headingNode = rootNode.path("heading");
		JsonNode pitchNode = rootNode.path("pitch");
		JsonNode rollNode = rootNode.path("roll");
		JsonNode attributesNode = rootNode.path("attributes");
		
		DataInfo dataInfo = new DataInfo();
		dataInfo.setData_name(dataNameNode.asText());
		dataInfo.setData_key(dataKeyNode.asText());
		
		if(latitudeNode.asText() != null && !"".equals(latitudeNode.asText())) dataInfo.setLatitude(new BigDecimal(latitudeNode.asText()));
		if(longitudeNode.asText() != null && !"".equals(longitudeNode.asText())) dataInfo.setLongitude(new BigDecimal(longitudeNode.asText()));
		if(heightNode.asText() != null && !"".equals(heightNode.asText())) dataInfo.setHeight(new BigDecimal(heightNode.asText()));
		if(headingNode.asText() != null && !"".equals(headingNode.asText())) dataInfo.setHeading(new BigDecimal(headingNode.asText()));
		if(pitchNode.asText() != null && !"".equals(pitchNode.asText())) dataInfo.setPitch(new BigDecimal(pitchNode.asText()));
		if(rollNode.asText() != null && !"".equals(rollNode.asText())) dataInfo.setRoll(new BigDecimal(rollNode.asText()));
		dataInfo.setAttributes(attributesNode.toString());
		
		int depth = 1;
		dataInfo.setDepth(depth);
		
		JsonNode childrenNode = rootNode.path("children");
		
//		System.out.println("data_name = " + dataNameNode.asText());
//		System.out.println("depth = " + depth);
		//System.out.println("attributes = " + attributesNode.toString());
		
		dataList.add(dataInfo);
		
		System.out.println(dataInfo);
		if(childrenNode.isArray() && childrenNode.size() != 0) {
			recusiveParse(dataList, depth, childrenNode);
		}
	}
	
	private void recusiveParse(List<DataInfo> dataList, int depth, JsonNode childrenArrayNode) {
		depth++;
		
//		System.out.println();
//		System.out.println("children size = " + childrenArrayNode.size());
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
			
//			System.out.println("data_name = " + dataName);
//			System.out.println("data_key = " + dataKey);
//			System.out.println("longitudeNode = " + longitude);
//			System.out.println("depth = " + depth);
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
