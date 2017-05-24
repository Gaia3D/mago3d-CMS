package com.gaia3d.exception;

public class BusinessLogicException extends RuntimeException {
	public BusinessLogicException(String name, String message) {
		super(name);
	}
}

