package com.gaia3d.parser;

import static org.junit.Assert.*;

import java.io.File;
import java.util.List;

import org.junit.Test;

public class DataAttributeFileJsonParser {

	@Test
	public void test() {
		String attributeDir = "D:\\mago3d\\data\\attribute\\";
		
		File attributeDirFile = new File(attributeDir);
		if(!attributeDirFile.exists()) {
			System.out.println("디렉토리가 존재하지 않습니다.");
			return;
		}
		
		//File[] fileList = attributeDirFile.listFiles(filter)
	}
}
