package com.gaia3d.service;

import com.gaia3d.domain.QueueMessage;

public interface AMQPPublishService {

	/**
	 * message 전송
	 * @param queueMessage
	 */
	public void send(QueueMessage queueMessage);
}
