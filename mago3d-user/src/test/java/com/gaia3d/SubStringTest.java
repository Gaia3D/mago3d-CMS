package com.gaia3d;

import org.junit.Test;

public class SubStringTest {

	@Test
	public void test() {
		String fileName = "F4D_test1111";
		System.out.println(fileName.substring(fileName.indexOf("F4D_") + 4));
		
		fileName = "gt1000_20.180814173319_4239425549773..00.ifc";
		System.out.println(fileName.substring(0, fileName.lastIndexOf(".")));
	}
}
