package com.gaia3d.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.gaia3d.domain.Policy;

import lombok.extern.slf4j.Slf4j;

/**
 * 압축 해제
 * @author Cheon JeongDae
 *
 */
@Slf4j
public class UnZip {

	public static Map<String, Object> unzip(Policy policy, String userId, MultipartFile multipartFile, String targetDirectory) throws Exception {
		Map<String, Object> result = new HashMap<>();
		String errorCode = validation(policy, multipartFile);
		if(!StringUtils.isEmpty(errorCode)) {
			result.put("errorCode", errorCode);
			return result;
		}
		
		File uploadedFile = new File(targetDirectory + multipartFile.getOriginalFilename());
		multipartFile.transferTo(uploadedFile);
		
		try ( ZipFile zipFile = new ZipFile(uploadedFile);) {
//			String saveFileName = userId + "_" + today + "_" + System.nanoTime() + "." + fileInfo.getFile_ext();
//			long size = 0L;
//			InputStream inputStream = multipartFile.getInputStream();
			
			Enumeration<? extends ZipEntry> entries = zipFile.entries();
            while( entries.hasMoreElements() ) {
            	ZipEntry entry = entries.nextElement();
            	String fileName = targetDirectory + entry.getName();
            	if( entry.isDirectory() ) {
                	log.info("@@@@@@@@@@@@@@@@ directory = {}", fileName);
                    File file = new File(fileName);
                    file.mkdirs();
                } else {
                	try ( 	InputStream inputStream = zipFile.getInputStream(entry);
                			FileOutputStream outputStream = new FileOutputStream(fileName); ) {
                		int data = inputStream.read();
                		while(data != -1){
                			outputStream.write(data);
                            data = inputStream.read();
                        }
                    }
                	log.info("@@@@@@@@@@@@@@@@ file = {}", fileName);
                }
            }
		} catch(IOException ex) {
			ex.printStackTrace(); 
		}
		
		return result;
	}
	
	/**
	 * @param policy
	 * @param multipartFile
	 * @return
	 */
	private static String validation(Policy policy, MultipartFile multipartFile) {
		
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
		String extension = fileNameValues[fileNameValues.length - 1];
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
			return "fileinfo.size.invalid";
		}
		
		return null;
	}
}
