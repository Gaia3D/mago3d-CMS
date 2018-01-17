package com.gaia3d.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
//import org.apache.commons.lang.StringUtils;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.ss.usermodel.Cell;
//import org.apache.poi.ss.usermodel.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.DataInfo;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.FileParseLog;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserInfo;
import com.gaia3d.domain.UserSession;
import com.gaia3d.parser.DataFileParser;
import com.gaia3d.parser.impl.DataFileJsonParser;
import com.gaia3d.persistence.FileMapper;
import com.gaia3d.service.DataService;
import com.gaia3d.service.FileService;
import com.gaia3d.service.UserService;
import com.gaia3d.util.FileUtil;
import com.gaia3d.util.StringUtil;

import lombok.extern.slf4j.Slf4j;

/**
 * 파일 처리
 * @author jeongdae
 *
 */
@Slf4j
@Service
public class FileServiceImpl implements FileService {
	
	@Autowired
	private UserService userService;
	@Autowired
	private DataService dataService;
	@Autowired
	private FileMapper fileMapper;
	
	// 사용자 일괄 등록 Excel 파일 컬럼수
	private int EXCEL_UPLOAD_USER_COLUMN = 15;
	// Data 일괄 등록 Excel 파일 컬럼수
	private int EXCEL_UPLOAD_DATA_COLUMN = 9;
	// 엑셀에 최대 등록 가능한 건수
//	private int MAX_COUNT = 65000;
	
	/**
	 * 파일 정보 획득
	 * @param file_info_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public FileInfo getFileInfo(Long file_info_id) {
		return fileMapper.getFileInfo(file_info_id);
	}
	
	/**
	 * 파일 파싱 로그 획득
	 * @param file_parse_log_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public FileParseLog getFileParseLog(Long file_parse_log_id) {
		return fileMapper.getFileParseLog(file_parse_log_id);
	}

	/**
	 * 파일 정보 등록
	 * @param fileInfo
	 * @return
	 */
	@Transactional
	public int insertFileInfo(FileInfo fileInfo) {
		return fileMapper.insertFileInfo(fileInfo);
	}
	
	/**
	 * @Transactional 을 일부러 붙이지 않았음, 파일 파싱중에 오류가 나도 처리 하기 위함
	 * 
	 * 사용자 일괄 등록
	 * @param fileInfo
	 * @return
	 */
	public FileInfo insertExcelUser(FileInfo fileInfo) {
		
		// 파일 이름, 종류 같은 기본 정보를 저장
		fileMapper.insertFileInfo(fileInfo);
		
		// 파일 확장자가 xls 인 경우는 jexcel 로 파싱하고, xlsx 인 경우는 poi 로 파싱함, 6만 5천건 이상은 파싱 불가처리
		Map<String, Object> map = null;
//		if(FileUtil.EXCEL_PARSE_JEXCEL.equals(fileInfo.getFile_ext())) {
//			map = excelParseJExcel(fileInfo);
//		} else {
//			map = excelParsePoi(fileInfo);
//		}
//		map = excelParsePoi(fileInfo);
		
		@SuppressWarnings("unchecked")
		List<UserInfo> userList = (List<UserInfo>) map.get("userList");
		
		FileParseLog fileParseLog = new FileParseLog();
		fileParseLog.setFile_info_id(fileInfo.getFile_info_id());
		fileParseLog.setLog_type(FileParseLog.DB_INSERT_LOG);
		
		int insertSuccessCount = 0;
		int insertErrorCount = 0;
		for(UserInfo userInfo : userList) {
			try {
				userService.insertUser(userInfo);
				insertSuccessCount++;
			} catch(Exception e) {
				e.printStackTrace();
				fileParseLog.setIdentifier_value(fileInfo.getUser_id());
				String errorCode = e.getMessage();
				if(errorCode.length() > 2000) {
					errorCode = errorCode.substring(0, 2000) + "...";
				}
				fileParseLog.setError_code(errorCode);
				fileMapper.insertFileParseLog(fileParseLog);
				insertErrorCount++;
			}
		}
		
		fileInfo.setTotal_count((Integer) map.get("totalCount"));
		fileInfo.setParse_success_count((Integer) map.get("parseSuccessCount"));
		fileInfo.setParse_error_count((Integer) map.get("parseErrorCount"));
		fileInfo.setInsert_success_count(insertSuccessCount);
		fileInfo.setInsert_error_count(insertErrorCount);
		
		// 파일 파싱 정보를 update
		fileMapper.updateFileInfo(fileInfo);
		
		return fileInfo;
	}
	
