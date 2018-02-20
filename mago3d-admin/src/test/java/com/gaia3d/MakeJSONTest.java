package com.gaia3d;

import static org.junit.Assert.*;

import java.io.BufferedWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.junit.Test;

public class MakeJSONTest {

	@Test
	public void test() {
		Path path = Paths.get("D:\\data\\object_attribute.json");
		 
		//Use try-with-resource to get auto-closeable writer instance
		String jsonData = "{";
		try (BufferedWriter writer = Files.newBufferedWriter(path))
		{
			writer.write(jsonData);
			for(int i=0; i<=1000000; i++) {
				jsonData = "\"Object_ID_" + i + "\" : { "
						+ 		"\"Description\" : \"400*400\","
						+ 		"\"IfcEntity\" : \"IfcColumn\","
						+ 		"\"Name\" : \"COLUMN" + i + "\","
						+ 		"\"ObjectType\" : \"COLUMN" + i + "\","
						+ 		"\"Tag\" : \"ID527CF1F3-0000-00FE-3133-" + i + "\"";
				if(i == 1000000) {
					jsonData = jsonData + "}";
				} else {
					jsonData = jsonData +  "},";
				}
						
				writer.write(jsonData);
			}
			
			jsonData = "}";
			writer.write(jsonData);
			
			System.out.println("!!!!!!!!!!!!!!!!! end");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
