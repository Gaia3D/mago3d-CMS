package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.helper.ValidationUtilsHelper;

/**
 * Data 등록, 수정 Validation 체크
 * @author jeongdae
 *
 */
@Component("dataValidator")
public class DataValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (DataInfo.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		DataInfo dataInfo = (DataInfo)target;
		
		if("insert".equals(dataInfo.getMethod_mode())) {
			ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "data_id", "field.required");
		}
			
		if(dataInfo.getProject_id() <= 0) {
			errors.rejectValue("project_id", "field.required", null, null);
		}
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "data_name", "field.required");
	}
}
