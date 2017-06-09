package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.gaia3d.domain.UserGroup;

/**
 * 사용자 그룹 등록, 수정 Validation 체크
 * @author jeongdae
 *
 */
@Component("userGroupValidator")
public class UserGroupValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (UserGroup.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		//UserGroup userGroup = (UserGroup)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "group_key", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "level", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "use_yn", "field.required");
		
	}
	
}
