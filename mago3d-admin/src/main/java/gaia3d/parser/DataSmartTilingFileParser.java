package gaia3d.parser;

import java.util.Map;

import gaia3d.domain.data.DataSmartTilingFileInfo;

/**
 * @author Cheon JeongDae
 *
 */
public interface DataSmartTilingFileParser {
	
	/**
	 *
	 * @param dataGroupId
	 * @param fileInfo
	 * @return
	 */
	Map<String, Object> parse(Integer dataGroupId, DataSmartTilingFileInfo fileInfo);
}
