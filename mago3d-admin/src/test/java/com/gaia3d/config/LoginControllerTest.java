package com.gaia3d.config;

import org.junit.Test;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCrypt;

public class LoginControllerTest {

	@Test
	public void test() {
		// 'admin', 1, '슈퍼관리자', 'scYISRCtE5buaoxtL9XkmWR71iUbOpfFUCOlJjZDFso=', '"$2a$10$CMK4Fnjhg/CPE71xYSW9Se"', 'N', now()
		String password = "admin";
		String salt = "$2a$10$CMK4Fnjhg/CPE71xYSW9Se";
		System.out.println(salt);
		
		ShaPasswordEncoder shaPasswordEncoder = new ShaPasswordEncoder(512);
		shaPasswordEncoder.setIterations(1000);
		String encryptPassword = shaPasswordEncoder.encodePassword(password, salt);
		
		System.out.println(encryptPassword);
	}
}
