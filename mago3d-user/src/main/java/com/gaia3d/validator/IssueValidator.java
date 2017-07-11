package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.gaia3d.domain.Issue;

/**
 * Issue Validation 체크
 * @author jeongdae
 *
 */
@Component("issueValidator")
public class IssueValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (Issue.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "contents", "field.required");
		
	}
}
