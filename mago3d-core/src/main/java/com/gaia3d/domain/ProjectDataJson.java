package com.gaia3d.domain;

import java.util.List;

import org.slf4j.Logger;

/**
 * TODO 이건 시간이 없어서 임시로.... 맘에 안들어....
 * @author Cheon JeongDae
 *
 */
public class ProjectDataJson {

public static String getProjectDataJson(Logger log, Integer projectId, List<DataInfo> dataInfoList) {
		
		if(dataInfoList == null || dataInfoList.isEmpty()) return null;
		
		StringBuffer buffer = new StringBuffer();
		
		int dataInfoCount = dataInfoList.size();
		int preDepth = 0;
		int brackets = 0;
		for(int i = 0; i < dataInfoCount; i++) {
			DataInfo dataInfo = dataInfoList.get(i);
			
			// 자식들 정보
			if(preDepth < dataInfo.getDepth()) {
				// 시작
				buffer.append("{");
				// location 정보 및 attributes
				buffer = getLocationAndAttributes(buffer, dataInfo);
				// 자식 노드
				buffer.append("\"children\"").append(":").append("[");
				brackets++;
			} else if(preDepth == dataInfo.getDepth()) {
				// 형제 노드, 닫는 처리
				buffer.append("]");
				buffer.append("}");
				
				buffer.append(",");
				buffer.append("{");
				// location 정보 및 attributes
				buffer = getLocationAndAttributes(buffer, dataInfo);
				// 자식 노드
				buffer.append("\"children\"").append(":").append("[");
			} else {
				// 종료, 닫는처리
				int closeCount = preDepth - dataInfo.getDepth();
				for(int j=0; j<=closeCount; j++) {
					buffer.append("]");
					buffer.append("}");
					brackets--;
				}
				
				buffer.append(",");
				buffer.append("{");
				// location 정보 및 attributes
				buffer = getLocationAndAttributes(buffer, dataInfo);
				// 자식 노드
				buffer.append("\"children\"").append(":").append("[");
			}
				
			if(dataInfoCount == (i+1)) {
				// 맨 마지막의 경우 괄호를 닫음
				for(int k=0; k<brackets; k++) {
					buffer.append("]");
					buffer.append("}");
				}
			}
			
			preDepth = dataInfo.getDepth();
		}
		
		log.info(" ************** project_id = {} json file **********", projectId);
		log.info(" ========= {} ", buffer.toString());
		return buffer.toString();
	}
	
	private static StringBuffer getLocationAndAttributes(StringBuffer buffer, DataInfo dataInfo) {
		buffer.append("\"data_id\"").append(":").append("\"").append(dataInfo.getData_id()).append("\"").append(",");
		buffer.append("\"data_key\"").append(":").append("\"").append(dataInfo.getData_key()).append("\"").append(",");
		buffer.append("\"data_name\"").append(":").append("\"").append(dataInfo.getData_name()).append("\"").append(",");
		buffer.append("\"parent\"").append(":").append(dataInfo.getParent()).append(",");
		buffer.append("\"depth\"").append(":").append(dataInfo.getDepth()).append(",");
		buffer.append("\"view_order\"").append(":").append(dataInfo.getView_order()).append(",");
		if(dataInfo.getMapping_type() != null) buffer.append("\"mapping_type\"").append(":").append("\"").append(dataInfo.getMapping_type()).append("\"").append(",");
		if(dataInfo.getLatitude() != null) buffer.append("\"latitude\"").append(":").append(dataInfo.getLatitude()).append(",");
		if(dataInfo.getLongitude() != null) buffer.append("\"longitude\"").append(":").append(dataInfo.getLongitude()).append(",");
		if(dataInfo.getHeight() != null) buffer.append("\"height\"").append(":").append(dataInfo.getHeight()).append(",");
		if(dataInfo.getHeading() != null) buffer.append("\"heading\"").append(":").append(dataInfo.getHeading()).append(",");
		if(dataInfo.getPitch() != null) buffer.append("\"pitch\"").append(":").append(dataInfo.getPitch()).append(",");
		if(dataInfo.getRoll() != null) buffer.append("\"roll\"").append(":").append(dataInfo.getRoll()).append(",");
		buffer.append("\"attributes\"").append(":").append(dataInfo.getAttributes()).append(",");
		
		return buffer;
	}
}