	/**
	 * 사용자 일괄 등록 Excel 파일 확장자가 xls일 경우 JExcel 을 이용하여 파싱
	 * @param fileInfo
	 * @return
	 */
	private Map<String, Object> excelParseJExcel(FileInfo fileInfo) {
		
//		int totalCount = 0;
//		int parseSuccessCount = 0;
//		int parseErrorCount = 0;
//		List<UserInfo> userList = new ArrayList<UserInfo>();		
//		jxl.Workbook workBook = null;
//		try {
//			File file = new File(fileInfo.getFile_path() + fileInfo.getFile_real_name());
//			workBook = jxl.Workbook.getWorkbook(file);
//			Sheet sheet = workBook.getSheet(0);
//			totalCount = sheet.getRows();
//			
//			FileParseLog fileParseLog = new FileParseLog();
//			fileParseLog.setFile_info_id(fileInfo.getFile_info_id());
//			fileParseLog.setLog_type(FileParseLog.FILE_PARSE_LOG);
//			for(int i = 1; i < totalCount; i++) {
//				UserInfo userInfo = null;				
//				try {				
//					userInfo = getUserInfoFromJExcel(i, sheet);
//					String errorCode = parseValidChecker(userInfo);
//					if(StringUtils.isNotEmpty(errorCode)) {
//						throw new Exception(errorCode);
//					}
//					fileParseLog.setIdentifier_value(userInfo.getUser_id());
//					fileParseLog.setStatus(FileParseLog.EXCEL_PARSE_SUCCESS);
//					parseSuccessCount++;
//				} catch(Exception e) {
//					e.printStackTrace();
//					parseErrorCount++;
//					if(userInfo == null || userInfo.getUser_id() == null || "".equals(userInfo.getUser_id())) {
//						fileParseLog.setIdentifier_value("ADMIN_ERROR_ID");
//					} else {
//						fileParseLog.setIdentifier_value(userInfo.getUser_id());
//					}
//					fileParseLog.setStatus(FileParseLog.EXCEL_PARSE_FAIL);
//					fileParseLog.setError_code(e.getMessage());
//				}
//				
//				if(userInfo != null) {
//					// TODO user_id 가 문제 생길때 어떻게 해야 하지?
//					fileMapper.insertFileParseLog(fileParseLog);
//					userList.add(userInfo);				
//				}
//			}
//			workBook.close();
//		} catch(Exception e) {
//			e.printStackTrace();
//			throw new RuntimeException("사용자 일괄 등록(JExcel) 파일 파싱 오류!");
//		} finally {
//			if(workBook != null) workBook.close();
//		}
		
		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("userList", userList);
//		result.put("totalCount", totalCount);
//		result.put("parseSuccessCount", parseSuccessCount);
//		result.put("parseErrorCount", parseErrorCount);
		return result;
	}
	
//	/**
//	 * JExcel 을 이용해서 사용자 정보를 파싱
//	 * @param i
//	 * @param sheet
//	 * @return
//	 */
//	private UserInfo getUserInfoFromJExcel(int i, Sheet sheet) {
//		
//		// 첫번째 컬럼 user_id
//		String userId = StringUtil.getDefaultValue(sheet.getCell(0, i).getContents());
//		String salt = SHA256.getSalt();
//		// 패스워드는 사용자 아이디 + 초기문자 생성
//		String password = SHA256.getPassword(userId, salt);
//		int sizeOfSheet = sheet.getColumns();
//		
//		UserInfo userInfo = new UserInfo();
//		userInfo.setUser_id(userId);
//		userInfo.setUser_group_id(Long.valueOf(StringUtil.getDefaultValue(sheet.getCell(1, i).getContents())));
//		userInfo.setUser_name(StringUtil.getDefaultValue(sheet.getCell(2, i).getContents()));
//		userInfo.setSalt(salt);
//		userInfo.setPassword(password);
//		if(sizeOfSheet > 3) {
//			userInfo.setTelephone(Crypt.encrypt(StringUtil.getDefaultValue(sheet.getCell(3, i).getContents())));
//		}
//		if(sizeOfSheet > 4) {
//			userInfo.setMobile_phone(Crypt.encrypt(StringUtil.getDefaultValue(sheet.getCell(4, i).getContents())));
//		}
//		if(sizeOfSheet > 5) {
//			userInfo.setEmail(Crypt.encrypt(StringUtil.getDefaultValue(sheet.getCell(5, i).getContents())));
//		}
//		if(sizeOfSheet > 6) {
//			userInfo.setMessanger(StringUtil.getDefaultValue(sheet.getCell(6, i).getContents()));
//		}
//		if(sizeOfSheet > 7) {
//			userInfo.setEmp_no(StringUtil.getDefaultValue(sheet.getCell(7, i).getContents()));
//		}
//		if(sizeOfSheet > 8) {
//			userInfo.setDept_name(StringUtil.getDefaultValue(sheet.getCell(8, i).getContents()));
//		}
//		if(sizeOfSheet > 9) {
//			userInfo.setPosition(StringUtil.getDefaultValue(sheet.getCell(9, i).getContents()));
//		}
//		if(sizeOfSheet > 10) {
//			userInfo.setPostal_code(StringUtil.getDefaultValue(sheet.getCell(10, i).getContents()));
//		}
//		if(sizeOfSheet > 11) {
//			userInfo.setAddress(StringUtil.getDefaultValue(sheet.getCell(11, i).getContents()));
//		}
//		if(sizeOfSheet > 12) {
//			userInfo.setAddress_etc(Crypt.encrypt(StringUtil.getDefaultValue(sheet.getCell(12, i).getContents())));
//		}
//		if(sizeOfSheet > 13) {
//			userInfo.setCi(StringUtil.getDefaultValue(sheet.getCell(13, i).getContents()));
//		}
//		if(sizeOfSheet > 14) {
//			userInfo.setDi(StringUtil.getDefaultValue(sheet.getCell(14, i).getContents()));
//		}
//		
//		return userInfo;
//	}
	
//	/**
//	 * 사용자 일괄 등록 Excel 파일 확장자가 xlsx일 경우 POI 을 이용하여 파싱
//	 * @param fileInfo
//	 * @return
//	 */
//	private Map<String, Object> excelParsePoi(FileInfo fileInfo) {
//		
//		int totalCount = 0;
//		int parseSuccessCount = 0;
//		int parseErrorCount = 0;
//		
//		Policy policy = CacheManager.getPolicy();
//		boolean passwordCreateWithUserId = false;
//		if(Policy.PASSWORD_CREATE_WITH_USER_ID.equals(policy.getPassword_create_type())) {
//			passwordCreateWithUserId = true;
//		} 
//		String passwordCreateChar = StringUtil.getDefaultValue(policy.getPassword_create_char());
//		List<UserInfo> userList = new ArrayList<UserInfo>();		
//		
//		FileParseLog fileParseLog = new FileParseLog();
//		fileParseLog.setFile_info_id(fileInfo.getFile_info_id());
//		fileParseLog.setLog_type(FileParseLog.FILE_PARSE_LOG);		
//		FileInputStream fis = null;
//		org.apache.poi.ss.usermodel.Workbook workbook = null;
//		try {
//			File file = new File(fileInfo.getFile_path() + fileInfo.getFile_real_name());
//			fis = new FileInputStream(file);
//			if(FileUtil.EXCEL_EXTENSION_XLS.equals(fileInfo.getFile_ext())) {
//				workbook = new HSSFWorkbook(fis);
//			} else{
//				workbook = new org.apache.poi.xssf.usermodel.XSSFWorkbook(fis);
//			}
//			
////			workbook = new org.apache.poi.xssf.usermodel.XSSFWorkbook(fis);
//			org.apache.poi.ss.usermodel.Sheet sheet = workbook.getSheetAt(0);
//			totalCount = sheet.getLastRowNum();
//			log.info("@@@@@@@@@@@ rows = {}", totalCount);			
//			for(int i=1; i<= totalCount; i++) {
//				UserInfo userInfo = null;
//				try {
//					List<Object> excelObject = new ArrayList<Object>();
//					Row row = sheet.getRow(i);
//					for(int j=0; j<EXCEL_UPLOAD_USER_COLUMN; j++) {					
//						Cell cell = row.getCell(j, Row.RETURN_BLANK_AS_NULL);
//						if(cell == null) {
//							excelObject.add("");
//						} else {
//							switch(cell.getCellType()) {
//								case Cell.CELL_TYPE_STRING:
//									excelObject.add(cell.getStringCellValue().trim());
//									break;
//								case Cell.CELL_TYPE_NUMERIC:
//									excelObject.add(Long.toString((long) cell.getNumericCellValue()));
//									break;
//							}
//						}
//					}
//					
//					userInfo = getUserInfoFromPoi(passwordCreateWithUserId, passwordCreateChar, excelObject);
//					fileParseLog.setIdentifier_value(userInfo.getUser_id());
//					fileParseLog.setStatus(FileParseLog.EXCEL_PARSE_SUCCESS);
//					parseSuccessCount++;
//				} catch(Exception e) {
//					e.printStackTrace();
//					parseErrorCount++;
//					if(userInfo == null || userInfo.getUser_id() == null || "".equals(userInfo.getUser_id())) {
//						fileParseLog.setIdentifier_value("ADMIN_ERROR_ID");
//					} else {
//						fileParseLog.setIdentifier_value(userInfo.getUser_id());
//					}
//					fileParseLog.setStatus(FileParseLog.EXCEL_PARSE_FAIL);
//					fileParseLog.setError_code(e.getMessage());
//				}
//				
//				if(userInfo != null) {
//					// TODO user_id 가 문제 생길때 어떻게 해야 하지?
//					fileMapper.insertFileParseLog(fileParseLog);
//					userList.add(userInfo);				
//				}
//			}                         
//			workbook.close();
//			fis.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//			throw new RuntimeException("사용자 일괄 등록(POI) 파일 파싱 오류!");
//		} finally {
//			if(workbook != null) { try { workbook.close(); } catch(Exception e) { e.printStackTrace(); } }
//			if(fis != null) { try { fis.close(); } catch(Exception e) { e.printStackTrace(); } }
//		}
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("userList", userList);
//		result.put("totalCount", totalCount);
//		result.put("parseSuccessCount", parseSuccessCount);
//		result.put("parseErrorCount", parseErrorCount);
//		return result;
//	}
	
//	/**
//	 * POI를 이용해서 사용자 정보를 파싱
//	 * @param passwordCreateWithUserId 환경 설정에 있는 패스워드 생성 방법중 사용자 아디를 사용하는지 여부를 결정
//	 * @param passwordCreateChar 환경설정에 있는 패스워드 초기화 문자
//	 * @param excelObject
//	 * @return
//	 */
//	private UserInfo getUserInfoFromPoi(boolean passwordCreateWithUserId, String passwordCreateChar, List<Object> excelObject) throws Exception {
//		
//		UserInfo userInfo = new UserInfo();
////		int sizeOfArrayList = excelObject.size();
//		
//		// 1 사용자 아이디
//		String userId = (String)excelObject.get(0);
//		userInfo.setUser_id(userId);
//		// 2 그룹 아이디
//		userInfo.setUser_group_id(Long.valueOf((String)excelObject.get(1)));
//		// 3 이름
//		userInfo.setUser_name((String)excelObject.get(2));
//		String salt = SHA256.getSalt();
//		String password = null;
//		if(passwordCreateWithUserId) {
//			password = SHA256.getPassword(userId + passwordCreateChar, salt);
//		} else {
//			password = SHA256.getPassword(passwordCreateChar, salt);
//		}
//		userInfo.setSalt(salt);
//		userInfo.setPassword(password);
//		// 4 핸드폰
//		String mobilePhone = StringUtil.getDefaultValue((String)excelObject.get(3));
////		userInfo.setMobile_phone(mobilePhone.replace("-", ""));
//		userInfo.setMobile_phone(mobilePhone);
//		// 5 이메일
//		userInfo.setEmail(StringUtil.getDefaultValue((String)excelObject.get(4)));
//		// 6 사번 
//		userInfo.setEmp_no(StringUtil.getDefaultValue((String)excelObject.get(5)));
//		// 7 부서명
//		userInfo.setDept_name(StringUtil.getDefaultValue((String)excelObject.get(6)));
//		// 8 직급
//		userInfo.setPosition(StringUtil.getDefaultValue((String)excelObject.get(7)));
//		// 9 사용자 아이디 사용 시작일
//		String userIdStartDate = StringUtil.getDefaultValue((String)excelObject.get(8));
//		if(userIdStartDate.length() > 0) userIdStartDate += "000000";
//		userInfo.setUser_id_start_date(userIdStartDate);
//		// 10 사용자 아이디 사용 종료일
//		String userIdEndDate = StringUtil.getDefaultValue((String)excelObject.get(9));
//		if(userIdEndDate.length() > 0) userIdEndDate += "000000";
//		userInfo.setUser_id_end_date(userIdEndDate);
//		// 11 OTP 인증 타입
//		userInfo.setOtp_type(StringUtil.getDefaultValue((String)excelObject.get(10)));
//		// 12 OTP 앱 Key
//		userInfo.setOtp_mobile_app_key(Crypt.encrypt(StringUtil.getDefaultValue((String)excelObject.get(11))));
//		// 13 OTP PIN 번호
//		userInfo.setPin_number(Crypt.encrypt(StringUtil.getDefaultValue((String)excelObject.get(12))));
//		// 14 OTP 사용기간 시작일
//		String otpUserStartDate = StringUtil.getDefaultValue((String)excelObject.get(13));
//		if(otpUserStartDate.length() > 0) otpUserStartDate += "000000";
//		userInfo.setOtp_use_start_date(otpUserStartDate);
//		// 15 OTP 사용기간 종료일
//		String otpUserEndDate = StringUtil.getDefaultValue((String)excelObject.get(14));
//		if(otpUserEndDate.length() > 0) otpUserEndDate += "000000";
//		userInfo.setOtp_use_end_date(otpUserEndDate);
//		
//		String errorCode = parseValidChecker(userInfo);
//		if(StringUtils.isNotEmpty(errorCode)) {
//			throw new Exception(errorCode);
//		}
//		
//		userInfo.setMobile_phone(Crypt.encrypt(userInfo.getMobile_phone()));
//		userInfo.setEmail(Crypt.encrypt(userInfo.getEmail()));
//		
//		return userInfo;
//	}
//	
//	private String parseValidChecker(UserInfo userInfo) throws Exception {
//		
//		// 필수값 체크
//		if(StringUtils.isEmpty(userInfo.getUser_id())) {
//			return "user.user_id.invalid";
//		}
//		if(userInfo.getUser_group_id() == null || userInfo.getUser_group_id().longValue() <= 0l) {
//			return "user.user_group_id.invalid";
//		}
//		if(StringUtils.isEmpty(userInfo.getUser_name())) {
//			return "user.user_name.invalid";
//		}
//		if(StringUtils.isEmpty(userInfo.getPassword())) {
//			return "user.password.invalid";
//		}
//		if(StringUtils.isEmpty(userInfo.getSalt())) {
//			return "user.salt.invalid";
//		}
//		
//		// 옵션값 체크
//		if(StringUtils.isNotEmpty(userInfo.getTelephone())) {
//			if(!WebUtil.isTelePhone(userInfo.getTelephone())) {
//				return "user.telephone.invalid";
//			}
//		}
//		if(StringUtils.isNotEmpty(userInfo.getMobile_phone())) {
//			if(!WebUtil.isMobilePhone(userInfo.getMobile_phone())) {
//				return "user.mobilephone.invalid";
//			}
//		}
//		if(StringUtils.isNotEmpty(userInfo.getEmail())) {
//			if(!WebUtil.isEmail(userInfo.getEmail())) {
//				return "user.email.invalid";
//			}
//		}
//		return null;
//	}
	
