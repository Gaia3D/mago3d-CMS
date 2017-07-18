package com.gaia3d;

import static org.junit.Assert.*;

import org.junit.Test;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;

public class PasswordTest {

	@Test
	public void test() {
		String salt = "aaa";
		
		ShaPasswordEncoder shaPasswordEncoder = new ShaPasswordEncoder(512);
		shaPasswordEncoder.setIterations(1000);
		String encriptPassword = shaPasswordEncoder.encodePassword("test", salt) ;
		System.out.println(encriptPassword);
	}

}
