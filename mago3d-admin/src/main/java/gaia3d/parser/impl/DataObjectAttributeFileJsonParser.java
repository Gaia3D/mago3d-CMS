package gaia3d.parser.impl;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

import gaia3d.domain.data.DataObjectAttributeFileInfo;
import gaia3d.parser.DataObjectAttributeFileParser;

public class DataObjectAttributeFileJsonParser implements DataObjectAttributeFileParser {

	@Override
	public Map<String, Object> parse(Long dataId, DataObjectAttributeFileInfo dataObjectAttributeFileInfo) {
		
		int parseSuccessCount = 0;
		int parseErrorCount = 0;
		String attribute = null;
		
		try {
			//byte[] jsonData = Files.readAllBytes(Paths.get(dataObjectAttributeFileInfo.getFilePath() + dataObjectAttributeFileInfo.getFileRealName()));
			attribute = new String(Files.readAllBytes(Paths.get(dataObjectAttributeFileInfo.getFilePath() + dataObjectAttributeFileInfo.getFileRealName())), StandardCharsets.UTF_8);
			parseSuccessCount++;
		} catch (Exception e) {
			parseErrorCount++;
			throw new RuntimeException("Data Object 속성 파일 파싱 오류! message = " + e.getMessage());
		}
		
		Map<String, Object> result = new HashMap<>();
		result.put("attribute", attribute);
		result.put("totalCount", 1);
		result.put("parseSuccessCount", parseSuccessCount);
		result.put("parseErrorCount", parseErrorCount);
		return result;
	}
}
