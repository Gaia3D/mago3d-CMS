package gaia3d.support;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import gaia3d.domain.policy.Policy;
import gaia3d.domain.user.UserInfo;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PasswordSupport {

	/**
	 * Optional 로 고쳐야 하나?
	 * @param password
	 * @return
	 */
	public static String encodePassword(String password) {
		String encodePassword = null;
		try {
			BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder(10);
			encodePassword = bCryptPasswordEncoder.encode(password);
		
		} catch(RuntimeException e) {
			log.info("@@ RuntimeException. message = {}", e.getMessage());
		} catch(Exception e) {
			log.info("@@ 사인인 체크 암호화 처리 모듈에서 오류가 발생 했습니다. message = {}", e.getMessage());
		}
		
		return encodePassword;
	}
	
	public static boolean isEquals(String dbPassword, String textPassword) {
		boolean result = false;
		try {
			BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder(10);
			if(bCryptPasswordEncoder.matches(textPassword, dbPassword)) {
				log.error("@@ 비밀번호 matches = true. ");
				result = true;
			}
		} catch(RuntimeException e) {
			log.info("@@ RuntimeException. message = {}", e.getMessage());
		} catch(Exception e) {
			log.info("@@ 사인인 체크 암호화 처리 모듈에서 오류가 발생 했습니다. message = {}", e.getMessage());
		}
		return result;
	}
	
	/**
	 * @param policy
	 * @param userInfo
	 * @return
	 */
	public static String validateUserPassword(Policy policy, UserInfo userInfo) {
		
		// 임시 비밀번호 변경 화면
		String password = userInfo.getNewPassword();
		if(userInfo.getPassword() == null || "".equals(userInfo.getPassword()) 
			|| userInfo.getNewPassword() == null || "".equals(userInfo.getNewPassword())
			|| userInfo.getNewPassword().length() < policy.getPasswordMinLength()
			|| userInfo.getNewPassword().length() > policy.getPasswordMaxLength()
			|| userInfo.getNewPasswordConfirm() == null || "".equals(userInfo.getNewPasswordConfirm())
			|| userInfo.getNewPasswordConfirm().length() < policy.getPasswordMinLength()
			|| userInfo.getNewPasswordConfirm().length() > policy.getPasswordMaxLength() ) {
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ userInfo = {}", userInfo);
			return "user.password.invalid";
		}
		
		String passwordExceptionChar = policy.getPasswordExceptionChar();
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
		
		if(digitCount < policy.getPasswordNumberCount()) {
			return "user.password.digit.invalid";
		} 
		if(upperCount < policy.getPasswordEngUpperCount()) {
			return "user.password.upper.invalid";
		} 
		if(lowerCount < policy.getPasswordEngLowerCount()) {
			return "user.password.lower.invalid";
		} 
		if(specialCount < policy.getPasswordSpecialCharCount()) {
			return "user.password.special.invalid";
		}
		
		// 연속된 동일 문자 체크
		if(isContinueSameChar(password, policy.getPasswordContinuousCharCount())) {
			return "user.password.continuous.char.invalid";
		}
//		if(continuousCharCount > policy.getPassword_continuous_char_count()) {
//			return "user.password.continuous.char.invalid";
//		}
		// 연속된 순서 체크
		if(isSequenceChar(password, policy.getPasswordContinuousCharCount())) {
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
	public static boolean isContinueSameChar(String pwd, int continuousCharCount) {

		int p = pwd.length();
		boolean isSame = false;

		if (continuousCharCount != 0 && p >= continuousCharCount) {
			byte[] b = pwd.getBytes();

			for (int i = 0; i <= p - continuousCharCount; i++) {
				// int b1 = b[i + 1];
				// int b2 = b[i + 2];

				isSame = false;
				for (int j = i + 1; j <= i + continuousCharCount - 1; j++) {
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
	public static boolean isSequenceChar(String pwd, int continuousCharCount) {
		
		boolean isSame = false;
		
		byte[] b = pwd.getBytes();
		int p = pwd.length();

		if (continuousCharCount != 0 &&  p >= continuousCharCount) {
			// 연속된 3개의 문자 사용불가 (오름차순)
			
			log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ continuousCharCount = {}", continuousCharCount);
			if(continuousCharCount == 2) {
				for (int i = 0; i <= p - continuousCharCount; i++) {
					int b1 = b[i] + 1;
					int b2 = b[i + 1];
					log.info("@@@@@@@  b1 = {}, b2 = {}", b1, b2);
					if(b1 == b2) {
						return true;
					} else {
						continue;
					}
				}
			} else if(continuousCharCount == 3) {
				for (int i = 0; i <= p - continuousCharCount; i++) {
					
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
			} if(continuousCharCount == 4) {
				for (int i = 0; i <= p - continuousCharCount; i++) {
					
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
