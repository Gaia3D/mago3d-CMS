package gaia3d.domain.api;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @author Cheon JeongDae
 *
 */
@Getter
@Setter
@ToString
public class APIError implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1208067801485413775L;
	
	/**
	 * front end 메시지 처리 등을 위한 code
	 */
	private String code;
	private String message;
	private String detail;
	// Exception Type
	private String type;
	
	public APIError(String message) {
		super();
		this.message = message;
	}
	
	public APIError(String message, String code) {
		super();
		this.code = code;
		this.message = message;
	}
}
