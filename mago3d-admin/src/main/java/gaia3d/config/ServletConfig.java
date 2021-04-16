package gaia3d.config;

import gaia3d.interceptor.*;
import lombok.extern.slf4j.Slf4j;
import nz.net.ultraq.thymeleaf.LayoutDialect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.web.client.RestTemplateBuilder;
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
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.*;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.servlet.support.RequestDataValueProcessor;

import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.time.Duration;

@Slf4j
@EnableWebMvc
@Configuration
@ComponentScan(basePackages = { "gaia3d.config", "gaia3d.controller.view", "gaia3d.controller.rest", "gaia3d.interceptor", "gaia3d.validation" }, includeFilters = {
		@Filter(type = FilterType.ANNOTATION, value = Component.class),
		@Filter(type = FilterType.ANNOTATION, value = Controller.class),
		@Filter(type = FilterType.ANNOTATION, value = RestController.class)})
public class ServletConfig implements WebMvcConfigurer {
	
	@Autowired
	private PropertiesConfig propertiesConfig;

	@Autowired
	private LocaleInterceptor localeInterceptor;
	@Autowired
	private CSRFHandlerInterceptor cSRFHandlerInterceptor;
	@Autowired
	private ConfigInterceptor configInterceptor;
	@Autowired
	private LogInterceptor logInterceptor;
	@Autowired
	private SecurityInterceptor securityInterceptor;

	@Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

	/**
	 * 내부에 List로 저장하기 때문에 순서대로 저장
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		log.info(" @@@ ServletConfig addInterceptors @@@@ ");

		registry.addInterceptor(localeInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/f4d/**", "/guide/**", "/sample/**", "/css/**", "/externlib/**", "favicon*", "/images/**", "/js/**");
		registry.addInterceptor(securityInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/f4d/**",	"/sign/**", "/cache/reload", "/guide/**", "/sample/**", "/css/**", "/externlib/**", "favicon*", "/images/**", "/js/**");
		registry.addInterceptor(cSRFHandlerInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/f4d/**",
					"/sign/**", "/cache/reload", "/data-groups/view-order/*", "/board-groups/view-order/*", "/design-layer-groups/view-order/*", "/layer-groups/view-order/*", "/layer/insert",
					"/layer/update/**", "/layer/**/layer-file-infos/**",
					"/design-layers/insert", "/design-layers/update/**", "/design-layers/**/layer-file-infos/**", "/data-adjust-logs/status/**",
					"/data-library-uploads", "/datas/attributes",
					"/rule/**", "/rules/**", "/rule-template/**", "/rule-templates/**",
					"/upload-datas", "/users/status", "/user-groups/urban-groups", "/user-groups/role", "/user-groups/micro-services",
					"/guide/**", "/css/**", "/externlib/**", "favicon*", "/images/**", "/js/**");
		registry.addInterceptor(logInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/f4d/**",	"/sign/**", "/cache/reload", "/guide/**", "/css/**", "/externlib/**", "favicon*", "/images/**", "/js/**");
		registry.addInterceptor(configInterceptor)
				.addPathPatterns("/**")
				.excludePathPatterns("/f4d/**",	"/sign/**", "/cache/reload", "/guide/**", "/css/**", "/externlib/**", "favicon*", "/images/**", "/js/**");
    }

	@Bean
	public LayoutDialect layoutDialect() {
		return new LayoutDialect();
	}
	
	@Bean
	public LocaleResolver localeResolver() {
		return new SessionLocaleResolver();
	}

	@Bean
	public ReloadableResourceBundleMessageSource messageSource(){
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasename("classpath:/messages/messages");
		messageSource.setDefaultEncoding("UTF-8");
		return messageSource;
	}

	@Bean
	public MessageSourceAccessor getMessageSourceAccessor(){
		ReloadableResourceBundleMessageSource m = messageSource();
		return new MessageSourceAccessor(m);
	}
	
	/**
     * anotation @Valid 를 사용하려면 이 빈을 생성해 줘야 함
     */
    @Bean
    public LocalValidatorFactoryBean getValidator() {
        LocalValidatorFactoryBean bean = new LocalValidatorFactoryBean();
        bean.setValidationMessageSource(messageSource());
        return bean;
    }
	
	@Override
    public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("forward:/sign/signin");
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);
    }
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		log.info(" @@@ ServletConfig addResourceHandlers @@@");
		
		// F4D converter file 경로
		registry.addResourceHandler("/f4d/**").addResourceLocations("file:" + propertiesConfig.getDataServiceDir());
		
		registry.addResourceHandler("/f4d/sample/**").addResourceLocations("file:" + propertiesConfig.getGuideDataServiceDir());
		registry.addResourceHandler("/sample/json/**").addResourceLocations("classpath:static/sample/json/");
		registry.addResourceHandler("/sample/images/**").addResourceLocations("classpath:static/sample/images/");
		registry.addResourceHandler("/css/**").addResourceLocations("classpath:static/css/");
		registry.addResourceHandler("/externlib/**").addResourceLocations("classpath:static/externlib/");
		registry.addResourceHandler("/images/**").addResourceLocations("classpath:static/images/");
		registry.addResourceHandler("/js/**").addResourceLocations("classpath:static/js/");
		registry.addResourceHandler("/docs/**").addResourceLocations("classpath:static/docs/");
//		registry.addResourceHandler("/webjars/**").addResourceLocations("classpath:/META-INF/resources/webjars/");
	}
	
	@Bean
	public RequestDataValueProcessor requestDataValueProcessor() {
		log.info(" @@@ ServletConfig requestDataValueProcessor @@@ ");
		return new CSRFRequestDataValueProcessor();
	}
	
	@Bean
    public RestTemplate restTempate() throws KeyStoreException, NoSuchAlgorithmException, KeyManagementException {
    	// https://github.com/jonashackt/spring-boot-rest-clientcertificate/blob/master/src/test/java/de/jonashackt/RestClientCertTestConfiguration.java
    	
    	String restTemplateMode = propertiesConfig.getRestTemplateMode();
    	RestTemplateBuilder builder = new RestTemplateBuilder();
    	RestTemplate restTemplate = builder.
    					setConnectTimeout(Duration.ofMillis(10000))
	            		.setReadTimeout(Duration.ofMillis(10000))
	            		.build();
    	
//    	RestTemplateBuilder builder = new RestTemplateBuilder(new CustomRestTemplateCustomizer());
//    	if("http".equals(restTemplateMode)) {
//    		restTemplate = builder.errorHandler(new RestTemplateResponseErrorHandler())
//						.setConnectTimeout(Duration.ofMillis(10000))
//	            		.setReadTimeout(Duration.ofMillis(10000))
//	            		.build();
//    	} else {
//    		TrustStrategy acceptingTrustStrategy = (X509Certificate[] chain, String authType) -> true;
//	    	SSLContext sslContext = org.apache.http.ssl.SSLContexts.custom().loadTrustMaterial(null, acceptingTrustStrategy).build();
//	 
//	    	SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext);
//	    	CloseableHttpClient httpClient = HttpClients.custom().setSSLSocketFactory(csf).build();
//	 
//	    	HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
//	        requestFactory.setHttpClient(httpClient);
//	        
//	    	restTemplate = builder.errorHandler(new RestTemplateResponseErrorHandler())
//						.setConnectTimeout(Duration.ofMillis(10000))
//	            		.setReadTimeout(Duration.ofMillis(10000))
//	            		.build();
//			restTemplate.setRequestFactory(requestFactory);
//    	}
    	
		return restTemplate;
    }
}
