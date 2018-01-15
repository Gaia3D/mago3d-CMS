package com.gaia3d.parser;

import java.util.Map;

import com.gaia3d.domain.FileInfo;

/**
 * @author Cheon JeongDae
 *
 */
public interface DataFileParser {
	
	/**
	 * parse
	 * @param project_id
	 * @param fileInfo
	 * @param userId
	 * @return
	 */
	Map<String, Object> parse(Long project_id, FileInfo fileInfo,  String userId);
}
