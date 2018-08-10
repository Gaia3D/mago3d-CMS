package com.gaia3d.helper;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

import lombok.extern.slf4j.Slf4j;

/**
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class ProcessBuilderHelper {

	public static void execute(List<String> command) {
		
		log.info("@@@@@@@ command = {}", command);
		log.info("--------------- start ----------------");
		
		ProcessBuilder processBuilder = new ProcessBuilder(command);
		processBuilder.redirectErrorStream(true);
		InputStream inputStream = null;
        InputStreamReader inputStreamReader = null;
        BufferedReader bufferedReader = null;
        
		try {
			Process process = processBuilder.start();
			
			inputStream = process.getInputStream();
			inputStreamReader = new InputStreamReader(inputStream);
			bufferedReader = new BufferedReader(inputStreamReader);
			
			String readLine = null;
			while((readLine = bufferedReader.readLine()) != null) {
				log.info(readLine);
			}
			
			process.waitFor();
			log.info("--------------- end ----------------");
			
			bufferedReader.close();
			inputStreamReader.close();
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bufferedReader != null) { try { bufferedReader.close(); } catch (Exception e) { e.printStackTrace(); } }
			if (inputStreamReader != null) { try { inputStreamReader.close(); } catch (Exception e) { e.printStackTrace(); } }
			if (inputStream != null) { try { inputStream.close(); } catch (Exception e) { e.printStackTrace(); } }
		}
	}
}
