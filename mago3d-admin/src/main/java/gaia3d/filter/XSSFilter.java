package gaia3d.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
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
    	HttpServletRequest request2 = (HttpServletRequest) request;
    	log.info(" >>> XSSFilter uri = {}", request2.getRequestURI());
    	chain.doFilter(new XSSRequestWrapper((HttpServletRequest) request), response);
    }
}