package com.gaia3d.config;

import org.junit.Ignore;
import org.springframework.security.crypto.bcrypt.BCrypt;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginControllerTest {

	@Ignore
	public void test() {
		// 'admin', 1, '슈퍼관리자', 'scYISRCtE5buaoxtL9XkmWR71iUbOpfFUCOlJjZDFso=', '"$2a$10$CMK4Fnjhg/CPE71xYSW9Se"', 'N', now()
		String password = "admin";
		String salt = "$2a$10$5k31m5NLTdQEV7SgsV/lTO";
		System.out.println(salt);
		
		String encryptPassword = BCrypt.hashpw(password, salt);
		log.info(">>encryptPassword = {}", encryptPassword);
	}
}
