package com.gaia3d.api;

import java.net.URI;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.gaia3d.domain.DataInfo;
import com.gaia3d.service.DataService;

import lombok.extern.slf4j.Slf4j;

/**
 * http://localhost/datas 애 대응
 * @author Cheon JeongDae
 *
 */
@Slf4j
@RestController
@RequestMapping("datas")
public class RESTAPIExampleController {

	@Autowired
	private DataService dataService;
	
	@GetMapping(path= "{dataId}")
	public DataInfo getData(@PathVariable Long dataId) {
		DataInfo dataInfo = dataService.getData(dataId);
		log.info("@@@@@@@@@@@ dataInfo = {}", dataInfo);
		return dataInfo;
	}
	
	@PostMapping
	public ResponseEntity<Void> createData(@Validated @RequestBody DataInfo dataInfo ) {
		// 시퀀스로 생성한 번호가 와야 한다.
		String resourceUri = "http://localhost/datas/" + 1;
		return ResponseEntity.created(URI.create(resourceUri)).build();
	}
	
	@RequestMapping(path="{dataId}", method = RequestMethod.PUT)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void pub(@PathVariable String bookId, @Validated @RequestBody DataInfo dataInfo) {
		
	}
	
}
