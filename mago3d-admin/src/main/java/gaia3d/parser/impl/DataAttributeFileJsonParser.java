package gaia3d.parser.impl;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import gaia3d.domain.data.DataAttributeFileInfo;
import gaia3d.parser.DataAttributeFileParser;

public class DataAttributeFileJsonParser implements DataAttributeFileParser {

	@Override
	public Map<String, Object> parse(Long dataId, DataAttributeFileInfo dataAttributeFileInfo) {
		
		int parseSuccessCount = 0;
		int parseErrorCount = 0;
		String attribute = null;
		
		try {
			//byte[] jsonData = Files.readAllBytes(Paths.get(dataAttributeFileInfo.getFilePath() + dataAttributeFileInfo.getFileRealName()));
			attribute = new String(Files.readAllBytes(Paths.get(dataAttributeFileInfo.getFilePath() + dataAttributeFileInfo.getFileRealName())), StandardCharsets.UTF_8);
			parseSuccessCount++;
		} catch (IOException e) {
			parseErrorCount++;
			throw new RuntimeException("Data 속성 파일 파싱 오류! message = " + e.getMessage());
		}
		
		Map<String, Object> result = new HashMap<>();
		result.put("attribute", attribute);
		result.put("totalCount", 1);
		result.put("parseSuccessCount", parseSuccessCount);
		result.put("parseErrorCount", parseErrorCount);
		return result;
	}
}
