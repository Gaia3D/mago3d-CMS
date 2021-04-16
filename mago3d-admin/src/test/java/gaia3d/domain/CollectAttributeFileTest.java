package gaia3d.domain;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

import org.junit.jupiter.api.Disabled;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class CollectAttributeFileTest {

	String inputDirectory = "C:\\data\\xx";
	String outDirectory = "C:\\data\\mago3d\\smart-tiling-attribute";
	
	@Disabled
	void test() throws Exception {
		File rootDirectory = new File(inputDirectory);
		if(!rootDirectory.isDirectory()) {
			throw new Exception("입력 디렉토리 오류");
		}
		
		File[] groups = rootDirectory.listFiles();
		for(File groupFile : groups) {
			File[] fileList = groupFile.listFiles();
			String groupName = groupFile.getName();
			for(File file : fileList) {
				log.info("--- file name = {}", file.getName());
				if(file.isDirectory() && file.getName().indexOf("F4D_")>=0) {
					log.info("**** target file name = {}", file.getName());
					moveAttribute(groupName, file);
				}
			}
		}
	}
	
	private void moveAttribute(String groupName, File file) throws IOException {
		String directoryName = file.getName();
		String subPath = File.separator + groupName + File.separator + file.getName() + File.separator;
		
		File[] childFileList = file.listFiles();
		for(File childFile : childFileList) {
			if(childFile.isFile() && childFile.getName().equals("attributes.json")) {
				Files.copy(new File(inputDirectory + subPath + File.separator + childFile.getName()).toPath(), 
						new File(outDirectory + File.separator + directoryName + "_" +childFile.getName()).toPath());
			}
		}
	}
}
