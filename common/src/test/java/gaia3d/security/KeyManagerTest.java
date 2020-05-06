package gaia3d.security;

import java.util.Base64;

import org.junit.jupiter.api.Test;

import gaia3d.security.KeyManager;

public class KeyManagerTest {

	@Test
	public void keyTest() throws Exception {
		String key = KeyManager.getInitKey();
		System.out.println(key);
		
		String encryptKey = "ZDNhaWFnQCBzaSBlbWFuIHltIC5wdGRuIHJvZiBhZWRpIGRhYiBhIGVrYW0gdG9uIG9kIGVzYWVscCAseWVrIHRlcmNzIyBkbnVvZiBldmFoIHVveSBmSQ==";
		byte[] base64decodedBytes = Base64.getDecoder().decode(encryptKey.getBytes("UTF-8"));
		String result = new String(base64decodedBytes, "UTF-8");
		result = (new StringBuffer(result)).reverse().toString();
		System.out.println("1 ===== " + result);
		result = result.substring(81, 87) + result.substring(64, 68) + result.substring(18, 24);
		System.out.println("2 ===== " + result);
	}

	@Test
	public void 키_암호화() throws Exception {
		String key = "If you have found #scret key, please do not make a bad idea for gaia3d. my name is @gaia3d";
		System.out.println("key = " + key);
		String reverseKey =  new StringBuffer(key).reverse().toString();
		System.out.println("reverseKey = " + reverseKey);
		String encryptKey = new String(Base64.getEncoder().encode(reverseKey.getBytes("UTF-8")));
		System.out.println("encryptKey = " + encryptKey);
	}
}
