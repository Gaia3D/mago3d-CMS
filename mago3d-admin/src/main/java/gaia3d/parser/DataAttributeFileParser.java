package gaia3d.parser;

import java.util.Map;

import gaia3d.domain.data.DataAttributeFileInfo;

/**
 * @author Cheon JeongDae
 *
 */
public interface DataAttributeFileParser {
	
	/**
	 *
	 * @param dataId
	 * @param dataAttributeFileInfo
	 * @return
	 */
	Map<String, Object> parse(Long dataId, DataAttributeFileInfo dataAttributeFileInfo);
}
