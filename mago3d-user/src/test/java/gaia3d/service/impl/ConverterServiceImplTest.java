package gaia3d.service.impl;

import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.junit.jupiter.api.Test;

import gaia3d.domain.data.DataInfo;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class ConverterServiceImplTest {

	@Test
	void test() throws Exception {
		// lonsLats.json
		
		String targetDirectory = "C:\\data\\mago3d\\f4d\\service\\" + "admin" + File.separator;
		targetDirectory += "basic" + File.separator + DataInfo.F4D_PREFIX + "admin_20200317181545_364404888477400";
		//File file = new File(targetDirectory + File.separator + "lonsLats.json");
			
		byte[] jsonData = Files.readAllBytes(Paths.get(targetDirectory + File.separator + "lonsLats.json"));
		String encodingData = new String(jsonData, StandardCharsets.UTF_8);
			
		ObjectMapper objectMapper = new ObjectMapper();
		//read JSON like DOM Parser
		JsonNode jsonNode = objectMapper.readTree(encodingData);
		
		String dataKey = jsonNode.path("data_key").asText();
		String longitude = jsonNode.path("longitude").asText().trim();
		String latitude = jsonNode.path("latitude").asText().trim();
		
		log.info("@@@@@@@@@@ dataKey = {}", dataKey);
		log.info("@@@@@@@@@@ longitude = {}", longitude);
		log.info("@@@@@@@@@@ latitude = {}", latitude);
	}
}