	/**
	 * DATA 일괄 등록
	 * @param project_id
	 * @param fileInfo
	 * @return
	 */
	@Transactional
	public FileInfo insertDataFile(Long project_id, FileInfo fileInfo,  String userId) {
		
		// 파일 이력을 저장
		insertFileInfo(fileInfo);
		
		DataFileParser dataFileParser = null;
		if(FileUtil.EXCEL_EXTENSION_XLS.equals(fileInfo.getFile_ext())) {
			// 파일 확장자가 xls 인 경우는 jexcel 로 파싱하고, xlsx 인 경우는 poi 로 파싱함, 6만 5천건 이상은 파싱 불가처리
			//excelParseJExcelServer(fileInfo, request);
		} else if(FileUtil.EXCEL_EXTENSION_XLSX.equals(fileInfo.getFile_ext())) {
			//excelParsePoiData(fileInfo, userId);
		} else if(FileUtil.EXTENSION_JSON.equals(fileInfo.getFile_ext())) {
			dataFileParser = new DataFileJsonParser();
		} else if(FileUtil.EXTENSION_TXT.equals(fileInfo.getFile_ext())) {
		} else {
		}
		Map<String, Object> map = dataFileParser.parse(project_id, fileInfo, userId);
		
		@SuppressWarnings("unchecked")
		List<DataInfo> dataInfoList = (List<DataInfo>) map.get("dataInfoList");
		
		FileParseLog fileParseLog = new FileParseLog();
		fileParseLog.setFile_info_id(fileInfo.getFile_info_id());
		fileParseLog.setLog_type(FileParseLog.DB_INSERT_LOG);
		
		int insertSuccessCount = 0;
		int insertErrorCount = 0;
		Map<String, Long> parentDataKeyMap = new HashMap<>();
		for(DataInfo dataInfo : dataInfoList) {
			try {
				if(dataInfo.getDepth() != 1) {
					dataInfo.setParent(parentDataKeyMap.get(dataInfo.getParent_data_key())); 
				}
				dataService.insertData(dataInfo);
				parentDataKeyMap.put(dataInfo.getData_key(), dataInfo.getData_id());
				insertSuccessCount++;
			} catch(Exception e) {
				e.printStackTrace();
				fileParseLog.setIdentifier_value(fileInfo.getUser_id());
				fileParseLog.setError_code(e.getMessage());
				fileMapper.insertFileParseLog(fileParseLog);
				insertErrorCount++;
			}
		}
		
		fileInfo.setTotal_count((Integer) map.get("totalCount"));
		fileInfo.setParse_success_count((Integer) map.get("parseSuccessCount"));
		fileInfo.setParse_error_count((Integer) map.get("parseErrorCount"));
		fileInfo.setInsert_success_count(insertSuccessCount);
		fileInfo.setInsert_error_count(insertErrorCount);
		fileMapper.updateFileInfo(fileInfo);
		
		return fileInfo;
	}
	
//	/**
//	 * 서버 일괄 등록 Excel 파일 확장자가 xls일 경우 JExcel 을 이용하여 파싱
//	 * @param fileInfo
//	 * @return
//	 */
//	private Map<String, Object> excelParseJExcelServer(FileInfo fileInfo, MultipartHttpServletRequest request) {
//		
//		int totalCount = 0;
//		int parseSuccessCount = 0;
//		int parseErrorCount = 0;
//		List<Server> serverList = new ArrayList<Server>();		
//		jxl.Workbook workBook = null;
//		try {
//			File file = new File(fileInfo.getFile_path() + fileInfo.getFile_real_name());
//			workBook = jxl.Workbook.getWorkbook(file);
//			Sheet sheet = workBook.getSheet(0);
//			totalCount = sheet.getRows();
//			
//			FileParseLog fileParseLog = new FileParseLog();
//			fileParseLog.setFile_info_id(fileInfo.getFile_info_id());
//			fileParseLog.setLog_type(FileParseLog.FILE_PARSE_LOG);
//			for(int i = 1; i < totalCount; i++) {
//				Server server = null;
//				UserSession userSession = (UserSession)request.getSession().getAttribute(UserSession.KEY);
//				try {
//					server = getServerFromJExcel(i, sheet);
//					String errorCode = parseValidCheckerServer(server);
//					if(StringUtils.isNotEmpty(errorCode)) {
//						throw new Exception(errorCode);
//					}
//					fileParseLog.setIdentifier_value(userSession.getUser_id());
//					fileParseLog.setStatus(FileParseLog.EXCEL_PARSE_SUCCESS);
//					parseSuccessCount++;
//				} catch(Exception e) {
//					e.printStackTrace();
//					parseErrorCount++;
//					if(userSession == null || userSession.getUser_id() == null || "".equals(userSession.getUser_id())) {
//						fileParseLog.setIdentifier_value("ADMIN_ERROR_ID");
//					} else {
//						fileParseLog.setIdentifier_value(userSession.getUser_id());
//					}
//					fileParseLog.setStatus(FileParseLog.EXCEL_PARSE_FAIL);
//					fileParseLog.setError_code(e.getMessage());
//				}
//				
//				if(userSession != null) {
//					// TODO user_id 가 문제 생길때 어떻게 해야 하지?
//					fileMapper.insertFileParseLog(fileParseLog);
//					serverList.add(server);
//				}
//			}
//			workBook.close();
//		} catch(Exception e) {
//			e.printStackTrace();
//			throw new RuntimeException("서버 일괄 등록(JExcel) 파일 파싱 오류!");
//		} finally {
//			if(workBook != null) workBook.close();
//		}
//		
//		Map<String, Object> result = new HashMap<String, Object>();
//		result.put("serverList", serverList);
//		result.put("totalCount", totalCount);
//		result.put("parseSuccessCount", parseSuccessCount);
//		result.put("parseErrorCount", parseErrorCount);
//		return result;
//	}
	
//	/**
//	 * JExcel 을 이용해서 서버 정보를 파싱
//	 * @param i
//	 * @param sheet
//	 * @return
//	 */
//	private Server getServerFromJExcel(int i, Sheet sheet) {
//		
//		String apiKey = createApiKey();
//		int sizeOfSheet = sheet.getColumns();
//		
//		Server server = new Server();
//		server.setApi_key(Crypt.encrypt(apiKey));
//		server.setSync_yn(Server.USE_N);
//		server.setUse_yn(Server.USE_N);
//		server.setServer_name(StringUtil.getDefaultValue(sheet.getCell(0, i).getContents()));
//		server.setServer_ip(StringUtil.getDefaultValue(sheet.getCell(1, i).getContents()));
//		if(sizeOfSheet > 2) {
//			server.setServer_group_id(Long.valueOf(StringUtil.getDefaultValue(sheet.getCell(2, i).getContents())));
//		}
//		if(sizeOfSheet > 3) {
//			server.setSsh_key_path(StringUtil.getDefaultValue(sheet.getCell(3, i).getContents()));
//		}
//		if(sizeOfSheet > 4) {
//			server.setDescription(StringUtil.getDefaultValue(sheet.getCell(4, i).getContents()));
//		}
//		
//		return server;
//	}
	
