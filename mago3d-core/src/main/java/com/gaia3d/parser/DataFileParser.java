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
	 * @return
	 */
	Map<String, Object> parse(Integer project_id, FileInfo fileInfo);
}
