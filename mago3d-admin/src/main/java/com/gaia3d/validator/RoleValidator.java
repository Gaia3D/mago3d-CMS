package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.gaia3d.domain.Role;
import com.gaia3d.helper.ValidationUtilsHelper;

/**
 * Role Validation 체크
 * @author jeongdae
 *
 */
@Component("roleValidator")
public class RoleValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (Role.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "role_name", "field.required");
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "role_key", "field.required");
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "role_type", "field.required");
	}
}
