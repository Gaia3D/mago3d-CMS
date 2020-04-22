package mago3d.config;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;

import lombok.extern.slf4j.Slf4j;
import mago3d.domain.ConverterJob;
import mago3d.domain.ConverterJobStatus;
import mago3d.domain.QueueMessage;
import mago3d.domain.ServerTarget;
import mago3d.support.ProcessBuilderSupport;

@Slf4j
@Component
public class AMQPSubscribe {
	
	@Autowired
	private PropertiesConfig propertiesConfig;
	@Autowired
	private RestTemplate restTemplate;
	
	public void handleMessage(QueueMessage queueMessage) {
		Long converterJobId = queueMessage.getConverterJobId();
		log.info(" @@@@@@ handleMessage start. converterJobId = {}", converterJobId);
		
		Long converterJobFileId = queueMessage.getConverterJobFileId();
		String userId = queueMessage.getUserId();
		String serverTarget = queueMessage.getServerTarget();
		
		CompletableFuture.supplyAsync( () -> {
			List<String> command = new ArrayList<>();
			command.add(propertiesConfig.getConverterDir());
			command.add("#inputFolder");
			command.add(queueMessage.getInputFolder());
			command.add("#outputFolder");
			command.add(queueMessage.getOutputFolder());
			command.add("#meshType");
			command.add(queueMessage.getMeshType());
			if (!StringUtils.isEmpty(queueMessage.getSkinLevel())) {
				command.add("#skinLevel");
				command.add(queueMessage.getSkinLevel());
			}
			command.add("#log");
			command.add(queueMessage.getLogPath());
			command.add("#indexing");
			command.add(queueMessage.getIndexing());
			command.add("#usf");
			command.add(queueMessage.getUsf().toString());
			command.add("#isYAxisUp");
			command.add(queueMessage.getIsYAxisUp());
			
			log.info(" >>>>>> command = {}", command.toString());
			
			String result = ConverterJobStatus.SUCCESS.name();
			try {
				int exitCode = ProcessBuilderSupport.execute(command);
				
				if(exitCode == 0) result = ConverterJobStatus.SUCCESS.name().toLowerCase();
				else result = ConverterJobStatus.FAIL.name().toLowerCase();
			} catch(InterruptedException e1) {
				result = ConverterJobStatus.FAIL.name().toLowerCase();
				log.info(" InterruptedException exception = {}", e1.getMessage());	
			} catch(IOException e1) {
				result = ConverterJobStatus.FAIL.name().toLowerCase();
				log.info(" IOException exception = {}", e1.getMessage());
			} catch (Exception e1) {
				result = ConverterJobStatus.FAIL.name().toLowerCase();
				log.info(" Exception exception = {}", e1.getMessage());
			}
			return result;
        })
		.exceptionally(e -> {
        	log.info("exceptionally exception = {}", e.getMessage());
        	updateConverterJobStatus(userId, serverTarget, converterJobId, converterJobFileId, ConverterJobStatus.FAIL.name().toLowerCase(), e.getMessage());
        	return null;
        })
		// 앞의 비동기 작업의 결과를 받아 사용하며 return이 없다.
		.thenAccept(s -> {
			log.info("thenAccept result = {}", s);
			updateConverterJobStatus(userId, serverTarget, converterJobId, converterJobFileId, s, null);
			log.info("thenAccept end");
		});
	}
	
	/**
	 * 데이터 변환 job 상태 변경
	 * @param userId
	 * @param serverTarget
	 * @param converterJobId
	 * @param status
	 * @param errorCode
	 */
	private void updateConverterJobStatus(String userId, String serverTarget, Long converterJobId, Long converterJobFileId, String status, String errorCode) {
		log.info("@@ updateConverterJobStatus converterJobId = {}, status = {}, errorCode = {}", converterJobId, status, errorCode);
		ConverterJob converterJob = new ConverterJob();
		converterJob.setConverterJobFileId(converterJobFileId);
		converterJob.setUserId(userId);
		converterJob.setConverterJobId(converterJobId);
		converterJob.setStatus(status);
		converterJob.setErrorCode(errorCode);
		
		try {
			URI uri = null;
			if(ServerTarget.USER == ServerTarget.valueOf(serverTarget)) {
				uri = new URI(propertiesConfig.getCmsUserRestServer() + "/api/converters/status");
			} else {
				uri = new URI(propertiesConfig.getCmsAdminRestServer() + "/api/converters/status");
			}
			restTemplate.postForEntity(uri, converterJob, Map.class);
		} catch (URISyntaxException e) {
			log.info("데이터 converter 상태 변경 api 호출 실패 = {}", e.getMessage());
		}
	}
	
//	public void handleMessage2(QueueMessage queueMessage) {
//		log.info("@@ Subscribe receive message");
//		log.info("@@ queueMessage = {}", queueMessage);
//		
//		Runnable connverterRun = () -> {
//			List<String> command = new ArrayList<>();
//			command.add(propertiesConfig.getConverterDir());
//			command.add("-inputFolder");
//			command.add(queueMessage.getInputFolder());
//			command.add("-outputFolder");
//			command.add(queueMessage.getOutputFolder());
//			command.add("-meshType");
//			command.add(queueMessage.getMeshType());
//			command.add("-log");
//			command.add(queueMessage.getLogPath());
//			command.add("-indexing");
//			command.add(queueMessage.getIndexing());
//			
//			log.info(" >>>>>> command = {}", command.toString());
//			
//			ProcessBuilderSupport.execute(command);
//		};
//		
//		new Thread(connverterRun, "F4D-Converter-Thread-JobId=" + queueMessage.getConverterJobId()).start();
//	}
}
