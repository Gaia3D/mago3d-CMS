package gaia3d.service;

import gaia3d.domain.common.QueueMessage;

public interface AMQPPublishService {

	/**
	 * 메시지 전송
	 * @param exchange
	 * @param routingKey
	 * @param queueMessage
	 */
	public void send(String exchange, String routingKey, QueueMessage queueMessage);
}
