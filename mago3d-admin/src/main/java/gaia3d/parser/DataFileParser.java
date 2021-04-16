package gaia3d.parser;

import java.util.Map;

import gaia3d.domain.data.DataFileInfo;

/**
 * @author Cheon JeongDae
 *
 */
public interface DataFileParser {
	
	/**
	 * @param dataGroupId
	 * @param fileInfo
	 * @return
	 */
	Map<String, Object> parse(Integer dataGroupId, DataFileInfo fileInfo);
}
