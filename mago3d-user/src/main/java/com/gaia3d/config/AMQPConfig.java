package com.gaia3d.config;

import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableRabbit
public class AMQPConfig {
	@Autowired
	private PropertiesConfig propertiesConfig;

	@Bean
	public RabbitTemplate rabbitTemplate() {
		RabbitTemplate template = new RabbitTemplate(connectionFactory());
		template.setRoutingKey(propertiesConfig.getQueueName());
		template.setExchange(propertiesConfig.getExchange());
		return template;
	}

	@Bean
	public ConnectionFactory connectionFactory() {
		CachingConnectionFactory connectionFactory = new CachingConnectionFactory(propertiesConfig.getQueueServerHost());
		connectionFactory.setUsername(propertiesConfig.getQueueUser());
		connectionFactory.setPassword(propertiesConfig.getQueuePassword());
		connectionFactory.setPort(Integer.parseInt(propertiesConfig.getQueueServerPort()));
		return connectionFactory;
	}
}
