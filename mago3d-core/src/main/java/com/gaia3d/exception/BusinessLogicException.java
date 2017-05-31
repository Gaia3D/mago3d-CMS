package com.gaia3d.exception;

public class BusinessLogicException extends RuntimeException {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2578996343754728773L;

	public BusinessLogicException(Throwable cause) {
		initCause(cause);
	}
	
	public BusinessLogicException(String message, Throwable cause) {
		super(message);
		initCause(cause);
	}
}

