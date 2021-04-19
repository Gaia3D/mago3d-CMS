package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import gaia3d.domain.Key;
import gaia3d.domain.cache.CacheManager;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.policy.GeoPolicy;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataService;
import lombok.extern.slf4j.Slf4j;

/**
 * 지도에서 위치 찾기, 보기 등을 위한 공통 클래스
 * @author Jeongdae
 *
 */
@Slf4j
@Controller
@RequestMapping("/map")
public class MapController {
	
    @Autowired
    private DataService dataService;
	@Autowired
	private ObjectMapper objectMapper;
	
	/**
	 * 위치(경도, 위도) 찾기
     * @param request
     * @param dataInfo
     * @param model
     * @return
     */
    @GetMapping(value = "/find-data-point")
    public String findDataPoint(HttpServletRequest request, DataInfo dataInfo, Model model) {
    	log.info("@@@@@@ dataInfo referrer = {}", dataInfo.getReferrer());
    	
    	// list, modify 에서 온것 구분하기 위함
    	String referrer = dataInfo.getReferrer();
        UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
        String userId = userSession.getUserId();
        
//        dataInfo.setUserId(userSession.getUserId());
        dataInfo = dataService.getData(dataInfo);
		String dataInfoJson = "";
		try {
			dataInfoJson = objectMapper.writeValueAsString(dataInfo);
		} catch(JsonProcessingException e) {
			log.info("@@ objectMapper exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
		
		model.addAttribute("referrer", referrer);
		model.addAttribute("dataInfo", dataInfo);
		model.addAttribute("dataInfoJson", dataInfoJson);
		model.addAttribute("owner", userId);
        
        return "/map/find-data-point";
    }
    
    /**
	 * 위치(경도, 위도) 찾기
     * @param request
     * @param model
     * @return
     */
    @GetMapping(value = "/find-point")
    public String findPoint(HttpServletRequest request, Model model) {
    	String referrer = request.getParameter("referrer");
    	model.addAttribute("referrer", referrer);
        return "/map/find-point";
    }
    
    /**
	 * 위치(경도, 위도) 찾기
     * @param request
     * @param model
     * @return
     */
    @GetMapping(value = "/help")
    public String gotoApiHelp(HttpServletRequest request, Model model) {

//        UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
//        UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUserId());
        GeoPolicy geoPolicy = CacheManager.getGeoPolicy();
        try {
            model.addAttribute("geoPolicyJson", objectMapper.writeValueAsString(geoPolicy));
        } catch(JsonProcessingException e) {
			log.info("@@ objectMapper exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
//        
//        model.addAttribute("baseLayers", userPolicy.getBaseLayers());
        
        return "/api-help/layout";
    }
}
