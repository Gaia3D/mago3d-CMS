package com.gaia3d.security;

import org.junit.Test;

public class CryptTest {

	@Test
	public void test() {
		System.out.println(Crypt.encrypt("jdbc:postgresql://localhost:5432/mago3d"));
		System.out.println(Crypt.encrypt("postgres"));
		System.out.println(Crypt.encrypt("postgres"));
		System.out.println(Crypt.encrypt("test"));
		
		System.out.println(Crypt.encrypt("mago3d-rest-api-key"));
	}

}
