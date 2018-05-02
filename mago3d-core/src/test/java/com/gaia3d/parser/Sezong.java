package com.gaia3d.parser;

import java.io.File;
import java.io.FileWriter;

import org.junit.Ignore;
import org.junit.Test;

public class Sezong {

	@Ignore
	public void test() throws Exception {
		String attributeDir = "D:\\프로젝트\\세종시\\세종청사 1식.vol1\\3ds\\세종청사_3ds";
		
		File attributeDirFile = new File(attributeDir);
		if(!attributeDirFile.exists()) {
			System.out.println("디렉토리가 존재하지 않습니다.");
			return;
		}
		
		File[] fileList = attributeDirFile.listFiles(new ThreeDSFilter());
		
		StringBuilder builder = new StringBuilder();
		builder.append("{");
		builder.append("\"attributes\": {");
		builder.append(		"\"isPhysical\": false,");
		builder.append(		"\"nodeType\": \" root \",");
		builder.append(		"\"projectType\": \"sejong\"");
		builder.append("},");
		builder.append("\"children\": [");

		int i=1; 
		int count = fileList.length;
		for(File file : fileList) {
			String fileName = file.getName();
			String[] fileNameValues = fileName.split("\\.");
			
			builder.append("{");
			builder.append("\"attributes\": {");
			builder.append(		"\"isPhysical\": true,");
			builder.append(		"\"nodeType\": \"sejong\"");
			builder.append("},");
			builder.append("\"children\": [],");
			builder.append("\"data_key\": \"" + fileNameValues[0] + "\",");
			builder.append("\"data_name\": \"" + fileNameValues[0] + "\",");
			builder.append("\"latitude\": 36.5010938719156,");
			builder.append("\"longitude\": 127.26557490316421,");
			builder.append("\"height\": 0,");
			builder.append("\"heading\": 0,");
			builder.append("\"pitch\": 0,");
			builder.append("\"roll\": 0");
			if(i == count) {
				System.out.println("i =" + i + ", count  = " + count);
				builder.append("}");
			} else {
				builder.append("},");
			}
			i++;
		}
		
		builder.append("],");
		builder.append("\"parent\": 0,");
		builder.append("\"depth\": 1,");
		builder.append("\"view_order\": 2,  ");
		builder.append("\"data_key\": \"sejong\",");
		builder.append("\"data_name\": \"sejong\"");
		builder.append("}");
		
		File jsonFile = new File("D:\\sejong.json");
		FileWriter fileWriter = new FileWriter(jsonFile);
		fileWriter.write(builder.toString());
		fileWriter.flush();
		fileWriter.close();
		
		System.out.println("end");
	}
}
