package com.gaia3d;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.springframework.security.crypto.bcrypt.BCrypt;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordTest {

	private String plainTextPassword = "admin";
	private String dbSalt = "$2a$10$C9.iMMkLbAd.thT2bR4yNu";
	private String dbPassword = BCrypt.hashpw(plainTextPassword, dbSalt);
	
	@Test
	public void 솔트() {
		String salt = BCrypt.gensalt();
		log.info("salt = {}", salt);
	}
	
	@Test
	public void 솔트_기본값은_열자리() {
		// 4에서 31까지 가능하지만..... 10자리 이후부터는 엄청나게 느려짐
		// 복잡도와 관계가 있음
		String salt = BCrypt.gensalt();
		log.info(">>salt = {}", salt);
		assertEquals("기본 생성 logs_rounds = {}", "10", salt.substring(4,6));
	}

	@Test
	public void 암호화된_비밀번호() {
		log.info(">>password = {}", plainTextPassword);
		//String salt = BCrypt.gensalt();
		log.info(">>dbSalt = {}", dbSalt);
		String encryptPassword = BCrypt.hashpw(plainTextPassword, dbSalt);
		log.info(">>encryptPassword = {}", encryptPassword);
	}
	
	@Test
	public void 암호화된_비밀번호_값비교() {
		// 분석이 필요함
		//assertEquals("암호값이 같습니다.", true, BCrypt.checkpw(plainTextPassword, dbPassword));
	}
	
	@Test
	public void 솔트값_평문비밀번호_DB비밀번호_비교() {
		assertEquals("암호값이 같습니다.", dbPassword, BCrypt.hashpw(plainTextPassword, dbSalt));
	}
}
	