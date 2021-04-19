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
public class APIHeader implements Serializable {

	private static final long serialVersionUID = -6764057655883300254L;
	
	private String userId;
	private String apiKey;
	private String token;
	private String role;
	private String algorithm;
	private String type;
}
