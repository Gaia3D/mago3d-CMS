package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.gaia3d.domain.ObjectGroup;

/**
 * Object 그룹 등록, 수정 Validation 체크
 * @author jeongdae
 *
 */
@Component("objectGroupValidator")
public class ObjectGroupValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (ObjectGroup.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		//ObjectGroup objectGroup = (ObjectGroup)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "object_group_key", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "object_group_name", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "use_yn", "field.required");
	}
}
