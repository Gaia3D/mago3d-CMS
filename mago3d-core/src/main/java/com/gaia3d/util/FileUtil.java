package com.gaia3d.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.gaia3d.domain.ConverterUploadLog;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UploadDirectoryType;

import lombok.extern.slf4j.Slf4j;
import net.lingala.zip4j.core.ZipFile;

/**
 * TODO N중화 처리를 위해 FTP 로 다른 PM 으로 전송해 줘야 하는데....
 * 
 * 파일 처리 관련 Util
 * @author jeongdae
 *
 */
@Slf4j
public class FileUtil {

	/*
	 * TODO 대용량 엑셀 처리 관련 참조
	 * http://poi.apache.org/spreadsheet/how-to.html#sxssf
	 * 
	 */
	
	// 디렉토리 생성 방법 
	public static final int SUBDIRECTORY_YEAR = 1;
	public static final int SUBDIRECTORY_YEAR_MONTH = 2;
	public static final int SUBDIRECTORY_YEAR_MONTH_DAY = 3;
	
	// 사용자 일괄 등록
	public static final String USER_FILE_UPLOAD = "USER_FILE_UPLOAD";
	// Data 일괄 등록
	public static final String DATA_FILE_UPLOAD = "DATA_FILE_UPLOAD";
	// Issue 등록
	public static final String ISSUE_FILE_UPLOAD = "ISSUE_FILE_UPLOAD";
	// Data Attribute
	public static final String DATA_ATTRIBUTE_UPLOAD = "DATA_ATTRIBUTE_UPLOAD";
	// Data Object Attribute
	public static final String DATA_OBJECT_ATTRIBUTE_UPLOAD = "DATA_OBJECT_ATTRIBUTE_UPLOAD";
	
	// 사용자 일괄 등록의 경우 허용 문서 타입
	public static final String[] USER_FILE_TYPE = {"xlsx", "xls"};
	// 데이터 일괄 등록 문서 타입
	public static final String[] DATA_FILE_TYPE = {"xlsx", "xls", "json", "txt"};
	// issue 등록의 경우 허용 문서 타입
	public static final String[] ISSUE_FILE_TYPE = {"png", "jpg", "jpeg", "gif", "tiff", "xlsx", "xls", "docx", "doc", "pptx", "ppt"};
	// data attribute 허용 문서 타입
	public static final String[] DATA_ATTRIBUTE_FILE_TYPE = {"json", "txt"};
	// data object attribute 허용 문서 타입
	public static final String[] DATA_OBJECT_ATTRIBUTE_FILE_TYPE = {"json", "txt"};
	// json 파일
	public static final String EXTENSION_JSON = "json";
	// txt 파일
	public static final String EXTENSION_TXT = "txt";
	// 엑셀 처리 기본 프로그램
	public static final String EXCEL_EXTENSION_XLS = "xls";
	// JEXCEL이 2007버전(xlsx) 을 읽지 못하기 때문에 POI를 병행해서 사용
	public static final String EXCEL_EXTENSION_XLSX = "xlsx";
	
	// 업로더 가능한 파일 사이즈
	public static final long FILE_UPLOAD_SIZE = 10000000l;
	// 파일 copy 시 버퍼 사이즈
	public static final int BUFFER_SIZE = 8192;
	
	/**
	 * 엑셀 파일 등록 
	 * @param multipartFile
	 * @param jobType
	 * @param directory
	 * @return
	 */
	public static FileInfo upload(MultipartFile multipartFile, String jobType, String directory) {
	
		FileInfo fileInfo = new FileInfo();
		fileInfo.setJob_type(jobType);
		
		// 파일 기본 validation 체크
		fileInfo = fileValidation(multipartFile, fileInfo);
		if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
			return fileInfo;
		}
		
		// 파일을 upload 디렉토리로 복사
		fileInfo = fileCopy(multipartFile, fileInfo, directory);
		
