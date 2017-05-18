package com.gaia3d.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@MapperScan(value = "com.example.dao1", sqlSessionFactoryRef = "db1SqlSessionFactory")
@EnableTransactionManagement
public class DBCPConfig {
	@Bean(name = "db1DataSource")
	@ConfigurationProperties(prefix = "spring.db1.datasource")
	public DataSource db1DataSource() {
		return DataSourceBuilder.create().build();
	}

	@Bean(name = "db1SqlSessionFactory")
	public SqlSessionFactory db1SqlSessionFactory(@Qualifier("db1DataSource") DataSource db1DataSource,
			ApplicationContext applicationContext) throws Exception {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
		sqlSessionFactoryBean.setDataSource(db1DataSource);
		sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources("classpath:com/example/dao1/*.xml"));
		return sqlSessionFactoryBean.getObject();
	}

	@Bean(name = "db1SqlSessionTemplate")
	public SqlSessionTemplate db1SqlSessionTemplate(SqlSessionFactory db1SqlSessionFactory) throws Exception {
		return new SqlSessionTemplate(db1SqlSessionFactory);
	}

}
