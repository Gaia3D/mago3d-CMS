package com.gaia3d.helper;

import java.util.regex.Pattern;

import org.apache.commons.validator.GenericTypeValidator;
import org.springframework.util.Assert;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;

public class ValidationUtilsHelper extends ValidationUtils {

	/**
	 * 정수값인지 확인
	 * @param errors
	 * @param field
	 * @param errorCode
	 * @param errorArgs
	 * @param defaultMessage
	 */
	public static void isInt(
			Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage) {
	
		Assert.notNull(errors, "Errors object must not be null");
		Object value = errors.getFieldValue(field);
		if (value == null || GenericTypeValidator.formatInt(value.toString()) == null) {
			errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
		}
	}
	
	/**
	 * 이메일 주소가 유효한지 확인
	 * @param errors
	 * @param field
	 * @param errorCode
	 * @param errorArgs
	 * @param defaultMessage
	 */
	public static void isEmail(
			Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage) {
	
		Assert.notNull(errors, "Errors object must not be null");
		Object value = errors.getFieldValue(field);
		if (value == null || GenericTypeValidator.formatInt(value.toString()) == null) {
			errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
		}
	}
	
	/**
	 * 최대 자리수 확인
	 * @param errors
	 * @param field
	 * @param errorCode
	 * @param errorArgs
	 * @param defaultMessage
	 */
	public static void maxLength(
			Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage) {
	
		Assert.notNull(errors, "Errors object must not be null");
		Object value = errors.getFieldValue(field);
		Integer maxLength = (Integer)errorArgs[0];
		if (value == null || (value.toString().length() > maxLength)) {
			errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
		}
	}
	
	/**
	 * 최대값 확인
	 * @param errors
	 * @param field
	 * @param errorCode
	 * @param errorArgs
	 * @param defaultMessage
	 */
	public static void maxValue(
			Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage) {
	
		Assert.notNull(errors, "Errors object must not be null");
		Object value = errors.getFieldValue(field);
		Integer maxValue = (Integer)errorArgs[0];
		if (value == null || (Integer.valueOf(value.toString()).intValue() > maxValue)) {
			errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
		}
	}
	
	/**
	 * 최소 자리수 확인
	 * @param errors
	 * @param field
	 * @param errorCode
	 * @param errorArgs
	 * @param defaultMessage
	 */
	public static void minLength(
			Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage) {
	
		Assert.notNull(errors, "Errors object must not be null");
		Object value = errors.getFieldValue(field);
		Integer minLength = (Integer)errorArgs[0];
		if (value == null || (value.toString().length() < minLength)) {
			errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
		}
	}
	
	/**
	 * 최소값 확인
	 * @param errors
	 * @param field
	 * @param errorCode
	 * @param errorArgs
	 * @param defaultMessage
	 */
	public static void minValue(
			Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage) {
	
		Assert.notNull(errors, "Errors object must not be null");
		Object value = errors.getFieldValue(field);
		Integer minValue = (Integer)errorArgs[0];
		if (value == null || (Integer.valueOf(value.toString()).intValue() < minValue)) {
			errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
		}
	}
	
	/**
	 * 범위값 확인
	 * @param errors
	 * @param field
	 * @param errorCode
	 * @param errorArgs
	 * @param defaultMessage
	 */
	public static void isInRange(
			Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage) {
	
		Assert.notNull(errors, "Errors object must not be null");
		Object value = errors.getFieldValue(field);
		Integer minLength = (Integer)errorArgs[0];
		Integer maxLength = (Integer)errorArgs[1];
		if (value == null || (value.toString().length() < minLength || value.toString().length() > maxLength)) {
			errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
		}
	}
	
	/**
     * V4 Ip Address 검증
     *
     * @param ipAddress
     * @return
     */
    public static void isIPAdressVersion4 (Errors errors, String field, String errorCode
    		, Object[] errorArgs, String defaultMessage) {
        /*String regExp = "([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})\\.([0-9]{1,3})";*/
    	String regExp = "^(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)(\\.(25[0-5]|2[0-4]\\d|[0-1]?\\d?\\d)){3}$";
        Object value = errors.getFieldValue(field);
        if (value == null || !Pattern.matches(regExp, (String) value)) {
        	errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
        }       
    }
    
    /**
     * IP V6 Address 검증
     * @param errors
     * @param field
     * @param errorCode
     * @param errorArgs
     * @param defaultMessage
     */
    public static void isIPAddressVersion6(Errors errors, String field, String errorCode
    		, Object[] errorArgs, String defaultMessage) {
    	String regExp = "[a-fA-F0-9]{4}:(:|([a-fA-F0-9]{1,4}:)){1,4}:?[a-fA-F0-9]{1,4}$";
    	/*(
    	([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|          # 1:2:3:4:5:6:7:8
    	([0-9a-fA-F]{1,4}:){1,7}:|                         # 1::                              1:2:3:4:5:6:7::
    	([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|         # 1::8             1:2:3:4:5:6::8  1:2:3:4:5:6::8
    	([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|  # 1::7:8           1:2:3:4:5::7:8  1:2:3:4:5::8
    	([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|  # 1::6:7:8         1:2:3:4::6:7:8  1:2:3:4::8
    	([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|  # 1::5:6:7:8       1:2:3::5:6:7:8  1:2:3::8
    	([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|  # 1::4:5:6:7:8     1:2::4:5:6:7:8  1:2::8
    	[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|       # 1::3:4:5:6:7:8   1::3:4:5:6:7:8  1::8  
    	:((:[0-9a-fA-F]{1,4}){1,7}|:)|                     # ::2:3:4:5:6:7:8  ::2:3:4:5:6:7:8 ::8       ::     
    	fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|     # fe80::7:8%eth0   fe80::7:8%1     (link-local IPv6 addresses with zone index)
    	::(ffff(:0{1,4}){0,1}:){0,1}
    	((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}
    	(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|          # ::255.255.255.255   ::ffff:255.255.255.255  ::ffff:0:255.255.255.255  (IPv4-mapped IPv6 addresses and IPv4-translated addresses)
    	([0-9a-fA-F]{1,4}:){1,4}:
    	((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}
    	(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])           # 2001:db8:3:4::192.0.2.33  64:ff9b::192.0.2.33 (IPv4-Embedded IPv6 Address)
    	)*/
    	Object value = errors.getFieldValue(field);
    	if (value == null || !Pattern.matches(regExp, (String) value)) {
    		errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
    	}
    }
    
    /**
     * 이메일 검증
     *
     * @param email
     * @return
     */
    public static void isEmailValid (
    		Errors errors, String field, String errorCode, Object[] errorArgs, String defaultMessage) {
        String regEx = "^([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\\.[0-9a-zA-Z_-]+){1,2}$";
        Object value = errors.getFieldValue(field);
        if (value == null || Pattern.matches(regEx, (String) value)) {
        	errors.rejectValue(field, errorCode, errorArgs, defaultMessage);
        }        
    }
}
