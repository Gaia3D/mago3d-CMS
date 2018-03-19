package com.gaia3d.parser;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Iterator;
import java.util.Map;

import org.junit.Test;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaia3d.domain.DataObjectAttributeFilter;

public class DataObjectAttributeFileJsonParser {

	@Test
	public void test() throws Exception {
		String attributeDir = "D:\\mago3d\\data\\attribute\\";
		
		File attributeDirFile = new File(attributeDir);
		if(!attributeDirFile.exists()) {
			System.out.println("디렉토리가 존재하지 않습니다.");
			return;
		}
		
		File[] fileList = attributeDirFile.listFiles(new DataObjectAttributeFilter());
		for(File file : fileList) {
			// 1 data_key 를 가지고 정보를 조회
			// attribute table 조회
			// insert or update
			
			String fileName = file.getName();
			System.out.println("@@@@@@@@@@@@@@@ fileName = " + fileName);
			int startIndex = fileName.indexOf("F4D_");
			int endIndex = fileName.toLowerCase().indexOf("_attribute");
			String dataKey = fileName.substring(startIndex + 4, endIndex);
			System.out.println("@@@@@@@@@@@@@@@ dataKey = " + dataKey);
			
			byte[] jsonData = Files.readAllBytes(Paths.get(file.getAbsolutePath()));
			ObjectMapper objectMapper = new ObjectMapper();
			//read JSON like DOM Parser
			JsonNode jsonNode = objectMapper.readTree(jsonData);
			Iterator<Map.Entry<String, JsonNode>> fields = jsonNode.fields();
			 while (fields.hasNext()) {
			    Map.Entry<String, JsonNode> entry = fields.next();
			    System.out.println("-----------" + entry.getKey() + "=================" + entry.getValue());
			 }
		}
	}
}
