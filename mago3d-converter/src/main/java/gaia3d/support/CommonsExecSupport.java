package gaia3d.support;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.exec.CommandLine;
import org.apache.commons.exec.DefaultExecuteResultHandler;
import org.apache.commons.exec.DefaultExecutor;
import org.apache.commons.exec.ExecuteException;
import org.apache.commons.exec.ExecuteWatchdog;
import org.apache.commons.exec.Executor;
import org.apache.commons.exec.PumpStreamHandler;

import lombok.extern.slf4j.Slf4j;

/**
 * @author jeongdae
 *
 */
@Slf4j
public class CommonsExecSupport {
	
	// http://www.baeldung.com/run-shell-command-in-java
	
	/**
	 * 단순 실행
	 * @param command
	 */
	public static Map<String, Object> execute(String command) {
		
		Boolean isSuccess = Boolean.FALSE;
		String errorCode = null;
		String message = null;
		Map<String, Object> result = new HashMap<>();
		
		Executor executor = new DefaultExecutor();
		executor.setExitValue(0);
		try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
			executor.setStreamHandler(new PumpStreamHandler(baos, baos));
			
			CommandLine cmdLine = new CommandLine(command);
			log.info("@@@@@@@ cmdLine = {}", cmdLine.toString());
			
			int exitValue = executor.execute(cmdLine);
			log.info("@@@@@@@ exitValue = {}", exitValue);
			
			message = baos.toString().trim();
			log.info("@@@@@@@ message = {}", message);
			boolean isFail = executor.isFailure(exitValue);
			log.info("@@@@@@@ execute flag = {}", !isFail);
			
			isSuccess = Boolean.TRUE;
		} catch(IllegalArgumentException e) {
			log.info("@@@@@@@ IllegalArgumentException errorCode = {}", e.getMessage());
		} catch(ExecuteException e) {
			log.info("@@@@@@@ executor.isFailure = {}", executor.isFailure(e.getExitValue()));
			log.info("@@@@@@@ ExecuteException errorCode = {}", e.getMessage());
		} catch(IOException e) {
			log.info("@@@@@@@ IOException errorCode = {}", e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@ Exception errorCode = {}", e.getMessage());
		}
		
		result.put("isSuccess", isSuccess);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
	
	/**
	 * 단순 실행
	 * @param command
	 */
	public static Map<String, Object> executeParam(String command, String param) {
		
		Boolean isSuccess = Boolean.FALSE;
		String errorCode = null;
		String message = null;
		Map<String, Object> result = new HashMap<>();
		
		Executor executor = new DefaultExecutor();
		executor.setExitValue(0);
		try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
			executor.setStreamHandler(new PumpStreamHandler(baos, baos));
			
			CommandLine cmdLine = new CommandLine(command);
			cmdLine.addArgument(param);
			log.info("@@@@@@@ cmdLine = {}", cmdLine.toString());
			
			int exitValue = executor.execute(cmdLine);
			log.info("@@@@@@@ exitValue = {}", exitValue);
			message = baos.toString().trim();
			log.info("@@@@@@@ message = {}", message);
			boolean isFail = executor.isFailure(exitValue);
			log.info("@@@@@@@ execute flag = {}", !isFail);
			
			isSuccess = Boolean.TRUE;
		} catch(IllegalArgumentException e) {
			log.info("@@@@@@@ IllegalArgumentException errorCode = {}", e.getMessage());
		} catch(ExecuteException e) {
			log.info("@@@@@@@ executor.isFailure = {}", executor.isFailure(e.getExitValue()));
			log.info("@@@@@@@ ExecuteException errorCode = {}", e.getMessage());
		} catch(IOException e) {
			log.info("@@@@@@@ IOException errorCode = {}", e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@ Exception errorCode = {}", e.getMessage());
		}
		
		result.put("isSuccess", isSuccess);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
	
	/**
	 * 단순 실행
	 * @param command
	 */
	public static Map<String, Object> executeParam(String command, String[] arrayParam) {
		
		Boolean isSuccess = Boolean.FALSE;
		String errorCode = null;
		String message = null;
		Map<String, Object> result = new HashMap<>();
		
		Executor executor = new DefaultExecutor();
		executor.setExitValue(0);
		try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
			
			executor.setStreamHandler(new PumpStreamHandler(baos, baos));
			CommandLine cmdLine = new CommandLine(command);
			for (String param : arrayParam) {
				cmdLine.addArgument(param);
			}
			log.info("@@@@@@ execute cmdLine = {}", cmdLine.toString());
			
			int exitValue = executor.execute(cmdLine);
			log.info("@@@@@@@ exitValue = {}", exitValue);
			message = baos.toString().trim();
			log.info("@@@@@@@ message = {}", message);
			boolean isFail = executor.isFailure(exitValue);
			log.info("@@@@@@@ execute flag = {}", !isFail);
			
			isSuccess = Boolean.TRUE;
		} catch(IllegalArgumentException e) {
			log.info("@@@@@@@ IllegalArgumentException errorCode = {}", e.getMessage());
		} catch(ExecuteException e) {
			log.info("@@@@@@@ executor.isFailure = {}", executor.isFailure(e.getExitValue()));
			log.info("@@@@@@@ ExecuteException errorCode = {}", e.getMessage());
		} catch(IOException e) {
			log.info("@@@@@@@ IOException errorCode = {}", e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@ Exception errorCode = {}", e.getMessage());
		}
		
		result.put("isSuccess", isSuccess);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
	
	/**
	 * 파라미터 포함
	 * @param command
	 */
	public static void execute(String command, String[] arrayParam) {
		
		Executor executor = new DefaultExecutor();
		executor.setExitValue(0);
		try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
			executor.setStreamHandler(new PumpStreamHandler(baos, baos));
			
			CommandLine cmdLine = new CommandLine(command);
			for (String param : arrayParam) {
				cmdLine.addArgument(param);
			}
			log.info("@@@@@@ execute cmdLine = {}", cmdLine.toString());
			
			int exitValue = executor.execute(cmdLine);
			log.info("@@@@@@@ exitValue = {}", exitValue);
			log.info("@@@@@@@ baos.toString() = {}", baos.toString().trim());
			boolean isFail = executor.isFailure(exitValue);
			log.info("@@@@@@@ execute flag = {}", !isFail);
			
		} catch(IllegalArgumentException e) {
			log.info("@@@@@@@ IllegalArgumentException errorCode = {}", e.getMessage());
		} catch(ExecuteException e) {
			log.info("@@@@@@@ executor.isFailure = {}", executor.isFailure(e.getExitValue()));
			log.info("@@@@@@@ ExecuteException errorCode = {}", e.getMessage());
		} catch(IOException e) {
			log.info("@@@@@@@ IOException errorCode = {}", e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@ Exception errorCode = {}", e.getMessage());
		}
	}
	
	/**
	 * 비동기
	 * @param command
	 */
	public Map<String, Object> executeAsync(String command) {
		
		Boolean isSuccess = Boolean.FALSE;
		String errorCode = null;
		String message = null;
		Map<String, Object> result = new HashMap<>();
		
		Executor executor = new DefaultExecutor();
		try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
			executor.setStreamHandler(new PumpStreamHandler(baos, baos));
			
			CommandLine cmdLine = new CommandLine(command);
			//cmdLine.addArgument("test");
			
			DefaultExecuteResultHandler resultHandler = new DefaultExecuteResultHandler();
			
			executor.execute(cmdLine, resultHandler);
			
			log.info("@@@@@@@ hasResult = {}", resultHandler.hasResult());
	        log.info("@@@@@@@ getException = {}", resultHandler.getException());
	        log.info("@@@@@@@ getExitValue = {}", resultHandler.getExitValue());
	        log.info("@@@@@@@ isFailure = {}", executor.isFailure(resultHandler.getExitValue()));
	        
	        message = baos.toString().trim();
	        log.info("@@@@@@@ message = {}", message);
	        isSuccess = Boolean.TRUE;
		} catch(IllegalArgumentException e) {
			log.info("@@@@@@@ IllegalArgumentException errorCode = {}", e.getMessage());
		} catch(ExecuteException e) {
			log.info("@@@@@@@ executor.isFailure = {}", executor.isFailure(e.getExitValue()));
			log.info("@@@@@@@ ExecuteException errorCode = {}", e.getMessage());
		} catch(IOException e) {
			log.info("@@@@@@@ IOException errorCode = {}", e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@ Exception errorCode = {}", e.getMessage());
		}
		
		result.put("isSuccess", isSuccess);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
	
	/**
	 * 비동기 6초 후에 죽이는 프로세스
	 * @param command
	 */
	public Map<String, Object> executeAsyncWithTimelyUserTermination(String command) {
		
		Boolean isSuccess = Boolean.FALSE;
		String errorCode = null;
		String message = null;
		Map<String, Object> result = new HashMap<>();
		
		Executor executor = new DefaultExecutor();
		try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
			executor.setStreamHandler(new PumpStreamHandler(baos, baos));
			
			CommandLine cmdLine = new CommandLine(command);
			//cmdLine.addArgument("test");
			
			ExecuteWatchdog watchdog = new ExecuteWatchdog(6000);
			executor.setWatchdog(watchdog);
			
			DefaultExecuteResultHandler resultHandler = new DefaultExecuteResultHandler();
			executor.execute(cmdLine, resultHandler);
			
			log.info("@@@@@@@ isWatching = {}", watchdog.isWatching());
			watchdog.destroyProcess();
			// wait until the result of the process execution is propagated
			resultHandler.waitFor(15000);
			
			log.info("@@@@@@@ watchdog.killedProcess() = {}", watchdog.killedProcess());
			log.info("@@@@@@@ isWatching = {}", watchdog.isWatching());
			log.info("@@@@@@@ hasResult = {}", resultHandler.hasResult());
	        log.info("@@@@@@@ getException = {}", resultHandler.getException());
	        log.info("@@@@@@@ isFailure = {}", executor.isFailure(resultHandler.getExitValue()));
	        
	        message = baos.toString().trim();
	        log.info("@@@@@@@ message = {}", message);
	        isSuccess = Boolean.TRUE;
		} catch(IllegalArgumentException e) {
			log.info("@@@@@@@ IllegalArgumentException errorCode = {}", e.getMessage());
		} catch(ExecuteException e) {
			log.info("@@@@@@@ executor.isFailure = {}", executor.isFailure(e.getExitValue()));
			log.info("@@@@@@@ ExecuteException errorCode = {}", e.getMessage());
		} catch(IOException e) {
			log.info("@@@@@@@ IOException errorCode = {}", e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@ Exception errorCode = {}", e.getMessage());
		}
		
		result.put("isSuccess", isSuccess);
		result.put("errorCode", errorCode);
		result.put("message", message);
		
		return result;
	}
}