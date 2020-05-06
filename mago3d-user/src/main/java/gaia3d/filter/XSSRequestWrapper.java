package gaia3d.filter;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
 
public class XSSRequestWrapper extends HttpServletRequestWrapper {
 
    private static Pattern[] patterns = new Pattern[] {
        // Script fragments
        Pattern.compile("<script>(.*?)</script>", Pattern.CASE_INSENSITIVE),
        Pattern.compile("%3CScRiPt.*?%3C/ScRiPt%3E", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("(?i)<script.*?>.*?</script.*?>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("(?i)<.*?javascript:.*?>.*?</.*?>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("(?i)<.*?\\s+on.*?>.*?</.*?>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // src='...'
        Pattern.compile("src[\r\n]*=[\r\n]*\\\'(.*?)\\\'", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        Pattern.compile("src[\r\n]*=[\r\n]*\\\"(.*?)\\\"", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // lonely script tags
        Pattern.compile("</script>", Pattern.CASE_INSENSITIVE),
        Pattern.compile("<script(.*?)>", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // eval(...)
        Pattern.compile("eval\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // expression(...)
        Pattern.compile("expression\\((.*?)\\)", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL),
        // javascript:...
        Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE),
        // script
        Pattern.compile("script", Pattern.CASE_INSENSITIVE),
        // alert
        Pattern.compile("alert", Pattern.CASE_INSENSITIVE),
        // vbscript:...
        Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE),
        // onload(...)=...
        Pattern.compile("onload(.*?)=", Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL)
    };
 
    public XSSRequestWrapper(HttpServletRequest servletRequest) {
        super(servletRequest);
    }
 
    @Override
    public String[] getParameterValues(String parameter) {
        String[] values = super.getParameterValues(parameter);
 
        if (values == null) {
            return null;
        }
 
        int count = values.length;
        String[] encodedValues = new String[count];
        for (int i = 0; i < count; i++) {
            encodedValues[i] = stripXSS(values[i]);
        }
 
        return encodedValues;
    }
 
    @Override
    public String getParameter(String parameter) {
        String value = super.getParameter(parameter);
        return stripXSS(value);
    }
 
//    @Override
//    public String getHeader(String name) {
//        String value = super.getHeader(name);
//        return stripXSS(value);
//    }
 
    private String stripXSS(String value) {
        if (value != null) {
        	
        	// 아래 로직은 추가 했음
        	// value = value.replaceAll("\"", "%22").replaceAll("\'", "%27");
        	// value = value.replaceAll("<", "%3C").replaceAll(">", "%3E");
        	
        	// TODO jar 덩치가 너무 커져서 ESAPI, Jsoup 은 우선 사용하지 않음. 대신 for 문으로 패턴 체크
        	
        	// NOTE: It's highly recommended to use the ESAPI library and uncomment the following line to
            // avoid encoded attacks.
            // value = ESAPI.encoder().canonicalize(value);
 
            // Avoid null characters
            value = value.replaceAll("\0", "");
 
            // Clean out HTML        
        	// value = Jsoup.clean(value, Whitelist.none());
            for (Pattern scriptPattern : patterns) {
            	int beforeLength = value.length();
            	value = scriptPattern.matcher(value).replaceAll("");
            	int afterLength = value.length();
            	if(beforeLength != afterLength) {
            		value = "[NOTICE] This variable is suspected of an XSS attacks.";
            		break;
            	}
            }
        }
        return value;
    }
}