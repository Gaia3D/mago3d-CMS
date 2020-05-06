package gaia3d.utils;

import java.io.File;
import java.math.BigDecimal;

import org.junit.jupiter.api.Test;

class FileUtilsTest {

	@Test
	void test() {
//		String dataServicePath = "C:\\data\\mago3d\\f4d\\";
//		String dataGroupPath = "gt1000/test";
//		String[] sub1 = dataGroupPath.split("/");
//		
//		System.out.println(sub1.length);
//		for(String directory : sub1) {
//			System.out.println(" directory = " + directory);
//		}
//		
//		String dataGroupPath2 = "gt1000/test/";
//		String[] sub2 = dataGroupPath2.split("/");
//		System.out.println(sub2.length);
//		for(String directory : sub2) {
//			System.out.println(" directory = " + directory);
//		}
		
		String dataGroupPath = "mago3d/";
		String[] names = dataGroupPath.split("/");
		
		String filePath = "";
		for(String name : names) {
			filePath = filePath + name + File.separator;
		}
	
		BigDecimal bigDecimal = BigDecimal.valueOf(0.001);
		System.out.println(bigDecimal.toString());
		
		System.out.println(filePath);
	}

}
