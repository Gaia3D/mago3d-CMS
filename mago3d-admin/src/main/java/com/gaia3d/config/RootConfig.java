package com.gaia3d.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
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
	
	@Autowired
	private DataSource dataSource;

//	@Value("${spring.data.mongodb.host}")
//	private String mongoHost;
	
	
	@Bean
    public DataSourceTransactionManager transactionManager() {
		log.info(" ### RootConfig transactionManager ### ");
        final DataSourceTransactionManager transactionManager = new DataSourceTransactionManager(dataSource);
        return transactionManager;
    }
	
	@Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
		log.info(" ### RootConfig sqlSessionFactory ### ");
		SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
		factory.setDataSource(dataSource);
		factory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/*.xml"));
		factory.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("mybatis-config.xml"));
		//factory.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
		return factory.getObject();
    }
}
