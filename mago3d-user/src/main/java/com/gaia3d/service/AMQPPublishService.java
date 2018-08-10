package com.gaia3d.service;

public interface AMQPPublishService {

	/**
	 * message 전송
	 * @param message
	 */
	public void send(String message);
}
