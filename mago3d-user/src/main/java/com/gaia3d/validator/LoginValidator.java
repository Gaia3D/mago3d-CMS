package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.gaia3d.domain.UserInfo;

/**
 * 로그인 Validation 체크
 * @author jeongdae
 *
 */
@Component("loginValidator")
public class LoginValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (UserInfo.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "user_id", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "password", "field.required");
	}
}
