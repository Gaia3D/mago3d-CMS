package gaia3d.interceptor;

import gaia3d.domain.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Locale;

/**
 * Locale 관련 설정
 * Enum은 성능을 위해 사용하지 않음
 *  
 * @author jeongdae
 *
 */
@Slf4j
@Component
public class LocaleInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	String lang = (String)request.getSession().getAttribute(Key.LANG.name());
		if(lang == null || "".equals(lang)) {
			Locale myLocale = request.getLocale();
			lang = myLocale.getLanguage();
		}

		String accessibility = "ko";
		if("ko".equals(lang)) {
			accessibility = "ko";
		} else if("en".equals(lang)) {
			accessibility = "en";
		} else if("ja".equals(lang)) {
			accessibility = "ja";
		} else {
			// TODO Because it does not support multilingual besides English and Japanese Based on English
			//lang = "en";
			//accessibility = "en";
			lang = "ko";
			accessibility = "ko";
		}

		request.setAttribute("lang", lang);
		request.setAttribute("accessibility", accessibility);

        return true;
    }
}
