package gaia3d.service;

import gaia3d.domain.common.QueueMessage;
import gaia3d.domain.common.TileMessage;

public interface AMQPPublishService {

	/**
	 * 메시지 전송
	 * @param exchange
	 * @param routingKey
	 * @param queueMessage
	 */
	public void converterMessageSend(String exchange, String routingKey, QueueMessage queueMessage);

	/**
	 * 메시지 전송
	 * @param exchange
	 * @param routingKey
	 * @param tileMessage
	 */
	public void tileMessageSend(String exchange, String routingKey, TileMessage tileMessage);
}
