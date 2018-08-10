package com.gaia3d.domain;

import java.util.ArrayList;
import java.util.List;

import com.gaia3d.helper.ProcessBuilderHelper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AMQPSubscribe {

	public void handleMessage(String message) {
		log.info("@@ Subscribe receive message >>> {}", message);
		String[] args = message.split("&");
		String[] jobArgs = args[2].split("=");
		
		Runnable connverterRun = () -> {
			List<String> command = new ArrayList<>();
			command.add("C:\\F4DConverterConsole\\F4DConverter.exe");
			command.add("#inputFolder");
			command.add("c:\\demo_f4d");
			command.add("#outputFolder");
			command.add("c:\\f4d\\workshop");
			command.add("#meshType");
			command.add("0");
			command.add("#log");
			command.add("c:\\demo_f4d\\logTest.txt");
			command.add("#indexing");
			command.add("y");
			
			ProcessBuilderHelper.execute(command);
		};
		
		new Thread(connverterRun, "F4D-Converter-Thread-" + jobArgs[1]).start();
	}
}
