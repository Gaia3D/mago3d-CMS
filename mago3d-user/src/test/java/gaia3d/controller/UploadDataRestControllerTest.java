package gaia3d.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import org.junit.jupiter.api.Disabled;

import lombok.extern.slf4j.Slf4j;
import gaia3d.domain.uploaddata.UploadDataType;
import gaia3d.domain.FileType;
import gaia3d.domain.uploaddata.UploadDataFile;
import gaia3d.utils.FileUtils;

@Slf4j
class UploadDataRestControllerTest {
	
	// 파일 copy 시 버퍼 사이즈
	public static final int BUFFER_SIZE = 8192;
	public static List<String> uploadTypeList = new ArrayList<>(
		Arrays.asList(
			"zip",
			"citygml",
			"gml",
			"jpg",
			"gif",
			"png"
		)
	);
	
	public static List<String> converterTypeList= new ArrayList<>(
		Arrays.asList(
			"citygml",
			"gml"
		)
	);

	//@Test
	@Disabled
	void 압축파일_업로드_버그수정() {
		File uploadedFile = new File("d:\\01.zip");
		
		// input directory 생성
		String targetDirectory = "D:\\" + System.nanoTime() + File.separator;
		FileUtils.makeDirectory(targetDirectory);
		
		String dataType = "citygml";
		
		// converter 변환 대상 파일 수
		int converterTargetCount = 0;
		List<UploadDataFile> uploadDataFileList = new ArrayList<>();
		
		int count = 0;
		try ( ZipFile zipFile = new ZipFile(uploadedFile);) {
			
			String directoryPath = targetDirectory;
			String subDirectoryPath = "";
			String directoryName = null;
			int depth = 1;
			Enumeration<? extends ZipEntry> entries = zipFile.entries();
			
			while( entries.hasMoreElements() ) {
            	UploadDataFile uploadDataFile = new UploadDataFile();
            	
            	ZipEntry entry = entries.nextElement();
            	String unzipfileName = targetDirectory + entry.getName();
            	Boolean converterTarget = false;
            	
            	log.info(" ==============> {}, unzipfileName = {}", count, unzipfileName);
            	if( entry.isDirectory() ) {
            		log.info(" ***** directory. directoryName = {}, ", directoryName);
            		// 디렉토리인 경우
            		uploadDataFile.setFileType(FileType.DIRECTORY.name());
            		if(directoryName == null) {
            			uploadDataFile.setFileName(entry.getName());
            			uploadDataFile.setFileRealName(entry.getName());
            			directoryName = entry.getName();
            			directoryPath = directoryPath + directoryName;
            			//subDirectoryPath = directoryName;
            		} else {
            			String fileName = null;
            			if(entry.getName().indexOf(directoryName) >=0) {
            				fileName = entry.getName().substring(entry.getName().indexOf(directoryName) + directoryName.length());  
            			} else {
            				// 이전이 디렉토리, 현재도 디렉토리인데 서로 다른 디렉토리
            				if(directoryPath.indexOf(directoryName) >=0) {
            					directoryPath = directoryPath.replace(directoryName, "");
            					directoryName = null;
            				}
            				fileName = entry.getName();
            			}
            			log.info("===== filename = {}", fileName);
            			uploadDataFile.setFileName(fileName);
            			uploadDataFile.setFileRealName(fileName);
            			directoryName = fileName;
            			directoryPath = directoryPath + fileName;
            			subDirectoryPath = fileName;
            		}
            		
            		log.info("==== directoryPath = {}, subDirectoryPath = {} ", directoryPath, subDirectoryPath);
            		
                	File file = new File(unzipfileName);
                    file.mkdirs();
                    uploadDataFile.setFilePath(directoryPath);
                    uploadDataFile.setFileSubPath(subDirectoryPath);
                    uploadDataFile.setDepth(depth);
                    depth++;
            	} else {
            		log.info(" ***** file, directoryName = {}", directoryName);
            		// 파일인 경우
            		String fileName = null;
            		String extension = null;
            		String[] divideFileName = null;
            		String saveFileName = null;
            		
            		// TODO zip 파일도 확장자 validation 체크를 해야 함
            		if(directoryName == null) {
            			fileName = entry.getName();
            			divideFileName = fileName.split("\\.");
            			saveFileName = fileName;
            			if(divideFileName != null && divideFileName.length != 0) {
            				extension = divideFileName[divideFileName.length - 1];
            				if(uploadTypeList.contains(extension.toLowerCase())) {
            					if(converterTypeList.contains(extension.toLowerCase())) {
            						if(!dataType.equalsIgnoreCase(extension)) {
                						// 데이터 타입과 업로딩 파일 확장자가 같지 않고
                						if(	UploadDataType.CITYGML == UploadDataType.findBy(dataType)
                								&& UploadDataType.GML.getValue().equalsIgnoreCase(extension)){
                							// 데이터 타입은 citygml 인데 확장자는 gml 인 경우 통과
                						} else if(UploadDataType.INDOORGML == UploadDataType.findBy(dataType)
                								&& UploadDataType.GML.getValue().equalsIgnoreCase(extension)) {
                							// 데이터 타입은 indoorgml 인데 확장자는 gml 인 경우 통과
                						} else {
                							// 전부 예외
                							log.info("@@@@@@@@@@@@ datatype = {}, extension = {}", dataType, extension);
                						}
                					}
            						
            						if (UploadDataType.CITYGML.getValue().equalsIgnoreCase(dataType) && UploadDataType.GML.getValue().equalsIgnoreCase(extension)) {
                						extension = UploadDataType.CITYGML.getValue();
                					} else if (UploadDataType.INDOORGML.getValue().equalsIgnoreCase(dataType) && UploadDataType.GML.getValue().equalsIgnoreCase(extension)) {
                						extension = UploadDataType.INDOORGML.getValue();
                					}
            						// 변환 대상 파일만 이름을 변경하고 나머지 파일은 그대로 이름 유지
            						saveFileName = System.nanoTime() + "." + extension;
            						converterTarget = true;
            						converterTargetCount++;
            					}
	        				}
            			}
            			log.info("==== fileName = {} ", fileName);
            		} else {
            			if(entry.getName().indexOf(directoryName) >= 0) {
            				// 디렉토리내 파일의 경우
            				fileName = entry.getName().substring(entry.getName().indexOf(directoryName) + directoryName.length());  
            			} else {
            				fileName = entry.getName();
            				if(directoryPath.indexOf(directoryName) >= 0) {
            					directoryPath = directoryPath.replace(directoryName, "");
            					directoryName = null;
            				}
            			}
            			divideFileName = fileName.split("\\.");
            			saveFileName = fileName;
            			if(divideFileName != null && divideFileName.length != 0) {
            				extension = divideFileName[divideFileName.length - 1];
            				if(uploadTypeList.contains(extension.toLowerCase())) {
            					if(converterTypeList.contains(extension.toLowerCase())) {
            						if(!dataType.equalsIgnoreCase(extension)) {
                						// 데이터 타입과 업로딩 파일 확장자가 같지 않고
                						if(	UploadDataType.CITYGML == UploadDataType.findBy(dataType)
                								&& UploadDataType.GML.getValue().equalsIgnoreCase(extension)){
                							// 데이터 타입은 citygml 인데 확장자는 gml 인 경우 통과
                						} else if(UploadDataType.INDOORGML == UploadDataType.findBy(dataType)
                								&& UploadDataType.GML.getValue().equalsIgnoreCase(extension)) {
                							// 데이터 타입은 indoorgml 인데 확장자는 gml 인 경우 통과
                						} else {
                							// 전부 예외
                							log.info("@@@@@@@@@@@@ datatype = {}, extension = {}", dataType, extension);
                						}
                					}
            						
            						if (UploadDataType.CITYGML.getValue().equalsIgnoreCase(dataType) && UploadDataType.GML.getValue().equalsIgnoreCase(extension)) {
                						extension = UploadDataType.CITYGML.getValue();
                					} else if (UploadDataType.INDOORGML.getValue().equalsIgnoreCase(dataType) && UploadDataType.GML.getValue().equalsIgnoreCase(extension)) {
                						extension = UploadDataType.INDOORGML.getValue();
                					}
            						// 변환 대상 파일만 이름을 변경하고 나머지 파일은 그대로 이름 유지
            						saveFileName = System.nanoTime() + "." + extension;
                					converterTarget = true;
                					converterTargetCount++;
            					}
	        				} else {
	        					// 예외 처리
	        					log.info("@@ file.ext.invalid. extList = {}, extension = {}", uploadTypeList, fileName);
	        				}
            			}
            			log.info("==== fileName = {} ", fileName);
            		}
            		
            		long size = 0L;
                	try ( 	InputStream inputStream = zipFile.getInputStream(entry);
                			FileOutputStream outputStream = new FileOutputStream(directoryPath + saveFileName); ) {
                		
                		int bytesRead = 0;
                        byte[] buffer = new byte[BUFFER_SIZE];
                        while ((bytesRead = inputStream.read(buffer, 0, BUFFER_SIZE)) != -1) {
                            size += bytesRead;
                            outputStream.write(buffer, 0, bytesRead);
                        }
                        
                		uploadDataFile.setFileType(FileType.FILE.name());
                		uploadDataFile.setFileExt(extension);
                		uploadDataFile.setFileName(fileName);
                		uploadDataFile.setFileRealName(saveFileName);
                		uploadDataFile.setFilePath(directoryPath);
                		uploadDataFile.setFileSubPath(subDirectoryPath);
                		uploadDataFile.setDepth(depth);
                		uploadDataFile.setFileSize(String.valueOf(size));
                		
                    } catch(Exception e) {
                    	e.printStackTrace();
                    	uploadDataFile.setErrorMessage(e.getMessage());
                    }
                }
            	
            	uploadDataFile.setConverterTarget(converterTarget);
            	uploadDataFile.setFileSize(String.valueOf(entry.getSize()));
            	uploadDataFileList.add(uploadDataFile);
            	
            	System.out.println();
            	count++;
            }
		} catch(IOException ex) {
			ex.printStackTrace(); 
		}
	}

}