		return fileInfo;
	}
	
	/**
	 * 사용자 파일 등록
	 * @param userId
	 * @param subDirectoryType
	 * @param multipartFile
	 * @param policy
	 * @param directory
	 * @return
	 */
	public static FileInfo userUpload(String userId, int subDirectoryType, MultipartFile multipartFile, Policy policy, String directory) {
		// 파일 기본 validation 체크
		FileInfo fileInfo = userFileValidation(multipartFile, policy);
		if(fileInfo.getError_code() != null && !"".equals(fileInfo.getError_code())) {
			return fileInfo;
		}
		
		// 파일을 upload 디렉토리로 복사
		fileInfo = fileCopy(userId, subDirectoryType, multipartFile, fileInfo, directory);
		
		return fileInfo;
	}
	
	/**
	 * 업로딩 파일에 대한 기본적인 validation 체크. 이름, 확장자, 사이즈
	 * @param multipartFile
	 * @param fileInfo
	 * @return
	 */
	private static FileInfo fileValidation(MultipartFile multipartFile, FileInfo fileInfo) {
		return fileValidation(multipartFile, fileInfo, 0l);
	}
	
	/**
	 * 업로딩 파일에 대한 기본적인 validation 체크. 이름, 확장자, 사이즈
	 * @param multipartFile
	 * @param fileInfo
	 * @return
	 */
	private static FileInfo fileValidation(MultipartFile multipartFile, FileInfo fileInfo, long fileUploadSize) {
		
		// 1 파일 공백 체크
		if(multipartFile == null || multipartFile.getSize() == 0l) {
			log.info("@@ multipartFile is null");
			fileInfo.setError_code("fileinfo.invalid");
			return fileInfo;
		}
		
		// 2 파일 이름
		String fileName = multipartFile.getOriginalFilename();
		if(fileName == null) {
			log.info("@@ fileName is null");
			fileInfo.setError_code("fileinfo.name.invalid");
			return fileInfo;
		} else if(fileName.indexOf("..") >= 0 || fileName.indexOf("/") >= 0) {
			// TODO File.seperator 정규 표현식이 안 먹혀서 이렇게 처리함
			log.info("@@ fileName = {}", fileName);
			fileInfo.setError_code("fileinfo.name.invalid");
			return fileInfo;
		}
		
		// 3 파일 확장자
		String[] fileNameValues = fileName.split("\\.");
		if(fileNameValues.length != 2) {
			log.info("@@ fileNameValues.length = {}, fileName = {}", fileNameValues.length, fileName);
			fileInfo.setError_code("fileinfo.name.invalid");
			return fileInfo;
		}
		if(fileNameValues[0].indexOf(".") >= 0 || fileNameValues[0].indexOf("..") >= 0) {
			log.info("@@ fileNameValues[0] = {}", fileNameValues[0]);
			fileInfo.setError_code("fileinfo.name.invalid");
			return fileInfo;
		}
		String extension = fileNameValues[1];
		List<String> extList = null;
		if(USER_FILE_UPLOAD.equals(fileInfo.getJob_type())) {
			extList = Arrays.asList(USER_FILE_TYPE);
		} else if(DATA_FILE_UPLOAD.equals(fileInfo.getJob_type())) {
			extList = Arrays.asList(DATA_FILE_TYPE);
		} else if(DATA_ATTRIBUTE_UPLOAD.equals(fileInfo.getJob_type())) {
			extList = Arrays.asList(DATA_ATTRIBUTE_FILE_TYPE);
		} else if(DATA_OBJECT_ATTRIBUTE_UPLOAD.equals(fileInfo.getJob_type())) {
			extList = Arrays.asList(DATA_OBJECT_ATTRIBUTE_FILE_TYPE);
		} else {
			extList =  Arrays.asList(ISSUE_FILE_TYPE);
		}
		if(!extList.contains(extension)) {
			log.info("@@ extList = {}, extension = {}", extList, extension);
			fileInfo.setError_code("fileinfo.ext.invalid");
			return fileInfo;
		}
		
		// 4 파일 사이즈
		// TODO data object attribute 파일은 사이즈가 커서 제한을 하지 않음
		if(!DATA_OBJECT_ATTRIBUTE_UPLOAD.equals(fileInfo.getJob_type())) {
			long fileSize = multipartFile.getSize();
			log.info("@@@@@@@@@@@ file size = {} KB", (fileSize / 1000));
			if(fileSize > FILE_UPLOAD_SIZE) {
				log.info("@@ fileSize = {}, limit = {}", fileSize, FILE_UPLOAD_SIZE);
				fileInfo.setError_code("fileinfo.size.invalid");
				return fileInfo;
			}
		}
		
		fileInfo.setFile_name(fileName);
		fileInfo.setFile_ext(extension);
		
		return fileInfo;
	}
	
	/**
	 * 사용자 업로딩 파일에 대한 기본적인 validation 체크. 이름, 확장자, 사이즈
	 * @param multipartFile
	 * @param fileInfo
	 * @return
	 */
	private static ConverterUploadLog userFileValidation(MultipartFile multipartFile, Policy policy) {
		
		ConverterUploadLog uploadLog = new ConverterUploadLog();
		// 1 파일 공백 체크
		if(multipartFile == null || multipartFile.getSize() == 0l) {
			log.info("@@ multipartFile is null");
			uploadLog.setError_code("fileinfo.invalid");
			return uploadLog;
		}
		
		// 2 파일 이름
		String fileName = multipartFile.getOriginalFilename();
//		if(fileName == null) {
//			log.info("@@ fileName is null");
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		} else if(fileName.indexOf("..") >= 0 || fileName.indexOf("/") >= 0) {
//			// TODO File.seperator 정규 표현식이 안 먹혀서 이렇게 처리함
//			log.info("@@ fileName = {}", fileName);
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		}
		
		// 3 파일 확장자
		String[] fileNameValues = fileName.split("\\.");
