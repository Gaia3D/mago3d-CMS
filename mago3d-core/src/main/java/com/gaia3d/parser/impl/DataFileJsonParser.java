package com.gaia3d.parser.impl;

import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.FileParseLog;
import com.gaia3d.parser.DataFileParser;

public class DataFileJsonParser implements DataFileParser {

	@Override
	public Map<String, Object> parse(Long projectId, FileInfo fileInfo) {
		
		int totalCount = 0;
		int parseSuccessCount = 0;
		int parseErrorCount = 0;
		List<DataInfo> dataInfoList = new ArrayList<DataInfo>();
		
		FileParseLog fileParseLog = new FileParseLog();
		fileParseLog.setFile_info_id(fileInfo.getFile_info_id());
		fileParseLog.setLog_type(FileParseLog.FILE_PARSE_LOG);		
		
		try {
			byte[] jsonData = Files.readAllBytes(Paths.get(fileInfo.getFile_path() + fileInfo.getFile_real_name()));

			ObjectMapper objectMapper = new ObjectMapper();
			//read JSON like DOM Parser
			JsonNode jsonNode = objectMapper.readTree(jsonData);
			
			String dataName = jsonNode.path("data_name").asText();
			String dataKey = jsonNode.path("data_key").asText();
			String latitude = jsonNode.path("latitude").asText();
			String longitude = jsonNode.path("longitude").asText();
			String height = jsonNode.path("height").asText();
			String heading = jsonNode.path("heading").asText();
			String pitch = jsonNode.path("pitch").asText();
			String roll = jsonNode.path("roll").asText();
			JsonNode attributesNode = jsonNode.path("attributes");
			JsonNode childrenNode = jsonNode.path("children");
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setProject_id(projectId);
			dataInfo.setData_name(dataName);
			dataInfo.setData_key(dataKey);
			if(latitude != null && !"".equals(latitude)) dataInfo.setLatitude(new BigDecimal(latitude));
			if(longitude != null && !"".equals(longitude)) dataInfo.setLongitude(new BigDecimal(longitude));
			if(height != null && !"".equals(height)) dataInfo.setHeight(new BigDecimal(height));
			if(heading != null && !"".equals(heading)) dataInfo.setHeading(new BigDecimal(heading));
			if(pitch != null && !"".equals(pitch)) dataInfo.setPitch(new BigDecimal(pitch));
			if(roll != null && !"".equals(roll)) dataInfo.setRoll(new BigDecimal(roll));
			dataInfo.setAttributes(attributesNode.toString());
			dataInfo.setParent(0l);
			dataInfo.setDepth(1);
			dataInfo.setView_order(1);
			if(dataInfo.getLatitude() != null && dataInfo.getLatitude().floatValue() != 0f &&
					dataInfo.getLongitude() != null && dataInfo.getLongitude().floatValue() != 0f) {
				dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			}
			
			dataInfoList.add(dataInfo);
			
			if(childrenNode.isArray() && childrenNode.size() != 0) {
				dataInfoList.addAll(parseChildren(projectId, dataInfo.getData_key(),  null, dataInfo.getDepth(), childrenNode));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Data 일괄 등록 Json 파일 파싱 오류!");
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("dataInfoList", dataInfoList);
		result.put("totalCount", dataInfoList.size());
		result.put("parseSuccessCount", dataInfoList.size());
		result.put("parseErrorCount", 0);
		return result;
	}
	
	/**
	 * 자식 data 들을 재귀적으로 파싱
	 * @param projectId
	 * @param dataInfoList
	 * @param parentDataKey
	 * @param depth
	 * @param childrenNode
	 * @return
	 */
	private List<DataInfo> parseChildren(Long projectId, String parentDataKey, List<DataInfo> dataInfoList, int depth, JsonNode childrenNode) {
		if(dataInfoList == null) dataInfoList = new ArrayList<>();
		
		depth++;
		int viewOrder = 1;
		for(JsonNode jsonNode : childrenNode) {
			String dataName = jsonNode.path("data_name").asText();
			String dataKey = jsonNode.path("data_key").asText();
			String latitude = jsonNode.path("latitude").asText();
			String longitude = jsonNode.path("longitude").asText();
			String height = jsonNode.path("height").asText();
			String heading = jsonNode.path("heading").asText();
			String pitch = jsonNode.path("pitch").asText();
			String roll = jsonNode.path("roll").asText();
			JsonNode attributes = jsonNode.path("attributes");
			JsonNode childrene = jsonNode.path("children");
			
			DataInfo dataInfo = new DataInfo();
			dataInfo.setProject_id(projectId);
			dataInfo.setData_name(dataName);
			dataInfo.setData_key(dataKey);
			dataInfo.setParent_data_key(parentDataKey);
			if(latitude != null && !"".equals(latitude)) dataInfo.setLatitude(new BigDecimal(latitude));
			if(longitude != null && !"".equals(longitude)) dataInfo.setLongitude(new BigDecimal(longitude));
			if(height != null && !"".equals(height)) dataInfo.setHeight(new BigDecimal(height));
			if(heading != null && !"".equals(heading)) dataInfo.setHeading(new BigDecimal(heading));
			if(pitch != null && !"".equals(pitch)) dataInfo.setPitch(new BigDecimal(pitch));
			if(roll != null && !"".equals(roll)) dataInfo.setRoll(new BigDecimal(roll));
			dataInfo.setAttributes(attributes.toString());
			dataInfo.setDepth(depth);
			dataInfo.setView_order(viewOrder);
			if(dataInfo.getLatitude() != null && dataInfo.getLatitude().floatValue() != 0f &&
					dataInfo.getLongitude() != null && dataInfo.getLongitude().floatValue() != 0f) {
				dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
			}
			
			dataInfoList.add(dataInfo);
			
			if(childrene.isArray() && childrene.size() != 0) {
				parseChildren(projectId, dataInfo.getData_key(), dataInfoList, depth, childrene);
			}
			
			viewOrder++;
		}
		
		return dataInfoList;
	}
}
