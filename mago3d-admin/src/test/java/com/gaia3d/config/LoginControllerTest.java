package com.gaia3d.config;

import org.junit.Test;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCrypt;

import com.gaia3d.domain.SessionKey;

public class LoginControllerTest {

	@Test
	public void test() {
		// 'admin', 1, '슈퍼관리자', 'scYISRCtE5buaoxtL9XkmWR71iUbOpfFUCOlJjZDFso=', '$2a$10$nvWy9SLYNRLGJUUcLtyXgO', 'N', now()
		String password = "postgresql";
		String salt = BCrypt.gensalt();
		System.out.println(salt);
		
		ShaPasswordEncoder shaPasswordEncoder = new ShaPasswordEncoder(512);
		String encryptPassword = shaPasswordEncoder.encodePassword(password, salt);
		
		System.out.println(encryptPassword);
		
		System.out.println(SessionKey.SESSION_TOKEN_AES_KEY.name());
	}
}
