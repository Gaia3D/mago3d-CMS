//package com.gaia3d.config;
//
//import org.springframework.context.annotation.ComponentScan;
//import org.springframework.context.annotation.ComponentScan.Filter;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.FilterType;
//import org.springframework.stereotype.Component;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RestController;
//import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
//import org.springframework.web.servlet.config.annotation.EnableWebMvc;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//
//import lombok.extern.slf4j.Slf4j;
//
///**
// * 
// * @author Cheon JeongDae
// *
// */
////@EnableSwagger2
//@Slf4j
//@Configuration
//@ComponentScan(basePackages = { "com.gaia3d.config" }, includeFilters = {
//		@Filter(type = FilterType.ANNOTATION, value = Component.class),
//		@Filter(type = FilterType.ANNOTATION, value = Controller.class),
//		@Filter(type = FilterType.ANNOTATION, value = RestController.class)})
//public class ServletConfig implements WebMvcConfigurer {
//	
//	@Override
//    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
//        configurer.enable();
//    }
//}
