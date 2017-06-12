package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.gaia3d.domain.ObjectInfo;
import com.gaia3d.helper.ValidationUtilsHelper;

/**
 * Object 등록, 수정 Validation 체크
 * @author jeongdae
 *
 */
@Component("objectValidator")
public class ObjectValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (ObjectInfo.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		ObjectInfo objectInfo = (ObjectInfo)target;
		
		if("insert".equals(objectInfo.getMethod_mode())) {
			ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "object_id", "field.required");
		}
			
		if(objectInfo.getObject_group_id() <= 0) {
			errors.rejectValue("object_group_id", "field.required", null, null);
		}
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "object_name", "field.required");
	}
}
