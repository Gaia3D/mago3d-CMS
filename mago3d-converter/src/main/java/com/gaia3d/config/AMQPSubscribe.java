package com.gaia3d.config;

import java.util.ArrayList;
import java.util.List;

import com.gaia3d.domain.QueueMessage;
import com.gaia3d.helper.ProcessBuilderHelper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AMQPSubscribe {
	private PropertiesConfig propertiesConfig;
	
	public AMQPSubscribe(PropertiesConfig propertiesConfig) {
		this.propertiesConfig = propertiesConfig;
	}
	
	public void handleMessage(QueueMessage queueMessage) {
		log.info("@@ Subscribe receive message");
		log.info("@@ queueMessage = {}", queueMessage);
		
		Runnable connverterRun = () -> {
			List<String> command = new ArrayList<>();
			command.add(propertiesConfig.getConverterDir());
			command.add("-inputFolder");
			command.add(queueMessage.getInput_folder());
			command.add("-outputFolder");
			command.add(queueMessage.getOutput_folder());
			command.add("-meshType");
			command.add(queueMessage.getMesh_type());
			command.add("-log");
			command.add(queueMessage.getLog_path());
			command.add("-indexing");
			command.add(queueMessage.getIndexing());
			
			log.info(" >>>>>> command = {}", command.toString());
			
			ProcessBuilderHelper.execute(command);
		};
		
		new Thread(connverterRun, "F4D-Converter-Thread-JobId=" + queueMessage.getConverter_job_id()).start();
	}
}
