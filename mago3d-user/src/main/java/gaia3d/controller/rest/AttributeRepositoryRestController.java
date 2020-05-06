package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import gaia3d.service.AttributeRepositoryService;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("/attribute-repository")
public class AttributeRepositoryRestController {
	
	private final AttributeRepositoryService attributeRepositoryService;
	
	@GetMapping("/{dataKey}")
	public Map<String, Object> detail(HttpServletRequest request, @PathVariable String dataKey) {
		
		log.info("@@@@@@@@ dataKey = {}", dataKey);
		
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;
		int statusCode = HttpStatus.OK.value();
		
		// 01_mj_b_00218
		//String[] divideDataKey = dataKey.split("_");
		//String buildName = divideDataKey[0] + "_" + divideDataKey[3].substring(2);
		result.put("attributeRepository", attributeRepositoryService.getDataAttribute(dataKey));
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

}
