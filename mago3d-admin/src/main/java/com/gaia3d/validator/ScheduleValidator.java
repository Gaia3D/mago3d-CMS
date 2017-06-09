package com.gaia3d.validator;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.gaia3d.domain.Schedule;
import com.gaia3d.helper.ValidationUtilsHelper;

/**
 * 스케줄 등록, 수정 Validation 체크
 * @author jeongdae
 *
 */
@Component("scheduleValidator")
public class ScheduleValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (Schedule.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		Schedule schedule = (Schedule)target;
		
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "name", "field.required");
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "start_date", "field.required");
		ValidationUtilsHelper.rejectIfEmptyOrWhitespace(errors, "end_date", "field.required");
	}
	
}
