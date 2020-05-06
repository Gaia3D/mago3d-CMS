package gaia3d.support;

import java.util.List;

import lombok.extern.slf4j.Slf4j;

/**
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class ProcessBuilderSupport {

	public static int execute(List<String> command) throws Exception {
		
		log.info("@@@@@@@ command = {}", command);
		log.info("--------------- start ----------------");
		
		ProcessBuilder processBuilder = new ProcessBuilder(command);
		processBuilder.inheritIO();
		Process process = processBuilder.start();
//		try(	InputStream inputStream = process.getInputStream();
//				InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
//				BufferedReader bufferedReader = new BufferedReader(inputStreamReader) ) {
//			
//			String readLine = null;
//			while((readLine = bufferedReader.readLine()) != null) {
//				log.info(readLine);
//			}
//			
//			process.waitFor();
//			log.info("--------------- end ----------------");
//		} catch (IOException e) {
//			e.printStackTrace();
//			throw new RuntimeException(e.getMessage());
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw new RuntimeException(e.getMessage());
//		}
		
		int exitCode = process.waitFor();
		log.info("@@@@@@@ exitCode = {}", exitCode);
		log.info("--------------- end ----------------");
		
		return exitCode;
	}
}
