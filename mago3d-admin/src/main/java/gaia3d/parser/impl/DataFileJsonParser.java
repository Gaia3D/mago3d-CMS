package gaia3d.parser.impl;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.util.StringUtils;

import gaia3d.domain.data.DataFileInfo;
import gaia3d.domain.data.DataGroup;
import gaia3d.domain.data.DataInfo;
import gaia3d.parser.DataFileParser;

public class DataFileJsonParser implements DataFileParser {

	@Override
	public Map<String, Object> parse(Integer dataGroupId, DataFileInfo fileInfo) {
		
		int totalCount = 0;
		int parseSuccessCount = 0;
		int parseErrorCount = 0;
		
		DataGroup dataGroup = new DataGroup();
		List<DataInfo> dataInfoList = new ArrayList<>();
		try {
			byte[] jsonData = Files.readAllBytes(Paths.get(fileInfo.getFilePath() + fileInfo.getFileRealName()));
			String encodingData = new String(jsonData, StandardCharsets.UTF_8);
			
			ObjectMapper objectMapper = new ObjectMapper();
			//read JSON like DOM Parser
			JsonNode jsonNode = objectMapper.readTree(encodingData);
			
//			String dataName = jsonNode.path("data_name").asText();
//			String dataKey = jsonNode.path("data_key").asText();
			String longitude = jsonNode.path("longitude").asText().trim();
			String latitude = jsonNode.path("latitude").asText().trim();
			String altitude = jsonNode.path("height").asText().trim();
			String mappingType = jsonNode.path("mappingType").asText();
			JsonNode metainfo = jsonNode.path("metainfo");
			JsonNode childrenNode = jsonNode.path("datas");
			
			dataGroup.setDataGroupId(dataGroupId);
//			dataGroup.setDataGroupName(dataName);
//			dataGroup.setDataGroupKey(dataKey);
			if(!StringUtils.isEmpty(longitude)) {
				longitude = longitude.replace("null", "");
				if(!StringUtils.isEmpty(longitude)) dataGroup.setLongitude(new BigDecimal(longitude));
			}
			if(!StringUtils.isEmpty(latitude)) {
				latitude = latitude.replace("null", "");
				if(!StringUtils.isEmpty(latitude)) dataGroup.setLatitude(new BigDecimal(latitude));
			}
			if(!StringUtils.isEmpty(altitude)) {
				altitude = altitude.replace("null", "");
				if(!StringUtils.isEmpty(altitude)) dataGroup.setAltitude(new BigDecimal(altitude));
			}
			if(dataGroup.getLongitude() != null && dataGroup.getLatitude() != null) {
				dataGroup.setLocation("POINT(" + dataGroup.getLongitude() + " " + dataGroup.getLatitude() + ")");
			}
			dataGroup.setDepth(1);
			dataGroup.setMetainfo(metainfo.toString());
			
			if(childrenNode.isArray() && childrenNode.size() != 0) {
				dataInfoList.addAll(parseChildren(null, 0, childrenNode));
			}
		} catch (IOException e) {
			throw new RuntimeException("Data 일괄 등록 Json 파일 파싱 오류! message = " + e.getMessage());
		}
		
		Map<String, Object> result = new HashMap<>();
		result.put("dataGroup", dataGroup);
		result.put("dataInfoList", dataInfoList);
		result.put("totalCount", dataInfoList.size());
		result.put("parseSuccessCount", dataInfoList.size());
		result.put("parseErrorCount", 0);
		return result;
	}
	
	/**
	 * 자식 data 들을 재귀적으로 파싱
	 * @param dataInfoList
	 * @param depth
	 * @param childrenNode
	 * @return
	 */
	private List<DataInfo> parseChildren(List<DataInfo> dataInfoList, int depth, JsonNode childrenNode) {
		if(dataInfoList == null) dataInfoList = new ArrayList<>();
		
		depth++;
		int viewOrder = 1;
		for(JsonNode jsonNode : childrenNode) {
			Long dataId = jsonNode.path("dataId").asLong();
			String dataName = jsonNode.path("dataName").asText();
			String dataKey = jsonNode.path("dataKey").asText();
			String longitude = jsonNode.path("longitude").asText().trim();
			String latitude = jsonNode.path("latitude").asText().trim();
			String altitude = jsonNode.path("altitude").asText().trim();
			String heading = jsonNode.path("heading").asText().trim();
			String pitch = jsonNode.path("pitch").asText().trim();
			String roll = jsonNode.path("roll").asText().trim();
			String mappingType = jsonNode.path("mappingType").asText();
			JsonNode metainfo = jsonNode.path("metainfo");
			JsonNode childrene = jsonNode.path("children");
			String label = jsonNode.path("label").asText();
			String labelTemplate = jsonNode.path("labelTemplate").asText();
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setDataId(dataId);
			dataInfo.setDataName(dataName);
			dataInfo.setDataKey(dataKey);
			if(!StringUtils.isEmpty(longitude)) dataInfo.setLongitude(new BigDecimal(longitude));
			if(!StringUtils.isEmpty(latitude)) dataInfo.setLatitude(new BigDecimal(latitude));
			if(!StringUtils.isEmpty(altitude)) dataInfo.setAltitude(new BigDecimal(altitude));
			if(dataInfo.getLongitude() != null && dataInfo.getLatitude() != null) {
				dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			}
			if(!StringUtils.isEmpty(heading)) dataInfo.setHeading(new BigDecimal(heading));
			if(!StringUtils.isEmpty(pitch)) dataInfo.setPitch(new BigDecimal(pitch));
			if(!StringUtils.isEmpty(roll)) dataInfo.setRoll(new BigDecimal(roll));
			
			dataInfo.setMappingType(mappingType);
			dataInfo.setMetainfo(metainfo.toString());
			dataInfo.setChildrenDepth(depth);
			dataInfo.setChildrenViewOrder(viewOrder);
			// TODO ancestor 같은것도 넣어 줘야 하는데..... 귀찮아서
			
			dataInfo.setLabel(label);
			dataInfo.setLabelTemplate(labelTemplate);

			dataInfoList.add(dataInfo);
			
			if(childrene.isArray() && childrene.size() != 0) {
				parseChildren(dataInfoList, depth, childrene);
			}
			
			viewOrder++;
		}
		
		return dataInfoList;
	}
}