//		if(fileNameValues.length != 2) {
//			log.info("@@ fileNameValues.length = {}, fileName = {}", fileNameValues.length, fileName);
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		}
//		if(fileNameValues[0].indexOf(".") >= 0 || fileNameValues[0].indexOf("..") >= 0) {
//			log.info("@@ fileNameValues[0] = {}", fileNameValues[0]);
//			uploadLog.setError_code("fileinfo.name.invalid");
//			return uploadLog;
//		}
		// LowerCase로 비교
		String extension = fileNameValues[1];
//		List<String> extList = new ArrayList<String>();
//		if(policy.getUser_upload_type() != null && !"".equals(policy.getUser_upload_type())) {
//			String[] uploadTypes = policy.getUser_upload_type().toLowerCase().split(",");
//			extList = Arrays.asList(uploadTypes);
//		}
//		if(!extList.contains(extension.toLowerCase())) {
//			log.info("@@ extList = {}, extension = {}", extList, extension);
//			uploadLog.setError_code("fileinfo.ext.invalid");
//			return uploadLog;
//		}
		
		// 4 파일 사이즈
		// TODO data object attribute 파일은 사이즈가 커서 제한을 하지 않음
		long fileSize = multipartFile.getSize();
		log.info("@@@@@@@@@@@@@@@@@@@@@@@@@@ user upload file size = {} KB", (fileSize / 1000));
		if( fileSize > (policy.getUser_upload_max_filesize() * 1000000l)) {
			log.info("@@ fileSize = {}, user upload max filesize = {} M", (fileSize / 1000), policy.getUser_upload_max_filesize());
			uploadLog.setError_code("fileinfo.size.invalid");
			return uploadLog;
		}
		
		uploadLog.setFile_name(fileName);
		uploadLog.setFile_ext(extension);
		
		return uploadLog;
	}
	
	private static FileInfo fileCopy(MultipartFile multipartFile, FileInfo fileInfo, String directory) {
		return fileCopy(null, 1, multipartFile, fileInfo, directory);
	}
	
	/**
	 * 파일 복사
	 * @param multipartFile
	 * @param fileInfo
	 * @param targetDirectory
	 * @return
	 */
	private static FileInfo fileCopy(String userId, int subDirectoryType, MultipartFile multipartFile, FileInfo fileInfo, String targetDirectory) {
		
		// 최상위 /upload/user/ 생성
		File rootDirectory = new File(targetDirectory);
		if(!rootDirectory.exists()) {
			rootDirectory.mkdir();
		}
		
		// 현재년 sub 디렉토리 생성
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14);
		String year = today.substring(0,4);
		String month = today.substring(4,6);
		String day = today.substring(6,8);
		String sourceDirectory = targetDirectory;
		
		if(subDirectoryType >= FileUtil.SUBDIRECTORY_YEAR) {
			File yearDirectory = new File(targetDirectory + year);
			if(!yearDirectory.exists()) {
				yearDirectory.mkdir();
			}
			sourceDirectory = targetDirectory + year + File.separator;
		}
		if(subDirectoryType >= FileUtil.SUBDIRECTORY_YEAR_MONTH) {
			File monthDirectory = new File(targetDirectory + year + File.separator + month);
			if(!monthDirectory.exists()) {
				monthDirectory.mkdir();
			}
			sourceDirectory = targetDirectory + year + File.separator + month + File.separator;
		}
		if(subDirectoryType >= FileUtil.SUBDIRECTORY_YEAR_MONTH_DAY) {
			File dayDirectory = new File(targetDirectory + year + File.separator + month + File.separator + day);
			if(!dayDirectory.exists()) {
				dayDirectory.mkdir();
			}
			sourceDirectory = targetDirectory + year + File.separator + month + File.separator + day + File.separator;
		}
		
		String saveFileName = userId + "_" + today + "_" + System.nanoTime() + "." + fileInfo.getFile_ext();
		long size = 0L;
		try (	InputStream inputStream = multipartFile.getInputStream();
				OutputStream outputStream = new FileOutputStream(sourceDirectory + saveFileName)) {
		
			int bytesRead = 0;
			byte[] buffer = new byte[BUFFER_SIZE];
			while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
				size += bytesRead;
				outputStream.write(buffer, 0, bytesRead);
			}
		
			fileInfo.setFile_real_name(saveFileName);
			fileInfo.setFile_size(String.valueOf(size));
			fileInfo.setFile_path(sourceDirectory);
		} catch(Exception e) {
			e.printStackTrace();
			fileInfo.setError_code("fileinfo.copy.exception");
		}

		return fileInfo;
	}
	
	public static String makeDirectory(String userId, UploadDirectoryType uploadDirectoryType, String targetDirectory) {
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14);
		String year = today.substring(0,4);
		String month = today.substring(4,6);
		String day = today.substring(6,8);
		String sourceDirectory = targetDirectory;
		
		File rootDirectory = new File(sourceDirectory);
		if(!rootDirectory.exists()) {
			rootDirectory.mkdir();
		}
		
		// 사용자 디렉토리
		if(UploadDirectoryType.USERID_YEAR.equals(uploadDirectoryType) 
				|| UploadDirectoryType.USERID_YEAR_MONTH.equals(uploadDirectoryType)
				|| UploadDirectoryType.USERID_YEAR_MONTH_DAY.equals(uploadDirectoryType)) {
			sourceDirectory = sourceDirectory + userId + File.separator;
			File userDirectory = new File(sourceDirectory);
			if(!userDirectory.exists()) {
				userDirectory.mkdir();
			}
		}
		
		// 년
		if(UploadDirectoryType.USERID_YEAR.equals(uploadDirectoryType) 
				|| UploadDirectoryType.USERID_YEAR_MONTH.equals(uploadDirectoryType)
				|| UploadDirectoryType.USERID_YEAR_MONTH_DAY.equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR.equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH .equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH_DAY .equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_USERID .equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH_USERID .equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH_DAY_USERID .equals(uploadDirectoryType)) {
			sourceDirectory = sourceDirectory + year + File.separator;
			File yearDirectory = new File(sourceDirectory);
			if(!yearDirectory.exists()) {
				yearDirectory.mkdir();
			}
		}
		
		// 월
		if(UploadDirectoryType.USERID_YEAR_MONTH.equals(uploadDirectoryType)
				|| UploadDirectoryType.USERID_YEAR_MONTH_DAY.equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH .equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH_DAY .equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH_USERID .equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH_DAY_USERID .equals(uploadDirectoryType)) {
			sourceDirectory = sourceDirectory + month + File.separator;
			File monthDirectory = new File(sourceDirectory);
			if(!monthDirectory.exists()) {
				monthDirectory.mkdir();
			}
		}
		
		// 일
		if(UploadDirectoryType.USERID_YEAR_MONTH_DAY.equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH_DAY .equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH_DAY_USERID .equals(uploadDirectoryType)) {
			sourceDirectory = sourceDirectory + day + File.separator;
			File dayDirectory = new File(sourceDirectory);
			if(!dayDirectory.exists()) {
				dayDirectory.mkdir();
			}
		}
		
		// 사용자 디렉토리
		if(UploadDirectoryType.YEAR_USERID.equals(uploadDirectoryType)
				|| UploadDirectoryType.YEAR_MONTH_USERID.equals(uploadDirectoryType) 
				|| UploadDirectoryType.YEAR_MONTH_DAY_USERID .equals(uploadDirectoryType)) {
			sourceDirectory = sourceDirectory + userId + File.separator;
			File userDirectory = new File(sourceDirectory);
			if(!userDirectory.exists()) {
				userDirectory.mkdir();
			}
		}
		
		return sourceDirectory;
	}
}