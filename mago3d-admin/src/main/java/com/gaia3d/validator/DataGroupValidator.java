package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.gaia3d.domain.DataGroup;

/**
 * Data 그룹 등록, 수정 Validation 체크
 * @author jeongdae
 *
 */
@Component("dataGroupValidator")
public class DataGroupValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (DataGroup.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		//DataGroup dataGroup = (DataGroup)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "data_group_key", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "data_group_name", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "use_yn", "field.required");
	}
}
