package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.gaia3d.domain.Project;

/**
 * project 등록, 수정 Validation 체크
 * @author jeongdae
 *
 */
@Component("projectValidator")
public class ProjectValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (Project.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		//Project project = (Project)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "project_key", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "project_name", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "use_yn", "field.required");
	}
}
