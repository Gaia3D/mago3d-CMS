package gaia3d.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AttributeRepository {
	
	private String buildName;
	private String molitUfid;
	private String bprpSe;
	private String buldNm;
	private String batcNm;
	private String buldSe;
	private String pnuNo;
	private String 대지위치;
	private String 관리건축물;
	private String 도로명대지;
	private String 건물명;
	private String 새주소도로;
	private String 새주소법정;
	private String 새주소본번;
	private String 주용도코_1;
	private String 기타용도;
	private String 주건축물수;
	private String 부속건축물;
	private String 허가일;
	private String 착공일;
	private String 사용승인일;
	private String 허가번호년;
	private String 허가번호기;
	private String 허가번호_1;
	private String 허가번호구;
	private String 허가번호_2;
	private String 호수_호_;
	private String bdtyp_cd;
	private String mvmn_resn;
	private String pos_bul_nm;
	private String 용도;
	
}
