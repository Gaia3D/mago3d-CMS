package com.gaia3d.security;

import java.util.Base64;

import org.junit.Test;

public class KeyManagerTest {

	@Test
	public void test() throws Exception {
		String key = KeyManager.getInitKey();
		System.out.println(key);
		
		String encryptKey = "MDAwMXRnIHNpIGVtYW4geW0gLmFlZGkgZGFiIGEgZWthbSB0b24gb2QgZXNhZWxwICx5ZWsgbm9pdHB5cmNuZSBlaHQgZG51b2YgZXZhaCB1b3kgZkk=";
		byte[] base64decodedBytes = Base64.getDecoder().decode(encryptKey.getBytes("UTF-8"));
		String result = new String(base64decodedBytes, "UTF-8");
		result = (new StringBuffer(result)).reverse().toString();
		System.out.println("1 ===== " + result);
		result = result.substring(80, 86) + result.substring(22, 29) + result.substring(33, 36);
		System.out.println("2 ===== " + result);
	}

	@Test
	public void 키_암호화() throws Exception {
		String key = "If you have found the encryption key, please do not make a bad idea. my name is gt1000";
		System.out.println("key = " + key);
		String reverseKey =  new StringBuffer(key).reverse().toString();
		System.out.println("reverseKey = " + reverseKey);
		String encryptKey = new String(Base64.getEncoder().encode(reverseKey.getBytes("UTF-8")));
		System.out.println("encryptKey = " + encryptKey);
	}
}
