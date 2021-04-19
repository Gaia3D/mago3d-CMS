package gaia3d;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.context.ApplicationPidFileWriter;

@SpringBootApplication(exclude={DataSourceAutoConfiguration.class})
public class Mago3dConverterApplication {

	public static void main(String[] args) {
		SpringApplication application = new SpringApplication(Mago3dConverterApplication.class);
		application.addListeners(new ApplicationPidFileWriter("./bin/app.pid"));
		application.run(args);
	}
}
