package com.gaia3d;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.WebApplicationType;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.ApplicationPidFileWriter;

@SpringBootApplication
public class Mago3dConverterApplication {

	public static void main(String[] args) {
		SpringApplication.run(Mago3dConverterApplication.class, args);
		
//		SpringApplicationBuilder app = new SpringApplicationBuilder(Mago3dConverterApplication.class)
//				.web(WebApplicationType.NONE);
//		
//		app.build().addListeners(new ApplicationPidFileWriter("./bin/shutdown.pid"));
//		app.run();
	}
}
