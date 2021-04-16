package gaia3d.support;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.commons.compress.archivers.zip.ZipArchiveEntry;
import org.apache.commons.compress.archivers.zip.ZipArchiveOutputStream;

import gaia3d.domain.common.FileInfo;
import lombok.extern.slf4j.Slf4j;

/**
 * TODO 사용안함. 삭제 예정
 * @author Jeongdae
 *
 */
@Slf4j
public class ZipSupport {

	public static void makeZip(String zipFileName, List<? extends FileInfo> layerFileInfoList) throws Exception {

		// buffer size
		int size = 8192;
		byte[] buf = new byte[size];
		
		// TODO Controller에서 한번 처리를 한 로직이라 replace 불필요
//		zipFileName = zipFileName.replaceAll("/", "");
//		zipFileName = zipFileName.replaceAll("\\", "");
//		zipFileName = zipFileName.replaceAll(".", "");
		zipFileName = zipFileName.replaceAll("&", "");
        try (	FileOutputStream fileOutputStream = new FileOutputStream(zipFileName);
        		BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(fileOutputStream);
        		ZipArchiveOutputStream zipArchiveOutputStream = new ZipArchiveOutputStream(bufferedOutputStream)) {
        	
        	zipArchiveOutputStream.setEncoding("UTF-8");
        	for(FileInfo layerFileInfo : layerFileInfoList) {
        		String fileName = layerFileInfo.getFileRealName();
        		fileName = fileName.replaceAll("&", "");
        		try (	FileInputStream fileInputStream = new FileInputStream(layerFileInfo.getFilePath() + fileName);
        				BufferedInputStream bufferedInputStream = new BufferedInputStream(fileInputStream, size)) {
        			// zip에 넣을 다음 entry 를 가져온다.
        			zipArchiveOutputStream.putArchiveEntry(new ZipArchiveEntry(fileName));
        			
        			int len;
        			while((len = bufferedInputStream.read(buf,0,size)) != -1) {
        				zipArchiveOutputStream.write(buf,0,len);
        			}
        			zipArchiveOutputStream.closeArchiveEntry();
        		} catch(Exception e) {
        			log.info("@@ db.exception. message = {}", e.getMessage());
        			throw new RuntimeException(e.getMessage());
        		}
            }
        } catch(RuntimeException e) {
        	log.info("@@ RuntimeException. message = {}", e.getMessage());
        	throw e;
        } catch(IOException e) {
        	log.info("@@ FileNotFoundException. message = {}", e.getMessage());
        	throw e;
        }
	}
}