	/**
	 * POI를 이용해서 서버 정보를 파싱
	 * @param excelObject
	 * @return
	 */
	private DataInfo getDataInfoFromPoi(List<Object> excelObject) {
		
		DataInfo dataInfo = new DataInfo();
//		dataInfo.setData_key((String)excelObject.get(0));
//		//dataInfo.setData_group_id(Long.valueOf((String)excelObject.get(1)));
//		dataInfo.setData_name(StringUtil.getDefaultValue((String)excelObject.get(2)));
//		dataInfo.setLatitude(StringUtil.getDefaultValue((String)excelObject.get(3)));
//		dataInfo.setLongitude(StringUtil.getDefaultValue((String)excelObject.get(4)));
//		dataInfo.setLocation("POINT(" + dataInfo.getLongitude() + " " + dataInfo.getLatitude() + ")");
//		log.info("@@@@@@@@@ location = {}", dataInfo.getLocation());
//		dataInfo.setHeight(StringUtil.getDefaultValue((String)excelObject.get(5)));
//		dataInfo.setHeading(StringUtil.getDefaultValue((String)excelObject.get(6)));
//		dataInfo.setPitch(StringUtil.getDefaultValue((String)excelObject.get(7)));
//		dataInfo.setRoll(StringUtil.getDefaultValue((String)excelObject.get(8)));
		
		return dataInfo;
	}
	
	private String parseValidCheckerData(DataInfo dataInfo) throws Exception {

//		// 필수값 체크
//		if(StringUtil.isEmpty(dataInfo.getServer_name())) {
//			return "server.server_name.invalid";
//		}
//		if(StringUtil.isEmpty(dataInfo.getServer_ip()) || !WebUtil.isIP(server.getServer_ip()) || (serverService.getDuplicationServerIpCount(server.getServer_ip()) > 0)) {
//			return "server.server_ip.invalid";
//		}
//		if(StringUtil.isEmpty(dataInfo.getApi_key())) {
//			return "server.api_key.invalid";
//		}
//		
		return null;
	}
	
	private String createApiKey() {
		String uuid = null;
		try {		
			uuid = UUID.randomUUID().toString();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return uuid;
	}
}
