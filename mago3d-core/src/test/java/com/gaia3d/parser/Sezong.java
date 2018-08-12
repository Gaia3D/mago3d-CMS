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
		
		StringBuffer buffer = new StringBuffer();
		buffer.append("{");
		buffer.append("\"attributes\": {");
		buffer.append(		"\"isPhysical\": false,");
		buffer.append(		"\"nodeType\": \" root \",");
		buffer.append(		"\"projectType\": \"sejong\"");
		buffer.append("},");
		buffer.append("\"children\": [");

		int i=1; 
		int count = fileList.length;
		for(File file : fileList) {
			String fileName = file.getName();
			String[] fileNameValues = fileName.split("\\.");
			
			buffer.append("{");
			buffer.append("\"attributes\": {");
			buffer.append(		"\"isPhysical\": true,");
			buffer.append(		"\"nodeType\": \"sejong\"");
			buffer.append("},");
			buffer.append("\"children\": [],");
			buffer.append("\"data_key\": \"" + fileNameValues[0] + "\",");
			buffer.append("\"data_name\": \"" + fileNameValues[0] + "\",");
			buffer.append("\"latitude\": 36.5010938719156,");
			buffer.append("\"longitude\": 127.26557490316421,");
			buffer.append("\"height\": 0,");
			buffer.append("\"heading\": 0,");
			buffer.append("\"pitch\": 0,");
			buffer.append("\"roll\": 0");
			if(i == count) {
				System.out.println("i =" + i + ", count  = " + count);
				buffer.append("}");
			} else {
				buffer.append("},");
			}
			i++;
		}
		
		buffer.append("],");
		buffer.append("\"parent\": 0,");
		buffer.append("\"depth\": 1,");
		buffer.append("\"view_order\": 2,  ");
		buffer.append("\"data_key\": \"sejong\",");
		buffer.append("\"data_name\": \"sejong\"");
		buffer.append("}");
		
		File jsonFile = new File("D:\\sejong.json");
		FileWriter fileWriter = new FileWriter(jsonFile);
		fileWriter.write(buffer.toString());
		fileWriter.flush();
		fileWriter.close();
		
		System.out.println("end");
	}
}
