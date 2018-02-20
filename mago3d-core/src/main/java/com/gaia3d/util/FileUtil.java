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

import com.gaia3d.domain.FileInfo;

import lombok.extern.slf4j.Slf4j;

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
			fileInfo.setError_code("fileinfo.invalid");
			return fileInfo;
		}
		
		// 2 파일 이름
		String fileName = multipartFile.getOriginalFilename();
		if(fileName.indexOf("..") >= 0 || fileName.indexOf("/") >= 0) {
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
	 * 파일 복사
	 * @param multipartFile
	 * @param fileInfo
	 * @param directory
	 * @return
	 */
	private static FileInfo fileCopy(MultipartFile multipartFile, FileInfo fileInfo, String directory) {
		
		log.info("@@@@@@@@@ directory = {}", directory);
		// 최상위 /upload/user/ 생성
		File rootDirectory = new File(directory);
		if(!rootDirectory.exists()) {
			rootDirectory.mkdir();
		}
		
		// 현재년 sub 디렉토리 생성
		String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14);
		String year = today.substring(0,4);
		File yearDirectory = new File(directory + year);
		if(!yearDirectory.exists()) {
			yearDirectory.mkdir();
		}
		
		String saveFileName = today + "_" + System.nanoTime() + "." + fileInfo.getFile_ext();
		
		long size = 0L;
		try (	InputStream inputStream = multipartFile.getInputStream();
				OutputStream outputStream = new FileOutputStream(yearDirectory + File.separator + saveFileName)) {
		
			int bytesRead = 0;
			byte[] buffer = new byte[BUFFER_SIZE];
			while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
				size += bytesRead;
				outputStream.write(buffer, 0, bytesRead);
			}
		
			fileInfo.setFile_real_name(saveFileName);
			fileInfo.setFile_size(String.valueOf(size));
			fileInfo.setFile_path(directory + year + File.separator);
		} catch(Exception e) {
			e.printStackTrace();
			fileInfo.setError_code("fileinfo.copy.exception");
		}

		return fileInfo;
	}
	
	/**
	 * 특정 파일을 읽어 데몬 PID를 확인한다 (PID 존재 유무에 따라 동작 상태도 알 수 있음)
	 * @param fileName
	 * @return
	 */
	public static String getPIDFromFile(String fileName) {
		
		String pid = "";
		try ( FileReader fileReader = new FileReader(fileName); BufferedReader bufferedReader = new BufferedReader(fileReader) ) {
			pid = bufferedReader.readLine();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		log.info("@@@@@@@@ fileName = {}, pid = {}", fileName, pid);
		return pid;
	}
	
	/**
	 * 파일 IP를 읽어 옴
	 * @param fileName
	 * @return
	 */
	public static String getIPFromFile(String fileName) {
		
		String ip = "";
		BufferedReader bufferedReader = null;
		FileReader fileReader = null;
		try {
			fileReader = new FileReader(fileName);
			bufferedReader = new BufferedReader(fileReader);
			ip = bufferedReader.readLine();			
			bufferedReader.close();
			fileReader.close();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(bufferedReader != null) {
				try {
					bufferedReader.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
			if(fileReader != null) {
				try {
					fileReader.close();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		log.info("@@@@@@@@ fileName = {}, ip = {}", fileName, ip);
		return ip;
	}
	
	/**
	 * pid 파일의 process가 실행 중인지 확인
	 * @param pid
	 * @param DAEMON_NAME
	 * @return
	 */
	public static boolean isProcessAlive(String pid, String DAEMON_NAME) {
		// 프로세스가 실행중인지를 판별
		boolean isProcessAlive = false;
		// 프로세스 확인 후 종료
		File processFile = new File("/proc" + File.separator + pid);
		log.info("@@@@@@@ processFile = {}, name = {}, path = {}, pathLength = {}", processFile.getName(), processFile.getAbsolutePath(), processFile.getPath(), processFile.getPath().length());
		if(processFile.exists()) {
			// 파일 읽어서 종료
			File vrrpdFile = new File("/proc" + File.separator + pid + File.separator + "status");
			if(vrrpdFile.exists()) {
				FileReader fileReader = null;
				BufferedReader bufferedReader = null;
				String processName = null;
				try {
					fileReader = new FileReader(vrrpdFile);
					bufferedReader = new BufferedReader(fileReader);
					String line = bufferedReader.readLine();
					if(line != null && !"".equals(line)) {
						String[] fileInfo = line.split(":");
						processName = fileInfo[1].replaceAll(" ", "").trim();
					}
				} catch(Exception e) {
					e.printStackTrace();
					throw new RuntimeException("@@@@@@@ /proc/" + pid + " process status file read error!");
				} finally {
					if(bufferedReader != null) { try { bufferedReader.close(); } catch(Exception e) { e.printStackTrace(); } }
					if(fileReader != null) { try { fileReader.close(); } catch(Exception e) { e.printStackTrace(); } }
				}
				if(DAEMON_NAME.equals(processName)) {
					isProcessAlive = true;
				} else {
					log.info("@@@@@@@@ processName = {}, DAEMON_NAME = {} is different", processName, DAEMON_NAME);
				}
			} else {
				log.info("@@@@@@@ /proc/{} process status file is not exist!", pid);
			}
		} else {
			log.info("@@@@@@@ /proc/{} directory is not exist", pid);
		}
		
		return isProcessAlive;
	}
}