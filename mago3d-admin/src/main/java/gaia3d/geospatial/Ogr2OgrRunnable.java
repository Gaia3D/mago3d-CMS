package gaia3d.geospatial;

import java.util.ArrayList;
import java.util.List;

import lombok.extern.slf4j.Slf4j;
import gaia3d.support.ProcessBuilderSupport;

/**
 * ogr2ogr을 실행하여 shape 파일로 부터 layer를 생성하는 예제
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class Ogr2OgrRunnable implements Runnable {

	// os 종류(WINDOW, LINUX)
	private String osType;
	private String driver;
	private String shapeFile;
	private String tableName;
	// 새로 생성할건지, update 할건지, append 인지..... update가 upsert를 지원하는지 모르겠다.
	private String updateOption;
	private String environmentPath;
	
	public Ogr2OgrRunnable(String osType, String driver, String shapeFile, String tableName, String updateOption, String environmentPath) {
		this.osType = osType;
		this.driver = driver;
		this.shapeFile = shapeFile;
		this.tableName = tableName;
		this.updateOption = updateOption;
		this.environmentPath = environmentPath;
	}
	
	@Override
	public void run() {
		List<String> command = new ArrayList<>();
		command.add("ogr2ogr");
		command.add("--config");
		
		if("update".equals(this.updateOption)) {
			command.add("-overwrite");
		}
		
		command.add("SHAPE_ENCODING");
		if("WINDOW".equals(this.osType)) {
			command.add("CP949");
		} else {
			command.add("UTF-8");
		}
		
		command.add("-f");
		command.add("PostgreSQL");
		//command.add(this.driver);
		command.add("PG:host=localhost dbname=mago3d user=test password=test");
		
		// shape file full path 파일 호가장자 까지
		command.add(this.shapeFile);
		command.add("-nlt");
		command.add("PROMOTE_TO_MULTI");
		// schema 옵션이라서.... 현재는 빼고
//		command.add("-lco");
//		command.add("schema=");
		command.add("-nln");
		command.add(this.tableName);
		log.info(" >>>>>> command = {}", command.toString());
		
		try {
			ProcessBuilderSupport.execute(command, environmentPath);
		} catch(RuntimeException e) {
			log.info("@@@ RuntimeException. message = {}", e.getMessage());
		} catch (Exception e) {
			log.info("@@@ Exception. message = {}", e.getMessage());
		}
	}
}