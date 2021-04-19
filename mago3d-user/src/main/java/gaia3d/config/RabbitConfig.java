package gaia3d.config;

import gaia3d.security.Crypt;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.amqp.rabbit.connection.CachingConnectionFactory;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class RabbitConfig {
    @Autowired
    private PropertiesConfig propertiesConfig;

    @Bean
    Queue converterQueue() {
        return new Queue(propertiesConfig.getRabbitmqConverterQueue(), true);
    }

    @Bean
    Queue tilerQueue() {
        return new Queue(propertiesConfig.getRabbitmqTilerQueue(), true);
    }

    @Bean
    TopicExchange topicExchange() {
        return new TopicExchange(propertiesConfig.getRabbitmqConverterExchange());
    }

    @Bean
    Binding converterBinding(Queue converterQueue, TopicExchange topicExchange) {
        return BindingBuilder.bind(converterQueue).to(topicExchange).with(propertiesConfig.getRabbitmqConverterRoutingKey());
    }

    @Bean
    Binding tileBinding(Queue tilerQueue, TopicExchange topicExchange) {
        return BindingBuilder.bind(tilerQueue).to(topicExchange).with(propertiesConfig.getRabbitmqTilerRoutingKey());
    }

    @Bean
    ConnectionFactory connectionFactory() {
        CachingConnectionFactory connectionFactory = new CachingConnectionFactory(propertiesConfig.getRabbitmqServerHost());
        connectionFactory.setUsername(Crypt.decrypt(propertiesConfig.getRabbitmqUser()));
        connectionFactory.setPassword(Crypt.decrypt(propertiesConfig.getRabbitmqPassword()));
        connectionFactory.setPort(Integer.parseInt(propertiesConfig.getRabbitmqServerPort()));
        return connectionFactory;
    }

    @Bean
    RabbitTemplate rabbitTemplate(ConnectionFactory connectionFactory) {
        RabbitTemplate rabbitTemplate = new RabbitTemplate(connectionFactory);
        rabbitTemplate.setMessageConverter(new Jackson2JsonMessageConverter());
        return rabbitTemplate;
    }

//    @Bean
//    MessageConverter messageConverter() {
//        return new Jackson2JsonMessageConverter();
//    }
}
