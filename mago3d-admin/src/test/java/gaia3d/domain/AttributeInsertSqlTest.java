package gaia3d.domain;

import java.io.BufferedWriter;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.junit.jupiter.api.Disabled;

import lombok.extern.slf4j.Slf4j;

@Slf4j
class AttributeInsertSqlTest {

	String inputDirectory = "C:\\data\\mago3d\\smart-tiling-attribute";
	String insertSqlFile = "C:\\data\\mago3d\\sql\\insert.txt";
	String updateSqlFile = "C:\\data\\mago3d\\sql\\update.txt";
	
	@Disabled
	void test() throws Exception {
		File rootDirectory = new File(inputDirectory);
		if(!rootDirectory.isDirectory()) {
			throw new Exception("입력 디렉토리 오류");
		}
		
		try (	BufferedWriter insertBufferedWriter = Files.newBufferedWriter(Paths.get(insertSqlFile), StandardCharsets.UTF_8);
				BufferedWriter updateBufferedWriter = Files.newBufferedWriter(Paths.get(updateSqlFile), StandardCharsets.UTF_8); ) {
			File[] fileList = rootDirectory.listFiles();
			int i=1;
			for(File file : fileList) {
				if(file.getName().indexOf("F4D_")>=0) {
					String fileName = file.getName();
					String dataKey = fileName.substring(4, fileName.indexOf("_attributes.json"));
					log.info("---- i = {}, dataKey = {}", i, dataKey);
					
					Long dataId = getDataId(dataKey);
					String attribute = Files.readString(Paths.get(file.getAbsolutePath()));
					
					String insertSql = "INSERT INTO data_attribute (data_attribute_id, data_id, attributes) values ("
							+ "nextval('data_attribute_seq'), " + dataId + ", TO_JSON('" + attribute + "'::json));\n";
					
					insertBufferedWriter.write(insertSql);
					
					String updateSql = "update data_info set attribute_exist = true where data_id = " + dataId + ";\n";
					updateBufferedWriter.write(updateSql);
				}
				i++;
			}
        }
	}
	
	private Long getDataId(String dataKey) throws Exception {
		Long dataId = 0l;
		
		Class.forName("org.postgresql.Driver");
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/test", "test", "test");
			pstmt = conn.prepareStatement("select data_id from data_info WHERE data_key = ?");
			pstmt.setString(1, dataKey); 
			rs = pstmt.executeQuery();
			while (rs.next()) {
				dataId = rs.getLong("data_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) rs.close();
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();
		}
		
		if(dataId == 0l) {
			log.info(" ******************** error ********************* ");
			log.info(" --- dataKey = {}, dataId = {}", dataKey, dataId);
			log.info(" ******************** error ********************* ");
		}
		
		return dataId;
	}
}
