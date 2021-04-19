package gaia3d.domain.data;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DataInfoLegacy {
	// 위도
	private BigDecimal latitude;
	// 경도
	private BigDecimal longitude;
	// 고유번호
	private Long dataId;
	// Data Group 고유번호
	private Integer dataGroupId;
	// data 고유 식별번호
	private String data_key;
	// data 이름
	private String data_name;
	// origin : latitude, longitude, height 를 origin에 맟춤. boundingboxcenter : latitude, longitude, height 를 boundingboxcenter에 맟춤.
	private String mapping_type;
	// 높이
	private BigDecimal height;
	// heading
	private BigDecimal heading;
	// pitch
	private BigDecimal pitch;
	// roll
	private BigDecimal roll;
	// 기본 정보
	private String attributes;
}
