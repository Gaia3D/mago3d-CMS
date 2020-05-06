package gaia3d.config;

import org.springframework.amqp.rabbit.annotation.EnableRabbit;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer;
import org.springframework.amqp.rabbit.listener.adapter.MessageListenerAdapter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.ComponentScan.Filter;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.security.Crypt;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@ComponentScan(basePackages = { "gaia3d.config" }, includeFilters = {
		@Filter(type = FilterType.ANNOTATION, value = Component.class),
		@Filter(type = FilterType.ANNOTATION, value = Controller.class),
		@Filter(type = FilterType.ANNOTATION, value = RestController.class)})
@EnableRabbit
public class AMQPConfig {
	
	@Autowired
	private AMQPSubscribe aMQPSubscribe;
	
	@Autowired
	private PropertiesConfig propertiesConfig;

//	@Bean
//	public RabbitTemplate rabbitTemplate() {
//		RabbitTemplate template = new RabbitTemplate(connectionFactory());
//		template.setRoutingKey(propertiesConfig.getQueueName());
//		template.setExchange(propertiesConfig.getExchange());
//		return template;
//	}

	@Bean
	public ConnectionFactory connectionFactory() {
		CachingConnectionFactory connectionFactory = new CachingConnectionFactory(propertiesConfig.getQueueServerHost());
		connectionFactory.setUsername(Crypt.decrypt(propertiesConfig.getQueueUser()));
		connectionFactory.setPassword(Crypt.decrypt(propertiesConfig.getQueuePassword()));
		connectionFactory.setPort(Integer.parseInt(propertiesConfig.getQueueServerPort()));
		return connectionFactory;
	}
	
	@Bean
	public SimpleMessageListenerContainer listenerContainer() {
		log.info("@@@@@@@ AMQPConfig listenerContainer >>>>> ");
		SimpleMessageListenerContainer container = new SimpleMessageListenerContainer();
		container.setConnectionFactory(connectionFactory());
		container.setQueueNames(propertiesConfig.getQueueName());
		container.setMessageListener(new MessageListenerAdapter(aMQPSubscribe));
		return container;
	}

}
