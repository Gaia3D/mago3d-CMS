package com.gaia3d.config;

import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.core.Ordered;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.support.RequestDataValueProcessor;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.gaia3d.interceptor.CSRFHandlerInterceptor;
import com.gaia3d.interceptor.ConfigInterceptor;
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
public class ServletConfig implements WebMvcConfigurer {
	
	@Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }
	
	@Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("forward:/index.jsp");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
    }

	@Override
    public void addInterceptors(InterceptorRegistry registry) {
		log.info(" @@@ ServletConfig addInterceptors @@@@ ");
		registry.addInterceptor(new ConfigInterceptor())
        		.addPathPatterns("/**")
        		.excludePathPatterns("/css/**", "/externlib/**", "/f4d/**", "/images/**", "/js/**");
        registry.addInterceptor(new SecurityInterceptor())
        		.addPathPatterns("/**")
        		.excludePathPatterns("/login/**", "/css/**", "/externlib/**", "/f4d/**", "/images/**", "/js/**");
        registry.addInterceptor(new CSRFHandlerInterceptor())
        		.addPathPatterns("/**")
        		.excludePathPatterns("/login/**", "/css/**", "/externlib/**", "/f4d/**", "/images/**", "/js/**");
    }
	
	@Bean
	public LocaleResolver localeResolver() {
		SessionLocaleResolver sessionLocaleResolver = new SessionLocaleResolver();
		//sessionLocaleResolver.setDefaultLocale(Locale.KOREA);
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
		ReloadableResourceBundleMessageSource messageSourceAccessor = messageSource();
		return new MessageSourceAccessor(messageSourceAccessor);
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		log.info(" @@@ ServletConfig addResourceHandlers @@@");
		registry.addResourceHandler("/css/**").addResourceLocations("/css/");
		registry.addResourceHandler("/externlib/**").addResourceLocations("/externlib/");
//		registry.addResourceHandler("/hompage/**").addResourceLocations("/homepage/");
		registry.addResourceHandler("/images/**").addResourceLocations("/images/");
		registry.addResourceHandler("/js/**").addResourceLocations("/js/");
	}
	
//	@Bean
//	public SimpleMappingExceptionResolver simpleMappingExceptionResolver() {
//		log.info(" @@@ ServletConfig exceptionResolver @@@");
//		
//		SimpleMappingExceptionResolver simpleMappingExceptionResolver = new SimpleMappingExceptionResolver();
//		
//		Properties exceptionMappings = new Properties();
//	 	exceptionMappings.put("BusinessLogicException", "/error/business-error");
//	 	exceptionMappings.put("RuntimeException", "/error/runtime-error");
//	 	exceptionMappings.put("Exception", "/error/error");
//	 	simpleMappingExceptionResolver.setExceptionMappings(exceptionMappings);
//	 	
//	 	Properties statusCodes = new Properties();
//        statusCodes.put("/error/error", "403");
//        statusCodes.put("/error/error", "404");
//        statusCodes.put("/error/error", "500");
//        simpleMappingExceptionResolver.setStatusCodes(statusCodes);
//
//	 	simpleMappingExceptionResolver.setOrder(1);
//	 	simpleMappingExceptionResolver.setDefaultErrorView("/error/error");
//	 	
//	 	return simpleMappingExceptionResolver;
//	}
	
	@Bean
	@ConditionalOnMissingBean(InternalResourceViewResolver.class)
	public InternalResourceViewResolver viewResolver() {
		log.info(" @@@ ServletConfig viewResolver @@@");
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/views");
		viewResolver.setSuffix(".jsp");
		viewResolver.setOrder(3);
		
		return viewResolver;
	}
	
	@Bean
	public RequestDataValueProcessor requestDataValueProcessor() {
		log.info(" @@@ ServletConfig requestDataValueProcessor @@@ ");
		return new CSRFRequestDataValueProcessor();
	}
}
