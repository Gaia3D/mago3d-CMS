package com.gaia3d.helper;

import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserInfo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordHelper {

	/**
	 * @param policy
	 * @param userInfo
	 * @return
	 */
	public static String validateUserPassword(Policy policy, UserInfo userInfo) {
		String password;
		
		if("updatePassword".equals(userInfo.getMethod_mode())) {
			// 임시 비밀번호 변경 화면
			password = userInfo.getNew_password();
			if(userInfo.getPassword() == null || "".equals(userInfo.getPassword()) 
				|| userInfo.getNew_password() == null || "".equals(userInfo.getNew_password())
				|| userInfo.getNew_password().length() < policy.getPassword_min_length()
				|| userInfo.getNew_password().length() > policy.getPassword_max_length()
				|| userInfo.getNew_password_confirm() == null || "".equals(userInfo.getNew_password_confirm())
				|| userInfo.getNew_password_confirm().length() < policy.getPassword_min_length()
				|| userInfo.getNew_password_confirm().length() > policy.getPassword_max_length() ) {
				log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ user_info = {}", userInfo);
				return "user.password.invalid";
			}
		} else {
			// 사용자 등록, 수정 화면
			password = userInfo.getPassword();
			if(userInfo.getPassword() == null || "".equals(userInfo.getPassword()) 
				|| userInfo.getPassword().length() <  policy.getPassword_min_length()
				|| userInfo.getPassword().length() >  policy.getPassword_max_length()
				|| userInfo.getPassword_confirm() == null || "".equals(userInfo.getPassword_confirm()) 
				|| userInfo.getPassword_confirm().length() < policy.getPassword_min_length()
				|| userInfo.getPassword_confirm().length() > policy.getPassword_max_length()
				|| (!userInfo.getPassword().equals(userInfo.getPassword_confirm())) ) {
				return "user.password.invalid";
			}
		}
		
		String passwordExceptionChar = policy.getPassword_exception_char();
		int exceptionCount = 0;
		if(passwordExceptionChar != null && !"".equals(passwordExceptionChar)) {
			// TODO ', " 도 특수기호 처리 해야 함
			passwordExceptionChar += "'\"";
			exceptionCount = passwordExceptionChar.length();
			for(int i=0; i< exceptionCount; i++) {
				log.info("@@@@@ i = {}, String = {}", i, passwordExceptionChar.substring(i, i+1));
				if(password.indexOf(passwordExceptionChar.substring(i, i+1)) >= 0 ) {
					return "user.password.exception.char";
				}
			}
		}
		
		// 숫자 개수
		int digitCount = 0;
		// 소문자 개수
		int lowerCount = 0;
		// 대문자 개수
		int upperCount = 0;
		// 특수문자 개수
		int specialCount = 0;
		// 연속된 동일문자 반복 개수
		int continuousCharCount = 1;
//		char beforeChar = 'a'; 
		int count = password.length();
		for(int i=0; i < count; i++) {
			char ch = password.charAt(i);
			if(Character.isDigit(ch)) {
				digitCount++;
			} else if(Character.isUpperCase(ch)) {
				upperCount++;
			} else if(Character.isLowerCase(ch)) {
				lowerCount++;
			} else {
				specialCount++;
			}
			
		}
		
		if(digitCount < policy.getPassword_number_count()) {
			return "user.password.digit.invalid";
		} 
		if(upperCount < policy.getPassword_eng_upper_count()) {
			return "user.password.upper.invalid";
		} 
		if(lowerCount < policy.getPassword_eng_lower_count()) {
			return "user.password.lower.invalid";
		} 
		if(specialCount < policy.getPassword_special_char_count()) {
			return "user.password.special.invalid";
		}
		
		// 연속된 동일 문자 체크
		if(isContinueSameChar(password, policy.getPassword_continuous_char_count())) {
			return "user.password.continuous.char.invalid";
		}
//		if(continuousCharCount > policy.getPassword_continuous_char_count()) {
//			return "user.password.continuous.char.invalid";
//		}
		// 연속된 순서 체크
		if(isSequenceChar(password, policy.getPassword_continuous_char_count())) {
			return "user.password.continuous.char.invalid";
		}
		
		return null;
	}
	
	public static String randomPassword(int length) {
		int index = 0;
		char[] charSet = new char[] {
			    '0','1','2','3','4','5','6','7','8','9'
			    ,'A','B','C','D','E','F','G','H','I','J','K','L','M'
			    ,'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'
			    ,'a','b','c','d','e','f','g','h','i','j','k','l','m'
			    ,'n','o','p','q','r','s','t','u','v','w','x','y','z'};
		
		StringBuffer sb = new StringBuffer();
		for (int i=0; i<length; i++) {
			index =  (int) (charSet.length * Math.random());
			sb.append(charSet[index]);
		}
		return sb.toString();
	}
	
	/**
	 * 동일 문자 연속 입력 검증 (111, aaa)
	 * 
	 * @param pwd
	 * @return
	 */
	public static boolean isContinueSameChar(String pwd, int continuous_char_count) {

		int p = pwd.length();
		boolean isSame = false;

		if (continuous_char_count != 0 && p >= continuous_char_count) {
			byte[] b = pwd.getBytes();

			for (int i = 0; i <= p - continuous_char_count; i++) {
				// int b1 = b[i + 1];
				// int b2 = b[i + 2];

				isSame = false;
				for (int j = i + 1; j <= i + continuous_char_count - 1; j++) {
					// System.out.println("b[i] = " + pwd.charAt(i));
					// System.out.println("b[j] = " + pwd.charAt(j));
					if (b[i] == b[j]) {
						isSame = true;
					} else {
						isSame = false;
						break;
					}
					// System.out.println("isSame = " + isSame);
				}

				// System.out.println("==========");
				if (isSame) {
					return true;
				}

			}
		}

		return isSame;
	}

	/**
	 * 연속되는 문자 입력 검증 (123, abc)
	 * 
	 * @param pwd
	 * @return
	 */
	public static boolean isSequenceChar(String pwd, int continuous_char_count) {
		
		boolean isSame = false;
		
		byte[] b = pwd.getBytes();
		int p = pwd.length();

		if (continuous_char_count != 0 &&  p >= continuous_char_count) {
			// 연속된 3개의 문자 사용불가 (오름차순)
			
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ continuous_char_count = {}", continuous_char_count);
			if(continuous_char_count == 2) {
				for (int i = 0; i <= p - continuous_char_count; i++) {
					int b1 = b[i] + 1;
					int b2 = b[i + 1];
					log.info("@@@@@@@  b1 = {}, b2 = {}", b1, b2);
					if(b1 == b2) {
						return true;
					} else {
						continue;
					}
				}
			} else if(continuous_char_count == 3) {
				for (int i = 0; i <= p - continuous_char_count; i++) {
					
					int b1 = b[i] + 1;
					int b2 = b[i + 1];
					int b3 = b[i + 1] + 1;
					int b4 = b[i + 2];

					log.info("@@@@@@@  b1 = {}, b2 = {}, b3 = {}, b4 = {}", b1, b2, b3, b4);
					if ((b1 == b2) && (b3 == b4)) {
						return true;
					} else {
						continue;
					}
				}
			} if(continuous_char_count == 4) {
				for (int i = 0; i <= p - continuous_char_count; i++) {
					
					int b1 = b[i] + 1;
					int b2 = b[i + 1];
					int b3 = b[i + 1] + 1;
					int b4 = b[i + 2];
					int b5 = b[i + 2] + 1;
					int b6 = b[i + 3];

					log.info("@@@@@@@  b1 = {}, b2 = {}, b3 = {}, b4 = {}, b5 = {}, b6 = {}", b1, b2, b3, b4, b5, b6);
					if ((b1 == b2) && (b3 == b4) && (b5 == b6)) {
						return true;
					} else {
						continue;
					}
				}
			}
			
			// 연속된 3개의 문자 사용불가 (내림차순)
			// for (int i = 0; i < ((p * 2) / 3); i++) {
			// int b1 = b[i + 1] + 1;
			// int b2 = b[i + 2] + 2;
			//
			// if ((b[i] == b1) && (b[i] == b2)) {
			// return true;
			// } else {
			// continue;
			// }
			// }
		}
		return isSame;
	}
}
