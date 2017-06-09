package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.gaia3d.domain.UserInfo;
import com.gaia3d.helper.ValidationUtilsHelper;

/**
 * 사용자 등록, 수정 Validation 체크
 * @author jeongdae
 *
 */
@Component("userValidator")
public class UserValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (UserInfo.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		UserInfo userInfo = (UserInfo)target;
		
		if("insert".equals(userInfo.getMethod_mode())) {
			ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "user_id", "field.required");
		}
			
		if(userInfo.getUser_group_id() <= 0) {
			errors.rejectValue("user_group_id", "field.required", null, null);
		}
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "user_name", "field.required");
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "password", "field.required");
		
		// TODO 귀찮아서 임시 주석 처리
		// ValidationUtils.isInRange(errors, "password", "field.password.range", new Integer[] {8, 32}, null);
		
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "password_confirm", "field.required");
		if(!userInfo.getPassword().equals(userInfo.getPassword_confirm())) {
			errors.rejectValue("password", "field.user.password_confirm.invalid", null, null);
		}
		
		// TODO 
		// Password.validateUserPassword(ConfigCache.getPolicy(), userInfo);
		
		//ValidationUtils.rejectIfEmptyOrWhitespace(errors, "mobile_phone", "field.required");
	}
	
}
