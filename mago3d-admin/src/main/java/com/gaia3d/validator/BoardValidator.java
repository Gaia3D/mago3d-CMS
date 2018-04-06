package com.gaia3d.validator;

import com.gaia3d.domain.Board;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

/**
 * 게시판 Validation 체크
 * @author jeongdae
 *
 */
@Component("boardValidator")
public class BoardValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return (Board.class.isAssignableFrom(clazz));
	}

	@Override
	public void validate(Object target, Errors errors) {
		//Board board = (Board)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "field.required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "contents", "field.required");
		
	}
	
}
