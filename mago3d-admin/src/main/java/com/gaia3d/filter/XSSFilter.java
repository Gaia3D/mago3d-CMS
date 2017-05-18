package com.gaia3d.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class XSSFilter implements Filter {
	
	//private static final Logger logger = LoggerFactory.getLogger(XSSFilter.class);
	
	private FilterConfig filterConfig = null;
	
	@Override
    public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
    }
 
    @Override
    public void destroy() {
    	this.filterConfig = null;
    }
 
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    	chain.doFilter(new XSSRequestWrapper((HttpServletRequest) request), response);
    }
}