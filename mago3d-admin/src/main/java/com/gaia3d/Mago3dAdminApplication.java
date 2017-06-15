package com.gaia3d;

import javax.servlet.http.HttpSessionBindingListener;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.web.filter.CharacterEncodingFilter;

import com.gaia3d.filter.XSSFilter;
import com.gaia3d.listener.Gaia3dHttpSessionBindingListener;

import lombok.extern.slf4j.Slf4j;

/**
 * springboot 시작
 * @author Cheon JeongDae
 *
 */
@Slf4j
@SpringBootApplication
public class Mago3dAdminApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(Mago3dAdminApplication.class, args);
	}
	
	@Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Mago3dAdminApplication.class);
    }
	
//	@Bean
//    public FilterRegistrationBean encodingFilter() {
//		FilterRegistrationBean registrationBean = new FilterRegistrationBean(new CharacterEncodingFilter());
//		registrationBean.addInitParameter("encoding", "utf-8");
//		registrationBean.addInitParameter("forceEncoding", "true");
//		registrationBean.addUrlPatterns("*.do");
//        return registrationBean;
//    }

    @Bean
    public FilterRegistrationBean xSSFilter() {
    	FilterRegistrationBean registrationBean = new FilterRegistrationBean(new XSSFilter());
		registrationBean.addUrlPatterns("*.do");
        return registrationBean;
    }
	
	@Bean
	public HttpSessionBindingListener httpSessionBindingListener() {
		log.info(" $$$ Mago3dAdminApplication registerListener $$$ ");
		return new Gaia3dHttpSessionBindingListener();
	}
}
