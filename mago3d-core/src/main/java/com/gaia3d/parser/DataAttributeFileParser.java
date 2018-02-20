package com.gaia3d.parser;

import java.util.Map;

import com.gaia3d.domain.FileInfo;

/**
 * @author Cheon JeongDae
 *
 */
public interface DataAttributeFileParser {
	
	/**
	 * parse
	 * @param dataId
	 * @param fileInfo
	 * @return
	 */
	Map<String, Object> parse(Long dataId, FileInfo fileInfo);
}
