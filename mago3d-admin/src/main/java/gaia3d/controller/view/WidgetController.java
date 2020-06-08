package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gaia3d.domain.ConverterJob;
import gaia3d.domain.ConverterJobFile;
import gaia3d.domain.DataInfo;
import gaia3d.domain.UserInfo;
import gaia3d.domain.UserStatus;
import gaia3d.service.ConverterService;
import gaia3d.service.DataService;
import gaia3d.service.UserService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/widget")
public class WidgetController {
	
	@Autowired private UserService userService;
	@Autowired private DataService dataService;
	@Autowired private ConverterService converterService;

	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest reuqet, Model model) {
		// 위젯 1: 사용자 상태별 현황 
		UserInfo userInfo = new UserInfo();
		userInfo.setStatus("0");
		Long activeUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("2");
		Long fobidUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("3");
		Long failUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("4");
		Long sleepUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("5");
		Long expireUserTotalCount = userService.getUserTotalCount(userInfo);
		userInfo.setStatus("6");
		Long tempPasswordUserTotalCount = userService.getUserTotalCount(userInfo);
		
		// 위젯 2: 데이터 그룹 공유 타입
		DataInfo dataSharing = new DataInfo();
		dataSharing.setSharing("common");
		Long commonTotalCount = dataService.getDataTotalCount(dataSharing);
		dataSharing.setSharing("public");
		Long publicTotalCount = dataService.getDataTotalCount(dataSharing);
		dataSharing.setSharing("private");
		Long privateTotalCount = dataService.getDataTotalCount(dataSharing);
		dataSharing.setSharing("group");
		Long groupTotalCount = dataService.getDataTotalCount(dataSharing);

		// 위젯 3: 데이터 변환 상태
		ConverterJob converterJob = new ConverterJob();
		converterJob.setStatus("ready");
		long readyFileTotalCount = converterService.getConverterJobTotalCount(converterJob);
		converterJob.setStatus("success");
		long successFileTotalCount = converterService.getConverterJobTotalCount(converterJob);
		converterJob.setStatus("waiting");
		long waitingFileTotalCount = converterService.getConverterJobTotalCount(converterJob);
		converterJob.setStatus("fail");
		long failFileTotalCount = converterService.getConverterJobTotalCount(converterJob);

		// 위젯 4: 데이터 업로드 타입
		DataInfo dataType = new DataInfo();
		dataType.setDataType("3ds");
		long type3dsTotalCount = dataService.getDataTotalCount(dataType);
		dataType.setDataType("obj");
		long typeObjTotalCount = dataService.getDataTotalCount(dataType);
		dataType.setDataType("dae");
		long typeDaeTotalCount = dataService.getDataTotalCount(dataType);
		dataType.setDataType("collada");
		long typeColladaTotalCount = dataService.getDataTotalCount(dataType);
		dataType.setDataType("ifc");
		long typeIfcTotalCount = dataService.getDataTotalCount(dataType);
		dataType.setDataType("las");
		long typeLasTotalCount = dataService.getDataTotalCount(dataType);
		dataType.setDataType("citygml");
		long typeCitygmlTotalCount = dataService.getDataTotalCount(dataType);
		dataType.setDataType("indoorgml");
		long typeIndoorgmlTotalCount = dataService.getDataTotalCount(dataType);

		// 사용자 상태별 현황
		model.addAttribute("activeUserTotalCount", activeUserTotalCount);
		model.addAttribute("fobidUserTotalCount", fobidUserTotalCount);
		model.addAttribute("failUserTotalCount", failUserTotalCount);
		model.addAttribute("sleepUserTotalCount", sleepUserTotalCount);
		model.addAttribute("expireUserTotalCount", expireUserTotalCount);
		model.addAttribute("tempPasswordUserTotalCount", tempPasswordUserTotalCount);
		// 데이터 그룹 공유 타입
		model.addAttribute("commonTotalCount", commonTotalCount);
		model.addAttribute("publicTotalCount", publicTotalCount);
		model.addAttribute("privateTotalCount", privateTotalCount);
		model.addAttribute("groupTotalCount", groupTotalCount);
		// 데이터 변환 상태
		model.addAttribute("readyFileTotalCount", readyFileTotalCount);
		model.addAttribute("successFileTotalCount", successFileTotalCount);
		model.addAttribute("waitingFileTotalCount", waitingFileTotalCount);
		model.addAttribute("failFileTotalCount", failFileTotalCount);
		// 데이터 업로드 타입
		model.addAttribute("type3dsTotalCount", type3dsTotalCount);
		model.addAttribute("typeObjTotalCount", typeObjTotalCount);
		model.addAttribute("typeDaeTotalCount", typeDaeTotalCount);
		model.addAttribute("typeColladaTotalCount", typeColladaTotalCount);
		model.addAttribute("typeIfcTotalCount", typeIfcTotalCount);
		model.addAttribute("typeLasTotalCount", typeLasTotalCount);
		model.addAttribute("typeCitygmlTotalCount", typeCitygmlTotalCount);
		model.addAttribute("typeIndoorgmlTotalCount", typeIndoorgmlTotalCount);

		return "/widget/modify";
	}
}
