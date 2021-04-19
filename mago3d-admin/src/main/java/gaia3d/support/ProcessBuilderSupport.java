package gaia3d.support;

import java.util.List;

import lombok.extern.slf4j.Slf4j;

/**
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class ProcessBuilderSupport {

	public static void execute(List<String> command, String path) throws Exception {
		
		log.info("---------- start ----------");
		log.info("@@@@@@@ command = {}", command);
		
		ProcessBuilder processBuilder = new ProcessBuilder(command);
		processBuilder.inheritIO();
		Process process = processBuilder.start();
		int exitCode = process.waitFor();
		log.info("@@@@@@@ exitCode = {}", exitCode);
		log.info("--------------- end ----------------");
		// Bug Fix : Potential Command Injection
		
		// 참고 : https://cheatsheetseries.owasp.org/cheatsheets/OS_Command_Injection_Defense_Cheat_Sheet.html
//		Map<String, String> env = processBuilder.environment();
		
//		log.info("@@@@@@@ path = {}", env.get(path));
//		if (env.get(path) != null && !env.get(path).isEmpty()) {
//			processBuilder.directory(new File(FilenameUtils.getName(env.get(path))));
//		}
		
//		processBuilder.redirectErrorStream(true);
//		InputStream inputStream = null;
//        InputStreamReader inputStreamReader = null;
//        BufferedReader bufferedReader = null;
        
//		try {
//			Process process = processBuilder.start();
//			
//			inputStream = process.getInputStream();
//			inputStreamReader = new InputStreamReader(inputStream);
//			bufferedReader = new BufferedReader(inputStreamReader);
//			
//			String readLine = null;
//			while((readLine = bufferedReader.readLine()) != null) {
//				log.info(readLine);
////				if(readLine.indexOf("ERROR") >= 0 || readLine.indexOf("FAILURE") >= 0) {
////					throw new RuntimeException("ProcessBuilderHelper readLine Error. " + readLine);
////				}
//			}
//			
//			process.waitFor();
//			log.info("---------- end ----------");
//			
//			bufferedReader.close();
//			inputStreamReader.close();
//			inputStream.close();
//		} catch (IOException e) {
//			throw new RuntimeException("IOException. " + e.getMessage());
//		} catch (Exception e) {
//			throw new RuntimeException("Exception. " + e.getMessage());
//		} finally {
//			if (bufferedReader != null) { try { bufferedReader.close(); } catch (IOException e) { log.info("@@ IOException. message = {}", e.getMessage()); } }
//			if (inputStreamReader != null) { try { inputStreamReader.close(); } catch (IOException e) { log.info("@@ IOException. message = {}", e.getMessage()); } }
//			if (inputStream != null) { try { inputStream.close(); } catch (IOException e) { log.info("@@ IOException. message = {}", e.getMessage()); } }
//		}
	}
}
