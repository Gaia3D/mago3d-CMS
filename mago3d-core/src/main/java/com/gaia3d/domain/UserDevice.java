package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * 사용자 사용 디바이스
 * @author jeongdae
 *
 */
@Getter
@Setter
@ToString
public class UserDevice {
	private String method_mode;
	private String device_ip;
	
	// 고유번호
	private Long user_device_id;
	// 사용자 아이디
	private String user_id;
	// 사용 기기명
	private String device_name1;
	private String device_name2;
	private String device_name3;
	private String device_name4;
	private String device_name5;
	// 사용 기기 타입. 0 : PC, 1 : 핸드폰
	private String device_type1;
	private String device_type2;
	private String device_type3;
	private String device_type4;
	private String device_type5;
	// IP
	private String device_ip1;
	private String device_ip2;
	private String device_ip3;
	private String device_ip4;
	private String device_ip5;
	// 우선순위
	private Integer device_priority1;
	private Integer device_priority2;
	private Integer device_priority3;
	private Integer device_priority4;
	private Integer device_priority5;
	// 사용유무. Y : 사용, N : 사용안함
	private String use_yn1;
	private String use_yn2;
	private String use_yn3;
	private String use_yn4;
	private String use_yn5;
	// 설명
	private String description1;
	private String description2;
	private String description3;
	private String description4;
	private String description5;
	// 등록일
	private String insert_date;
	
	public String getViewDeviceType1() {
		if("0".equals(this.device_type1)) {
			return "PC";
		} else if("1".equals(this.device_type1)) {
			return "핸드폰";
		} else {
			return "";
		}
	}

	public String getViewDeviceType2() {
		if("0".equals(this.device_type2)) {
			return "PC";
		} else if("1".equals(this.device_type2)) {
			return "핸드폰";
		} else {
			return "";
		}
	}

	public String getViewDeviceType3() {
		if("0".equals(this.device_type3)) {
			return "PC";
		} else if("1".equals(this.device_type3)) {
			return "핸드폰";
		} else {
			return "";
		}
	}

	public String getViewDeviceType4() {
		if("0".equals(this.device_type4)) {
			return "PC";
		} else if("1".equals(this.device_type4)) {
			return "핸드폰";
		} else {
			return "";
		}
	}

	public String getViewDeviceType5() {
		if("0".equals(this.device_type5)) {
			return "PC";
		} else if("1".equals(this.device_type5)) {
			return "핸드폰";
		} else {
			return "";
		}
	}
	
	public String getViewUseYn1() {
		if("Y".equals(this.use_yn1)) {
			return "사용";
		} else if("N".equals(this.use_yn1)) {
			return "미사용";
		} else {
			return "";
		}
	}

	public String getViewUseYn2() {
		if("Y".equals(this.use_yn2)) {
			return "사용";
		} else if("N".equals(this.use_yn2)) {
			return "미사용";
		} else {
			return "";
		}
	}

	public String getViewUseYn3() {
		if("Y".equals(this.use_yn3)) {
			return "사용";
		} else if("N".equals(this.use_yn3)) {
			return "미사용";
		} else {
			return "";
		}
	}

	public String getViewUseYn4() {
		if("Y".equals(this.use_yn4)) {
			return "사용";
		} else if("N".equals(this.use_yn4)) {
			return "미사용";
		} else {
			return "";
		}
	}

	public String getViewUseYn5() {
		if("Y".equals(this.use_yn5)) {
			return "사용";
		} else if("N".equals(this.use_yn5)) {
			return "미사용";
		} else {
			return "";
		}
	}

	// 사용자 아이디 체크
	public String validate() {
		if(this.user_id == null || "".equals(this.user_id)) {
			return "userdevice.user_id.invalid";
		}
		return null;
	}
	
	public String getViewInsertDate() {
		if(this.insert_date == null || "".equals( insert_date)) {
			return "";
		}
		return insert_date.substring(0, 19);
	}
}