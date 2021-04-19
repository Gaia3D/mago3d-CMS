package gaia3d.config;

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
import org.springframework.web.bind.annotation.RestController;

import com.zaxxer.hikari.HikariDataSource;

import lombok.extern.slf4j.Slf4j;
import gaia3d.security.Crypt;

@Slf4j
@MapperScan(basePackages="gaia3d.persistence")
@Configuration
@ComponentScan(	basePackages = {"gaia3d.service", "gaia3d.persistence"},
              includeFilters = {	@Filter(type = FilterType.ANNOTATION, value = Component.class),
                                  	@Filter(type = FilterType.ANNOTATION, value = Service.class),
                                  	@Filter(type = FilterType.ANNOTATION, value = Repository.class) },
              excludeFilters = {	@Filter(type = FilterType.ANNOTATION, value = Controller.class),
            		  				@Filter(type = FilterType.ANNOTATION, value = RestController.class) })
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
	
	@Bean(name="datasourceUser")
	public DataSource dataSource() {
		HikariDataSource dataSource = new HikariDataSource();
		//dataSource.setPoolName("mago3DAdminPool");
		dataSource.setDriverClassName(driverClassName);
		dataSource.setJdbcUrl(Crypt.decrypt(url));
		dataSource.setUsername(Crypt.decrypt(username));
		dataSource.setPassword(Crypt.decrypt(password));
		dataSource.setMaximumPoolSize(maximumPoolSize);
		dataSource.setMinimumIdle(minimumIdle);
		
		return dataSource;
	}
	
	@Bean
    public DataSourceTransactionManager transactionManager() {
		log.info(" ### RootConfig transactionManager ### ");
        return new DataSourceTransactionManager(dataSource());
    }
	
	@Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
		log.info(" ### RootConfig sqlSessionFactory ### ");
		SqlSessionFactoryBean factory = new SqlSessionFactoryBean();
		factory.setDataSource(dataSource());
		factory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:mybatis/*.xml"));
		factory.setConfigLocation(new PathMatchingResourcePatternResolver().getResource("mybatis-config.xml"));
		return factory.getObject();
    }

}
