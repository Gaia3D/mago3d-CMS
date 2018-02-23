package com.gaia3d.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.gaia3d.security.Crypt;
import com.zaxxer.hikari.HikariDataSource;

import lombok.extern.slf4j.Slf4j;

/**
 * root context 설정
 * @author Cheon JeongDae
 *
 */
@Slf4j
@Configuration
@MapperScan("com.gaia3d.persistence")
@ComponentScan(	basePackages = {"com.gaia3d.service,com.gaia3d.persistence"},
				includeFilters = {	@Filter(type = FilterType.ANNOTATION, value = Component.class),
									@Filter(type = FilterType.ANNOTATION, value = Service.class),
									@Filter(type = FilterType.ANNOTATION, value = Repository.class) },
				excludeFilters = @Filter(type = FilterType.ANNOTATION, value = Controller.class) )
public class RootConfig {
	
	@Value("${spring.datasource.driver-class-name}")
	private String driverClassName;
	@Value("${spring.datasource.url}")
	private String url;
	@Value("${spring.datasource.username}")
	private String username;
	@Value("${spring.datasource.password}")
	private String password;
	@Value("${spring.datasource.hikari.maximum-pool-size}")
	private Integer maximumPoolSize;
	@Value("${spring.datasource.hikari.minimum-idle}")
	private Integer minimumIdle;
	
	@Bean(name="datasourceAdmin")
	public DataSource dataSource() {
		
		// TODO hikari 에서는 min, max 를 동일값을 해 주길 권장
//		spring.datasource.hikari.minimum-idle=20
//		spring.datasource.hikari.maximum-pool-size=30
//		spring.datasource.hikari.idle-timeout=600000 (10분)
//		spring.datasource.hikari.max-lifetime=1800000 (30분)
//		spring.datasource.hikari.connection-timeout=15000
//		spring.datasource.hikari.validation-timeout=10000
		
		HikariDataSource dataSource = new HikariDataSource();
		//dataSource.setPoolName("mago3DAdminPool");
		dataSource.setDriverClassName(driverClassName);
		dataSource.setJdbcUrl(Crypt.decrypt(url));
		dataSource.setUsername(Crypt.decrypt(username));
		dataSource.setPassword(Crypt.decrypt(password));
		dataSource.setMaximumPoolSize(maximumPoolSize);
		dataSource.setMinimumIdle(minimumIdle);
		
//		org.apache.tomcat.jdbc.pool.DataSource dataSource = new org.apache.tomcat.jdbc.pool.DataSource();
//	    dataSource.setDriverClassName(driverClassName);
//	    dataSource.setUrl(Crypt.decrypt(url));
//	    dataSource.setUsername(Crypt.decrypt(username));
//	    dataSource.setPassword(Crypt.decrypt(password));
//	    // 서버용
//	    dataSource.setInitialSize(10);
//	    dataSource.setMaxActive(25);
//	    dataSource.setMaxIdle(15);
//	    dataSource.setMinIdle(10);
////	    dataSource.setTestWhileIdle(testWhileIdle);     
////	    dataSource.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMills);
////	    dataSource.setValidationQuery(validationQuery);
	    return dataSource;
	}
	
	@Bean
    public DataSourceTransactionManager transactionManager() {
		log.info(" ### RootConfig transactionManager ### ");
        final DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(dataSource());
        return transactionManager;
    }
	
//	@Bean
//    public MBeanExporter exporter() {
//		final MBeanExporter exporter = new MBeanExporter();
//		// we exclude the "datasource" beans because it's already managed by hikari itself
//		exporter.setExcludedBeans("datasourceAdmin", "datasourceUser");
//		return exporter;
//	}
	
	@Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
		log.info(" ### RootConfig sqlSessionFactory ### ");
		SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
		factory.setDataSource(dataSource());
		factory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/*.xml"));
		factory.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("mybatis-config.xml"));
		//factory.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
		return factory.getObject();
    }
}
