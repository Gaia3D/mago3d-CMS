package com.gaia3d.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * Rest API 응답을 위한 범용
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class APIResult implements Serializable {

	private static final long serialVersionUID = -64139596070084106L;
	
	// http status
	private int statusCode;
	// validation code
	private String validationCode;
	// Exception
	private String exception;
	// detail message
	private String message;
	// token
	private Integer droneProjectId;
	// token
	private String token;
	// result
	private String result;
}
