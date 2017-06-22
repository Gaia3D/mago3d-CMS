//package com.gaia3d.dbcp;
//
//import org.apache.commons.dbcp2.BasicDataSource;
//import org.springframework.beans.factory.annotation.Value;
//
//import com.gaia3d.config.RootConfig;
//import com.gaia3d.security.Crypt;
//
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//public class Gaia3dBasicDataSource extends BasicDataSource {
//	
//	@Value("${spring.datasource.url}")
//	private String url;
//	@Value("${spring.datasource.username}")
//	private String username;
//	@Value("${spring.datasource.password}")
//	private String password;
//	
//	@Override
//	public void setPassword(String password) {
//		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ password === {}", password);
//		super.setPassword(Crypt.decrypt(password));
//	}
//
//	@Override
//	public synchronized void setUrl(String url) {
//		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ url === {}", url);
//		super.setUrl(Crypt.decrypt(url));
//	}
//
//	@Override
//	public void setUsername(String username) {
//		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ username === {}", username);
//		super.setUsername(Crypt.decrypt(username));
//	}
//}