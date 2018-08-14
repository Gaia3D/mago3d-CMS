package com.gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.ConverterLog;
import com.gaia3d.domain.ConverterUploadLog;
import com.gaia3d.domain.FileInfo;
import com.gaia3d.persistence.ConverterUploadMapper;
import com.gaia3d.service.ConverterUploadService;

/**
 * Data upload
 * @author jeongdae
 *
 */
@Service
public class ConverterUploadServiceImpl implements ConverterUploadService {

	@Autowired
	private ConverterUploadMapper converterUploadMapper;
	
	/**
	 * 사용자가 업로드 완료한 파일 총 건수
	 * @param converterUploadLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getListConverterUploadLogTotalCount(ConverterUploadLog converterUploadLog) {
		return converterUploadMapper.getListConverterUploadLogTotalCount(converterUploadLog);
	}
	
	/**
	 * 사용자가 업로드 완료한 파일 목록
	 * @param converterUploadLog
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<ConverterUploadLog> getListConverterUploadLog(ConverterUploadLog converterUploadLog) {
		return converterUploadMapper.getListConverterUploadLog(converterUploadLog);
	}
	
	/**
	 * 업로딩 파일 정보
	 * @param converter_upload_log_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public ConverterUploadLog getConverterUploadLog(Long converter_upload_log_id) {
		return converterUploadMapper.getConverterUploadLog(converter_upload_log_id);
	}
	
	/**
	 * 사용자가 업로딩한 파일 목록을 저장
	 * @param fileList
	 */
	@Transactional
	public void insertFiles(List<FileInfo> fileList) {
		for(FileInfo fileInfo : fileList) {
			converterUploadMapper.insertFileInfo(fileInfo);
		}
	}
	
	/**
	 * f4d converter 변환 횟수 업데이트
	 * @param converterLog
	 */
	@Transactional
	public void updateConverterCount(ConverterLog converterLog) {
		converterUploadMapper.updateConverterCount(converterLog);
	}
}
