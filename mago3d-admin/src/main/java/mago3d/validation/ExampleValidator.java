package mago3d.validation;

import org.springframework.context.MessageSource;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;

import lombok.extern.slf4j.Slf4j;
import mago3d.domain.UserInfo;

@Slf4j
@Component
public class ExampleValidator {

	public void validate(MessageSource messageSource, UserInfo userInfo, Errors errors) {
		
		log.info("userInfo = {}", userInfo);
		if(userInfo.getUserGroupId() == null ) {
//			errors.reject("cbiid", null, "test-----------");
//			errors.rejectValue("cbiid", "cbiid.require", messageSource.getMessage("cbiid.require", null, Locale.KOREAN));
			
			errors.reject("userGroupId", "[Global Error] 숫자만 입력 가능 합니다.");
			
			errors.rejectValue("userGroupId", "숫자만 입력 가능 합니다.");
		}
		
//		if(catalogInfoDto.getDatasetid().isEmpty()) {
//			errors.reject("datasetid", null, "test-----------");
//		}
			
		// ValidationUtils.rejectIfEmpty(errors, "name", "name.empty");
		
//		log.info(" ko = {}", messageSource.getMessage("test", null, Locale.GERMAN));
//    	log.info(" en = {}", messageSource.getMessage("test", null, Locale.ENGLISH));
		// TODO 날짜나 비지니스 로직 검사
	}
}
