package gaia3d.utils;

import java.io.File;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.uploaddata.UploadDirectoryType;
import lombok.extern.slf4j.Slf4j;

@Slf4j
class FilePathTest {

	@Autowired
	private PropertiesConfig propertiesConfig;

	@Test
	@Disabled
	void test() {
//		File file = Paths.get("/f4d/test", "aa").toFile();
//		System.out.println(file.getPath());
		
		String dataGroupPath = "basic/";
		
		String[] directors = dataGroupPath.split("/");
		String fullName = "C:\\data\\mago3d\\f4d\\";
		
		boolean result = true;
		for(String directoryName : directors) {
			fullName = fullName + directoryName + File.separator;
			File directory = new File(fullName);
			log.info("----------- fullName = {}", fullName);
		}
	}

	@Test
	void mkdirDatePatternTest() {
		String today = DateUtils.getToday(FormatUtils.YEAR_MONTH_DAY_TIME14);
		String makedDirectory = FileUtils.makeDirectory("admin", UploadDirectoryType.YEAR_MONTH,
				propertiesConfig.getDataConverterLogDir());
		log.info(">>>>>>>>>> today = {}", today);
		log.info(">>>>>>>>>> makedDirectory = {}", makedDirectory);
}

}