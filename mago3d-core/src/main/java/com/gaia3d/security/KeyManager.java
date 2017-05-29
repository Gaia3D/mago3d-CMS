package com.gaia3d.security;

import java.util.Base64;

public class KeyManager {

	private static final String randomKeyword = "MDAwMXRnIHNpIGVtYW4geW0gLmFlZGkgZGFiIGEgZWthbSB0b24gb2QgZXNhZWxwICx5ZWsgbm9pdHB5cmNuZSBlaHQgZG51b2YgZXZhaCB1b3kgZkk=";

	public static String getInitKey() {
		String result = null;
		try {
			byte[] base64decodedBytes = Base64.getDecoder().decode(randomKeyword.getBytes("UTF-8"));
			result = new String(base64decodedBytes, "UTF-8");
		} catch(Exception e) {
			e.printStackTrace();
		}
		result = reverseString(result);
		
		return parse(result);
	}
	
	private static String reverseString(String value) {
		if(value == null) return "";
		return (new StringBuffer(value)).reverse().toString();
	}
	
	private static String parse(String value) {
		return value.substring(80, 86) + value.substring(22, 29) + value.substring(33, 36);
	}
}
