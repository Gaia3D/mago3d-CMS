package com.gaia3d;

import org.junit.Test;

public class SubStringTest {

	@Test
	public void test() {
		String fileName = "F4D_test1111";
		System.out.println(fileName.substring(fileName.indexOf("F4D_") + 4));
	}
}
