package com.gaia3d.helper;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gaia3d.domain.ExternalService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class HttpClientHelper {
	
	private static RequestConfig defaultConfig = RequestConfig.custom().setConnectTimeout(10000).setConnectionRequestTimeout(10000).setSocketTimeout(10000).build();
	
//	/**
//	 * Http Get 방식
//	 * @param externalService
//	 * @return
//	 */
//	public static String httpGet(ExternalService externalService) {
//		
//		String result = null;
//		CloseableHttpClient httpclient = null;
//		CloseableHttpResponse response = null;
//    
//		try {
//        	httpclient = HttpClients.custom().setDefaultRequestConfig(defaultConfig).build();
//        	
//        	StringBuilder requestUrl = new StringBuilder(externalService.getUrl_scheme() + "://" + externalService.getUrl_host() 
//        			+ ":" + externalService.getUrl_port() + "/" + externalService.getUrl_path());
//        	
//			if(externalService.getExtra_key1() != null && !"".equals(externalService.getExtra_key1())) {
//				requestUrl.append("?").append(externalService.getExtra_key1()).append("=").append(externalService.getExtra_value1());
//			}
//			if(externalService.getExtra_key2() != null && !"".equals(externalService.getExtra_key2())) {
//				requestUrl.append("&").append(externalService.getExtra_key2()).append("=").append(externalService.getExtra_value2());
//			}
//			if(externalService.getExtra_key3() != null && !"".equals(externalService.getExtra_key3())) {
//				requestUrl.append("&").append(externalService.getExtra_key3()).append("=").append(externalService.getExtra_value3());
//			}
//        	
//        	HttpGet httpget = new HttpGet(requestUrl.toString());
//            response = httpclient.execute(httpget);
//          
//            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_BAD_REQUEST
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_INTERNAL_SERVER_ERROR) {
//				result = getResult(response);
//			}
//        } catch(Exception e) {
//        	e.printStackTrace();
//        } finally {
//        	try {
//        		if(response != null) {
//        			response.close();
//        		}
//        	} catch(Exception e) {
//        		e.printStackTrace();
//        	}
//        	try {
//        		if(httpclient != null) {
//        			httpclient.close();
//        		}
//        	} catch(Exception e) {
//        		e.printStackTrace();
//        	}
//        }
//		return result;
//	}
	
	/**
	 * Http Post 방식
	 * @param externalService
	 * @param authData
	 * @return
	 */
	@ResponseBody
	public static Map<String, Object> httpPost(ExternalService externalService, String authData) {
		Map<String, Object> jSONObject = new HashMap<>();
		String result = null;
		CloseableHttpClient httpclient = null;
		CloseableHttpResponse response = null;
		HttpStatus httpStatus = null;
        try {
        	httpclient = HttpClients.custom().setDefaultRequestConfig(defaultConfig).build();
        	
        	String requestUrl = externalService.getUrl_scheme() + "://" + externalService.getUrl_host() 
								+ ":" + externalService.getUrl_port() + "/" + externalService.getUrl_path();
		    log.info("@@@@@@@@@@@@ url = {}", requestUrl);
			HttpPost httpPost = new HttpPost(requestUrl);
			httpPost.addHeader("content-type", "application/json;charset=UTF-8");
			List <NameValuePair> nameValuePair = new ArrayList <NameValuePair>();
			nameValuePair.add(new BasicNameValuePair("auth_data", authData));
			httpPost.setEntity(new UrlEncodedFormEntity(nameValuePair, "utf-8"));
			response = httpclient.execute(httpPost);
			httpStatus = HttpStatus.valueOf(response.getStatusLine().getStatusCode());
			log.info("@@@@@@@@@@@@ response httpStatus = {}", httpStatus);
		    if (httpStatus == HttpStatus.OK || httpStatus == HttpStatus.UNAUTHORIZED) {
				result = getResult(response);
			    log.info("@@@@@@@@@@@@ result = {}", result);
			}
		    
		    jSONObject.put("statusCode", httpStatus.value());
		    jSONObject.put("statusCodeValue", httpStatus.name());
		    jSONObject.put("result", result);
        } catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	try {
        		if(response != null) {
        			response.close();
        		}
        	} catch(Exception e) {
        		e.printStackTrace();
        	}
        	try {
        		if(httpclient != null) {
        			httpclient.close();
        		}
        	} catch(Exception e) {
        		e.printStackTrace();
        	}
        }
        return jSONObject;
	}
	
