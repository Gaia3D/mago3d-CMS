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
		
		log.info("@@@@@@@ command = {}", String.join(" ", command));
		log.info("--------------- start ----------------");
		
		ProcessBuilder processBuilder = new ProcessBuilder(command);
		processBuilder.inheritIO();
		Process process = processBuilder.start();
		int exitCode = process.waitFor();
		
		log.info("@@@@@@@ exitCode = {}", exitCode);
		log.info("--------------- end ----------------");
		
		return exitCode;
	}
	
//	public static int execute(List<String> command) throws Exception {
//		log.info("@@@@@@@ command = {}", command);
//		log.info("--------------- start ----------------");
//		
//		int exitCode = 0;
//		
//		ProcessBuilder processBuilder = new ProcessBuilder(command);
//		processBuilder.redirectErrorStream(true);
//		Process process = processBuilder.start();
//		try (	InputStream inputStream = process.getInputStream();
//				InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
//				BufferedReader bufferedReader = new BufferedReader(inputStreamReader);) {
//			
//			String readLine = null;
//			while((readLine = bufferedReader.readLine()) != null) {
//				log.info(readLine);
//			}
//			
//			exitCode = process.waitFor();
//		} catch (Exception e) {
//			exitCode = 999999;
//			e.printStackTrace();
//		}
//		
//		log.info("@@@@@@@ exitCode = {}", exitCode);
//		log.info("--------------- end ----------------");
//		return exitCode;
//	}
}
