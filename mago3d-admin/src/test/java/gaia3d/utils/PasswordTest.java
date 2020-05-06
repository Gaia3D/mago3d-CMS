package gaia3d.utils;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class PasswordTest {

	@Test
	@DisplayName("BCrypt 비밀번호 테스트")
	void bcryptTest() {
		//String password = "test";
		//String salt = BCrypt.gensalt(10);
		String dbSalt = "$2a$10$raxA9.ppTStr4t.sG.OtDu22322332232323";
		String dbPassword = "$2a$10$raxA9.ppTStr4t.sG.OtDuHxtQRUvuUlZ/SEs67YC78KhXgdZVjhK";
		
		//boolean isValidPassword = BCrypt.checkpw("test", "$2a$10$X/3qX75eyGZSp6jwUTpooe2DYjcTwJff0NYdkFWcTw09P9MbiHXWO");
		
		String encodedPassword = BCrypt.hashpw("test", dbSalt);
		
		log.info("password1 = {}", dbPassword);
		log.info("password2 = {}", encodedPassword);
		if(dbPassword.equals(encodedPassword)) {
			System.out.println("같다.");
		} else {
			System.out.println("다르다.");
		}
	}
	
	@Test
	@DisplayName("비밀번호 테스트")
	void bCryptPasswordEncoderTest() throws Exception {
		BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder(10);
		String encodePassword = bCryptPasswordEncoder.encode("mago3d");
		log.info("encodePassword = {}", encodePassword);
		assertEquals(bCryptPasswordEncoder.matches("test", "$2a$10$7Y4jEH.GYaAaWuZxVt6Eq.EOUQBxbBk/I.7B3cURSR7BCuku3scjq"), true);
	}
}
