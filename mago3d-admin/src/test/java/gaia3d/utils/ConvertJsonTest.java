package gaia3d.utils;

import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;

import org.junit.jupiter.api.Disabled;

import gaia3d.domain.data.DataInfo;
import gaia3d.domain.data.DataInfoLegacy;
import gaia3d.domain.data.DataInfoLegacyWrapper;
import gaia3d.support.LogMessageSupport;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class ConvertJsonTest {
	
	@Data
	@JsonIgnoreProperties(ignoreUnknown = true)
	static class SourceJSON {
		private List<DataInfo> datas;
		private String dataGroupKey;
	}
	
	@Disabled
	void test() {
		try {
			String filePath = "C:\\temp";
			//String fileName = "121.json";
			File dir = Paths.get(filePath).toFile();
			File[] files = dir.listFiles();
			
			for (File file : files) {
				if (!file.isDirectory()) {
					ObjectMapper objectMapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
					SourceJSON src = objectMapper.readValue(file, SourceJSON.class);
					DataInfoLegacyWrapper tgt = new DataInfoLegacyWrapper();
					List<DataInfoLegacy> childrens = new ArrayList<>();
					
					List<DataInfo> datas = src.getDatas();
					for (DataInfo info : datas) {
						DataInfoLegacy children = new DataInfoLegacy();
						children.setLatitude(info.getLatitude());
						children.setLongitude(info.getLongitude());
						children.setDataId(info.getDataId());
						children.setDataGroupId(info.getDataGroupId());
						children.setData_key(info.getDataKey());
						children.setData_name(info.getDataName());
						children.setMapping_type(info.getMappingType());
						children.setHeight(info.getAltitude());
						children.setHeading(info.getHeading());
						children.setPitch(info.getPitch());
						children.setRoll(info.getRoll());
						children.setAttributes(info.getMetainfo());
						childrens.add(children);
					}
					tgt.setChildren(childrens);
					String fileName = datas.get(0).getDataGroupId() + "_" + src.getDataGroupKey() + ".json"; 
					
					String result = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(tgt);
					
					File targetFile = Paths.get(filePath, fileName).toFile();
					objectMapper.writeValue(targetFile, tgt);
					
					log.info(result);
				}  
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("" + e);
		}
		
	}

	@Disabled
	void objectToJson() {
		ObjectMapper objectMapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);

		List<Map<String, Object>> attributes = new ArrayList<>();
		Map<String, Object> attribute = new HashMap<>();
		attribute.put("bldg:rooftype", "1000");
		attribute.put("gml:name", "Potsdamer Platz Nord");
		attributes.add(attribute);
		try {
			String attributesJsonString = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(attributes);
			log.info(">>>>>>>>>> attributesJsonString = {}", attributesJsonString);
		} catch (JsonProcessingException e) {
			LogMessageSupport.printMessage(e);
		}

	}

	@Disabled
	void JsonStringToObject() {

		String attributesJsonString = "[ {\n" +
				"  \"bldg:rooftype\" : \"1000\",\n" +
				"  \"gml:name\" : \"Potsdamer Platz Nord\"\n" +
				"} ]";

		ObjectMapper objectMapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
		try {
			List<Map<String, Object>> attributes = objectMapper.readValue(attributesJsonString, new TypeReference<>() {});
			attributes.forEach(item -> item.forEach((k, v) -> log.info("{} : {}", k, v)));
		} catch (JsonProcessingException e) {
			LogMessageSupport.printMessage(e);
		}

	}

}
