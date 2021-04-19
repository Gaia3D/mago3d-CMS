package gaia3d.domain.uploaddata;

/**
 * 디렉토리 구조
 * @author Cheon JeongDae
 *
 */
public enum UploadDirectoryType {
	// 년, 월, 일
	YEAR, YEAR_MONTH, YEAR_MONTH_DAY,
	// 사용자 아이디 밑에 년, 월, 일
	USERID_YEAR, USERID_YEAR_MONTH, USERID_YEAR_MONTH_DAY,
	// 년, 월, 일 밑에 사용자 아이디
	YEAR_USERID, YEAR_MONTH_USERID, YEAR_MONTH_DAY_USERID;
}
