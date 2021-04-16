package gaia3d.config;

import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.time.Duration;

import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import lombok.extern.slf4j.Slf4j;

/**
 * 
 * @author Cheon JeongDae
 *
 */
@Slf4j
@EnableWebMvc
@Configuration
@ComponentScan(basePackages = { "gaia3d.config" }, includeFilters = {
		@Filter(type = FilterType.ANNOTATION, value = Component.class),
		@Filter(type = FilterType.ANNOTATION, value = Controller.class),
		@Filter(type = FilterType.ANNOTATION, value = RestController.class)})
public class ServletConfig implements WebMvcConfigurer {
	
	@Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }
	
	/**
	 * TODO rest-template-mode 값으로 결정 하는게 아니라 request.isSecure 로 http, https 를 판별해서 결정 해야 하는데....
	 *      그럴경우 bean 설정이 아니라.... 개별 코드에서 판별을 해야 함 ㅠ.ㅠ
	 * @return
	 * @throws KeyStoreException
	 * @throws NoSuchAlgorithmException
	 * @throws KeyManagementException
	 */
	@Bean
    public RestTemplate restTemplate() {
		// TODO user 나 admin을 참조 하세요. 여기는 sample 로 해 둔거임
		
    	RestTemplateBuilder builder = new RestTemplateBuilder();
    	RestTemplate restTemplate = builder.
    					setConnectTimeout(Duration.ofMillis(10000))
	            		.setReadTimeout(Duration.ofMillis(10000))
	            		.build();
    	
    	return restTemplate;
    }
}
