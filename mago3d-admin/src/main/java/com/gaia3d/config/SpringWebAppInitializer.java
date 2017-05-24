package com.gaia3d.config;

import javax.servlet.FilterRegistration;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.DispatcherServlet;

import com.gaia3d.filter.XSSFilter;
import com.gaia3d.listener.Gaia3dHttpSessionBindingListener;

import lombok.extern.slf4j.Slf4j;

/**
 * web.xml 대신 설정
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class SpringWebAppInitializer implements WebApplicationInitializer {

	@Override
	public void onStartup(ServletContext container) throws ServletException {
		log.info("################################# SpringWebAppInitializer onStartup");
		
		// Create the 'root' Spring application context
		AnnotationConfigWebApplicationContext rootContext = new AnnotationConfigWebApplicationContext();
		rootContext.register(RootConfig.class);
		// Manage the lifecycle of the root application context
		container.addListener(new ContextLoaderListener(rootContext));
		
		registerServletContext(container, rootContext);
		registerFilter(container);
		registerListener(container);
		
		// web.xml session timeout 의 경우 application.properties 에 있음
		// TODO
		// 404 error page
	}
	
	/**
	 * filter 설정
	 * @param container
	 */
	private void registerServletContext(ServletContext container, AnnotationConfigWebApplicationContext rootContext) {
		log.info("################################# SpringWebAppInitializer registerServletContext");
		// Create the dispatcher servlet's Spring application context
		AnnotationConfigWebApplicationContext dispatcherContext = new AnnotationConfigWebApplicationContext();
		dispatcherContext.register(ServletConfig.class);

		// Register and map the dispatcher servlet
		ServletRegistration.Dynamic dispatcher = container.addServlet("dispatcher", new DispatcherServlet(dispatcherContext));
		log.info("### rootContext.getClass().getName() = ", rootContext.getClass().getName());
		dispatcher.setInitParameter("contextClass", rootContext.getClass().getName());
		dispatcher.setLoadOnStartup(1);
		dispatcher.addMapping("/");
	}
	
	/**
	 * filter 설정
	 * @param container
	 */
	private void registerFilter(ServletContext container) {
		log.info("################################# SpringWebAppInitializer registerFilter");
		
		// UTF8 Charactor Filter.
		FilterRegistration.Dynamic encodingFilter = container.addFilter("encodingFilter", CharacterEncodingFilter.class);
		encodingFilter.setInitParameter("encoding", "utf-8");
		encodingFilter.setInitParameter("forceEncoding", "true");
		encodingFilter.addMappingForUrlPatterns(null, true, "*.do");
		
		FilterRegistration.Dynamic xSSFilter = container.addFilter("xSSFilter", XSSFilter.class);
		xSSFilter.addMappingForUrlPatterns(null, true, "*.do");
	}
	
	/**
	 * HttpSessionBindingListener 설정
	 * @param container
	 */
	private void registerListener(ServletContext container) {
		log.info("################################# SpringWebAppInitializer registerListener");
		container.addListener(new Gaia3dHttpSessionBindingListener());
	}
}