package com.gaia3d.domain;

import org.junit.Test;

public class CacheNameTest {

	@Test
	public void test() {
		CacheName name = CacheName.valueOf("PROJECT");
		CacheType type = CacheType.valueOf("BROADCAST");
		
		System.out.println(name.toString());
		System.out.println(type.toString());
		
		if(CacheName.PROJECT == name) {
			System.out.println("equals");
		}
	}

}
