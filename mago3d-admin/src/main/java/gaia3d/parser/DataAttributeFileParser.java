package gaia3d.parser;

import java.util.Map;

import gaia3d.domain.DataAttributeFileInfo;

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
	Map<String, Object> parse(Long dataId, DataAttributeFileInfo dataAttributeFileInfo);
}
