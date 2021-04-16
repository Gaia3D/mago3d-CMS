package gaia3d.domain.country;

import java.math.BigDecimal;

import gaia3d.domain.common.Search;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class District extends Search {

	private String fullTextSearch;

	// 행정구역 코드
	private String id;
	// 행정구역명(화면 표시)
	private String name;
	// 경도
	private BigDecimal longitude;
	// 위도
	private BigDecimal latitude;

	/******** 시도 **********/
	private Integer sidoId;
	private String sidoGeom;
	private String sidoCd;
	private String sidoEngNm;
	private String sidoKorNm;

	/******** 시군구 **********/
	private Integer sggId;
	private String sggGeom;
	private String sggCd;
	private String sggEngNm;
	private String sggKorNm;

	/******** 읍면동 **********/
	private Integer emdId;
	private String emdGeom;
	private String emdCd;
	private String emdEngNm;
	private String emdKorNm;

}
