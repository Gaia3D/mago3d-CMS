package gaia3d;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class Mago3dTilerApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(Mago3dTilerApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(Mago3dTilerApplication.class);
	}
}
