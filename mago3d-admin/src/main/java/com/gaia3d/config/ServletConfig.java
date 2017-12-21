package com.gaia3d.config;

import java.util.Locale;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.Ordered;
import org.springframework.http.CacheControl;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.support.RequestDataValueProcessor;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.gaia3d.interceptor.CSRFHandlerInterceptor;
import com.gaia3d.interceptor.ConfigInterceptor;
import com.gaia3d.interceptor.LogInterceptor;
import com.gaia3d.interceptor.SecurityInterceptor;

import lombok.extern.slf4j.Slf4j;

/**
 * <mvc:annotation-driven> 대신 EnableWebMvc
 * 
 * @author Cheon JeongDae
 *
 */
//@EnableSwagger2
@Slf4j
@EnableWebMvc
@Configuration
@ComponentScan(basePackages = { "com.gaia3d.config, com.gaia3d.controller, com.gaia3d.interceptor, com.gaia3d.validator" }, includeFilters = {
		@Filter(type = FilterType.ANNOTATION, value = Component.class),
		@Filter(type = FilterType.ANNOTATION, value = Controller.class),
		@Filter(type = FilterType.ANNOTATION, value = RestController.class)})
public class ServletConfig extends WebMvcConfigurerAdapter {

	@Override
    public void addInterceptors(InterceptorRegistry registry) {
		log.info(" @@@ ServletConfig addInterceptors @@@@ ");
		
        registry.addInterceptor(new ConfigInterceptor())
        		.addPathPatterns("/**");
        registry.addInterceptor(logInterceptor())
        		.addPathPatterns("/**");
        registry.addInterceptor(new SecurityInterceptor())
        		.addPathPatterns("/**")
        		.excludePathPatterns("/login/**");
        registry.addInterceptor(new CSRFHandlerInterceptor())
        		.addPathPatterns("/**")
        		.excludePathPatterns("/login/**");
    }
	
	/**
	 * LogInterceptor 안에서 AcessLogService를 Autowired 하기 위해서
	 * @return
	 */
	@Bean
	public LogInterceptor logInterceptor() {
		return new LogInterceptor();
	}
	
	@Bean
	public LocaleResolver localeResolver() {
		SessionLocaleResolver sessionLocaleResolver = new SessionLocaleResolver();
		sessionLocaleResolver.setDefaultLocale(Locale.KOREA);
		return sessionLocaleResolver;
	}
//	
//	@Bean
//	public LocaleChangeInterceptor localeChangeInterceptor() {
//		LocaleChangeInterceptor lci = new LocaleChangeInterceptor();
//		lci.setParamName("lang");
//		return lci;
//	}

	@Bean
	public ReloadableResourceBundleMessageSource messageSource(){
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasename("classpath:/messages/messages");
		messageSource.setDefaultEncoding("UTF-8");
		//messageSource.setCacheSeconds(messagesCacheSeconds);
		return messageSource;
	}

	@Bean
	public MessageSourceAccessor getMessageSourceAccessor(){
		ReloadableResourceBundleMessageSource m = messageSource();
		return new MessageSourceAccessor(m);
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
				
		log.info(" @@@ ServletConfig addResourceHandlers @@@");
		registry.addResourceHandler("/css/**").addResourceLocations("/css/");
		registry.addResourceHandler("/externlib/**").addResourceLocations("/externlib/");
//		registry.addResourceHandler("/hompage/**").addResourceLocations("/homepage/");
		registry.addResourceHandler("/images/**").addResourceLocations("/images/");
		registry.addResourceHandler("/js/**").addResourceLocations("/js/");
		//registry.addResourceHandler("swagger-ui.html").addResourceLocations("classpath:/META-INF/resources/");
//		registry.addResourceHandler("/swagger-ui.html**").addResourceLocations("classpath:/META-INF/resources/swagger-ui.html");
//	    registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
	    //registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
		
//		if (!registry.hasMappingForPattern("/webjars/**")) {
//            registry.addResourceHandler("/webjars/**")
//                    .addResourceLocations("classpath:/resources/webjars/")
//                    .setCacheControl( CacheControl.maxAge(1, TimeUnit.HOURS).cachePublic() );
//        }
//        if (!registry.hasMappingForPattern("/**")) {
//            registry.addResourceHandler("/**")
//                    .addResourceLocations("classpath:/static")
//                    .setCacheControl( CacheControl.maxAge(0, TimeUnit.SECONDS).cachePublic());
//        }
	}
	
	@Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }
	
	@Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("forward:/index.jsp");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
        super.addViewControllers(registry);
    }

	@Bean
	public SimpleMappingExceptionResolver simpleMappingExceptionResolver() {
		log.info(" @@@ ServletConfig exceptionResolver @@@");
		
		SimpleMappingExceptionResolver simpleMappingExceptionResolver = new SimpleMappingExceptionResolver();
		
		Properties exceptionMappings = new Properties();
	 	exceptionMappings.put("BusinessLogicException", "error/business-error");
	 	exceptionMappings.put("RuntimeException", "error/runtime-error");
	 	exceptionMappings.put("Exception", "error/error");
	 	simpleMappingExceptionResolver.setExceptionMappings(exceptionMappings);
	 	
	 	Properties statusCodes = new Properties();
        statusCodes.put("error/error", "403");
        statusCodes.put("error/error", "404");
        statusCodes.put("error/error", "500");
        simpleMappingExceptionResolver.setStatusCodes(statusCodes);

	 	simpleMappingExceptionResolver.setOrder(1);
	 	simpleMappingExceptionResolver.setDefaultErrorView("error/error");
	 	
	 	return simpleMappingExceptionResolver;
	}
	
	@Bean
	@ConditionalOnMissingBean(InternalResourceViewResolver.class)
	public InternalResourceViewResolver viewResolver() {
		log.info(" @@@ ServletConfig viewResolver @@@");
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		viewResolver.setOrder(3);
		
		return viewResolver;
	}
	
	@Bean
	public RequestDataValueProcessor requestDataValueProcessor() {
		log.info(" @@@ ServletConfig requestDataValueProcessor @@@ ");
		return new CSRFRequestDataValueProcessor();
	}
	
//	/**
//     * Global CORS Configuration
//     */
//    @Override
//    public void addCorsMappings(CorsRegistry registry) {
//        // 간략설정
//        registry.addMapping("/**");
//
//        // 상세설정
//        registry.addMapping("/api/**").allowedOrigins("http://domain2.com")
//                .allowedMethods("PUT", "DELETE")
//                .allowedHeaders("header1", "header2", "header3")
//                .exposedHeaders("header1", "header2").allowCredentials(false)
//                .maxAge(3600);
//    }
	
//	@Bean
//	public Docket petApi() {
//		return new Docket(DocumentationType.SWAGGER_2)
//			.select()
//	        .apis(RequestHandlerSelectors.any())
//	        .paths(PathSelectors.any())
//	        .build()
//	        .pathMapping("/");
//	}
}