//	/**
//	 * OTP 인증,생성 등을 위한 API 호출에 사용. HTTPS GET 방식, 사설 인증서의 경우 통과 시킴
//	 * @throws Exception
//	 */
//	public static String httpsGetAPICallWithoutCertificate(ExternalService externalService, APILog apiLog) {
//
//		// Commons HttpClient의 contribution 패키지에서 사용할 수 있는 EasySSLProtocolSocketFactory를 사용하면 
//		// 신뢰되지 않은 자기서명(self-signed)된 인증서를 가진 서버와도 바로 SSL 통신을 할 수 있다
//		
//		String result = null;
//		CloseableHttpClient httpclient = null;
//		CloseableHttpResponse response = null;
//		
//		TrustManager easyTrustManager = new X509TrustManager() {
//			public X509Certificate[] getAcceptedIssuers() {
//				return new X509Certificate[0];
//            }
//            public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
//            }
//            public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
//            }
//        };
//        
//        try {
//        	SSLContext sslcontext = SSLContext.getInstance("TLS");
//            sslcontext.init(null, new TrustManager[] { easyTrustManager }, null);
//            
//            SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
//	                sslcontext,
//	                new String[] {"TLSv1", "TLSv1.1", "TLSv1.2"},
//	                null,
//	                SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
//            
//            httpclient = HttpClients.custom()
//	                .setSSLSocketFactory(sslsf)
//	                .setDefaultRequestConfig(defaultConfig)
//	                .build();
//       
//	        StringBuilder requestUrl = new StringBuilder(externalService.getUrl_scheme() + "://" + externalService.getUrl_host() 
//        			+ ":" + externalService.getUrl_port() + "/" + externalService.getUrl_path());
//        	
//			requestUrl.append("?service_code=").append(StringUtils.defaultString(apiLog.getService_code()));
//			requestUrl.append("&service_name=").append(URLEncoder.encode(StringUtils.defaultString(apiLog.getService_name()), "utf-8"));
//			requestUrl.append("&client_ip=").append(StringUtils.defaultString(apiLog.getClient_ip()));
//			requestUrl.append("&client_server_name=").append(URLEncoder.encode(StringUtils.defaultString(apiLog.getClient_server_name()), "utf-8"));
//			requestUrl.append("&api_key=").append(StringUtils.defaultString(apiLog.getApi_key()));
//			requestUrl.append("&device_kind=").append(StringUtils.defaultString(apiLog.getDevice_kind()));
//			requestUrl.append("&request_type=").append(StringUtils.defaultString(apiLog.getRequest_type()));
//			requestUrl.append("&user_id=").append(StringUtils.defaultString(apiLog.getUser_id()));
//			if(apiLog.getData_count() != null) {
//				requestUrl.append("&data_count=").append(apiLog.getData_count());	
//			}
//			requestUrl.append("&data_delimiter=").append(StringUtils.defaultString(apiLog.getData_delimiter()));
//			requestUrl.append("&phone=").append(StringUtils.defaultString(apiLog.getPhone()));
//			requestUrl.append("&email=").append(StringUtils.defaultString(apiLog.getEmail()));
//			requestUrl.append("&messanger=").append(StringUtils.defaultString(apiLog.getMessanger()));
//			requestUrl.append("&field1=").append(StringUtils.defaultString(apiLog.getField1()));
//			requestUrl.append("&field2=").append(StringUtils.defaultString(apiLog.getField2()));
//			requestUrl.append("&field3=").append(StringUtils.defaultString(apiLog.getField3()));
//			requestUrl.append("&field4=").append(StringUtils.defaultString(apiLog.getField4()));
//			requestUrl.append("&field5=").append(StringUtils.defaultString(apiLog.getField5()));
//			
//			log.info("@@@@@@@@@@@@ url = {}", requestUrl.toString());
//			
//	        HttpGet httpget = new HttpGet(requestUrl.toString());
//            response = httpclient.execute(httpget);
//            log.info("@@@@@@@@@@@@ response status = {}", response.getStatusLine().getStatusCode());
//            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_BAD_REQUEST
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_INTERNAL_SERVER_ERROR) {
//				result = getResult(response);
//			}
//		} catch(Exception e) {
//        	e.printStackTrace();
//        } finally {
//        	try {
//        		if(response != null) {
//        			response.close();
//        		}
//        	} catch(Exception e) {
//        		e.printStackTrace();
//        	}
//        	try {
//        		if(httpclient != null) {
//        			httpclient.close();
//        		}
//        	} catch(Exception e) {
//        		e.printStackTrace();
//        	}
//        }
//		return result;
//	}
//	
//	/**
//	 * TODO NameValuePair 를 사용하면 인터셉터 까지는 호출 되는데 그 뒤 Controller 에 들어 오지 못하는 이유는 뭘까?
//	 * Https Post SGNI 외부 API 호출
//	 * @param externalService
//	 * @return
//	 */
//	public static String httpsPostAPICallWithoutCertificate(ExternalService externalService, APILog apiLog) {
//
//		String result = null;
//		CloseableHttpClient httpclient = null;
//		CloseableHttpResponse response = null;
//		TrustManager easyTrustManager = new X509TrustManager() {
//			public X509Certificate[] getAcceptedIssuers() {
//				return new X509Certificate[0];
//            }
//            public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
//            }
//            public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
//            }
//        };
//        
//        try {
//        	SSLContext sslcontext = SSLContext.getInstance("TLS");
//            sslcontext.init(null, new TrustManager[] { easyTrustManager }, null);
//            
//            SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
//	                sslcontext,
//	                new String[] {"TLSv1", "TLSv1.1", "TLSv1.2"},
//	                null,
//	                SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
//            
//            httpclient = HttpClients.custom()
//	                .setSSLSocketFactory(sslsf)
//	                .setDefaultRequestConfig(defaultConfig)
//	                .build();
//       
//            String requestUrl = externalService.getUrl_scheme() + "://" + externalService.getUrl_host() 
//				+ ":" + externalService.getUrl_port() + "/" + externalService.getUrl_path();
//        	
//			HttpPost httpPost = new HttpPost(requestUrl);            
//        	List <NameValuePair> nameValuePair = new ArrayList <NameValuePair>();
//        	nameValuePair.add(new BasicNameValuePair("service_code", StringUtils.defaultString(apiLog.getService_code())));
//        	nameValuePair.add(new BasicNameValuePair("service_name", StringUtils.defaultString(apiLog.getService_name())));
//        	nameValuePair.add(new BasicNameValuePair("client_ip", StringUtils.defaultString(apiLog.getClient_ip())));
//        	nameValuePair.add(new BasicNameValuePair("client_server_name", StringUtils.defaultString(apiLog.getClient_server_name())));
//        	nameValuePair.add(new BasicNameValuePair("api_key", StringUtils.defaultString(apiLog.getApi_key())));
//        	nameValuePair.add(new BasicNameValuePair("device_kind", StringUtils.defaultString(apiLog.getDevice_kind())));
//        	nameValuePair.add(new BasicNameValuePair("request_type", StringUtils.defaultString(apiLog.getRequest_type())));
//        	nameValuePair.add(new BasicNameValuePair("user_id", StringUtils.defaultString(apiLog.getUser_id())));
//        	if(apiLog.getData_count() != null) {
//        		nameValuePair.add(new BasicNameValuePair("data_count", String.valueOf(apiLog.getData_count())));
//        	}
//        	nameValuePair.add(new BasicNameValuePair("data_delimiter", StringUtils.defaultString(apiLog.getData_delimiter())));
//        	nameValuePair.add(new BasicNameValuePair("phone", StringUtils.defaultString(apiLog.getPhone())));
//        	nameValuePair.add(new BasicNameValuePair("email", StringUtils.defaultString(apiLog.getEmail())));
//        	nameValuePair.add(new BasicNameValuePair("messanger", StringUtils.defaultString(apiLog.getMessanger())));
//        	nameValuePair.add(new BasicNameValuePair("field1", StringUtils.defaultString(apiLog.getField1())));
//        	nameValuePair.add(new BasicNameValuePair("field2", StringUtils.defaultString(apiLog.getField2())));
//        	nameValuePair.add(new BasicNameValuePair("field3", StringUtils.defaultString(apiLog.getField3())));
//        	nameValuePair.add(new BasicNameValuePair("field4", StringUtils.defaultString(apiLog.getField4())));
//        	nameValuePair.add(new BasicNameValuePair("field5", StringUtils.defaultString(apiLog.getField5())));
//        	
//        	httpPost.setEntity(new UrlEncodedFormEntity(nameValuePair, "utf-8"));
//        	
//            response = httpclient.execute(httpPost);
//            log.info("@@@@@@@@@@@@ response status = {}", response.getStatusLine().getStatusCode());
//            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_BAD_REQUEST
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_INTERNAL_SERVER_ERROR) {
//				result = getResult(response);
//            }
//		} catch(Exception e) {
//        	e.printStackTrace();
//        } finally {
//        	try {
//        		if(response != null) {
//        			response.close();
//        		}
//        	} catch(Exception e) {
//        		e.printStackTrace();
//        	}
//        	try {
//        		if(httpclient != null) {
//        			httpclient.close();
//        		}
//        	} catch(Exception e) {
//        		e.printStackTrace();
//        	}
//        }
//		return result;
//    }
	
	/**
	 * 세션 사용자, 사용자 페이지 상태 등 내부 업무용으로 사용하기 위한 API를 호출, 사설 인증서의 경우 통과 시킴
	 * @param externalService
	 * @param authData
	 * @return
	 */
	public static String httpsGetAPICallWithoutCertificate(ExternalService externalService, String authData) {

		String result = null;
		CloseableHttpClient httpclient = null;
		CloseableHttpResponse response = null;
		HttpStatus httpStatus = null;
		
		TrustManager easyTrustManager = new X509TrustManager() {
			public X509Certificate[] getAcceptedIssuers() {
				return new X509Certificate[0];
            }
            public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
            }
            public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
            }
        };
        
        try {
        	SSLContext sslcontext = SSLContext.getInstance("TLS");
            sslcontext.init(null, new TrustManager[] { easyTrustManager }, null);
            
            SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
	                sslcontext,
	                new String[] {"TLSv1", "TLSv1.1", "TLSv1.2"},
	                null,
	                SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
            
            httpclient = HttpClients.custom()
	                .setSSLSocketFactory(sslsf)
	                .setDefaultRequestConfig(defaultConfig)
	                .build();
       
	        StringBuilder requestUrl = new StringBuilder(externalService.getUrl_scheme() + "://" + externalService.getUrl_host() 
        			+ ":" + externalService.getUrl_port() + "/" + externalService.getUrl_path());
        	
			requestUrl.append("?auth_data=").append(authData);
			
			log.info("@@@@@@@@@@@@ url = {}", requestUrl.toString());
			
	        HttpGet httpget = new HttpGet(requestUrl.toString());
            response = httpclient.execute(httpget);
            log.info("@@@@@@@@@@@@ response status = {}", response.getStatusLine().getStatusCode());
//            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_BAD_REQUEST
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_INTERNAL_SERVER_ERROR) {
//				result = getResult(response);
//			}
		} catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	try {
        		if(response != null) {
        			response.close();
        		}
        	} catch(Exception e) {
        		e.printStackTrace();
        	}
        	try {
        		if(httpclient != null) {
        			httpclient.close();
        		}
        	} catch(Exception e) {
        		e.printStackTrace();
        	}
        }
		return result;
	}
	
	/**
	 * 세션 사용자, 사용자 페이지 상태 등 내부 업무용으로 사용하기 위한 API를 호출, 사설 인증서의 경우 통과 시킴
	 * @param externalService
	 * @param authData
	 * @return
	 */
	public static String httpsPostAPICallWithoutCertificate(ExternalService externalService, String authData) {

		String result = null;
		CloseableHttpClient httpclient = null;
		CloseableHttpResponse response = null;
		HttpStatus httpStatus = null;
		
		TrustManager easyTrustManager = new X509TrustManager() {
			public X509Certificate[] getAcceptedIssuers() {
				return new X509Certificate[0];
            }
            public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {
            }
            public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
            }
        };
        
        try {
        	SSLContext sslcontext = SSLContext.getInstance("TLS");
            sslcontext.init(null, new TrustManager[] { easyTrustManager }, null);
            
            SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(
	                sslcontext,
	                new String[] {"TLSv1", "TLSv1.1", "TLSv1.2"},
	                null,
	                SSLConnectionSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
            
            httpclient = HttpClients.custom()
	                .setSSLSocketFactory(sslsf)
	                .setDefaultRequestConfig(defaultConfig)
	                .build();
       
	        String requestUrl = externalService.getUrl_scheme() + "://" + externalService.getUrl_host() 
        			+ ":" + externalService.getUrl_port() + "/" + externalService.getUrl_path();
        	
	        log.info("@@@@@@@@@@@@ url = {}", requestUrl);
			
			HttpPost httpPost = new HttpPost(requestUrl);
			List <NameValuePair> nameValuePair = new ArrayList <NameValuePair>();
        	nameValuePair.add(new BasicNameValuePair("auth_data", authData));
        	httpPost.setEntity(new UrlEncodedFormEntity(nameValuePair, "utf-8"));
			response = httpclient.execute(httpPost);
            
			log.info("@@@@@@@@@@@@ response status = {}", response.getStatusLine().getStatusCode());
//            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_BAD_REQUEST
//            		|| response.getStatusLine().getStatusCode() == HttpStatus.SC_INTERNAL_SERVER_ERROR) {
//				result = getResult(response);
//			}
		} catch(Exception e) {
        	e.printStackTrace();
        } finally {
        	try {
        		if(response != null) {
        			response.close();
        		}
        	} catch(Exception e) {
        		e.printStackTrace();
        	}
        	try {
        		if(httpclient != null) {
        			httpclient.close();
        		}
        	} catch(Exception e) {
        		e.printStackTrace();
        	}
        }
		return result;
	}
	
	/**
	 * 응답 처리를 위한 메서드
	 * 
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static String getResult(HttpResponse response) throws Exception {
		StringBuffer stringBuffer = new StringBuffer();
		InputStreamReader inputStreamReader = null;
		BufferedReader bufferedReader = null;
		try {
			inputStreamReader = new InputStreamReader(response.getEntity().getContent(), "UTF-8");
			bufferedReader = new BufferedReader(inputStreamReader);
			String line = null;
			while ((line = bufferedReader.readLine()) != null) {
				stringBuffer.append(line);
			}
			bufferedReader.close();
			inputStreamReader.close();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (bufferedReader != null) { try { bufferedReader.close(); } catch (Exception e) { e.printStackTrace(); } }
			if (inputStreamReader != null) { try { inputStreamReader.close(); } catch (Exception e) { e.printStackTrace(); } }
		}

		return stringBuffer.toString();
	}
}
