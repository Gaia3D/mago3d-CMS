package gaia3d.controller.view;

import javax.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.domain.Key;
import gaia3d.domain.data.DataInfo;
import gaia3d.domain.policy.GeoPolicy;
import gaia3d.domain.user.UserPolicy;
import gaia3d.domain.user.UserSession;
import gaia3d.service.DataService;
import gaia3d.service.GeoPolicyService;
import gaia3d.service.UserPolicyService;
import io.micrometer.core.instrument.util.StringUtils;
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
	private GeoPolicyService geoPolicyService;
	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	private UserPolicyService userPolicyService;
	
	/**
	 * 위치(경도, 위도) 찾기
     * @param request
     * @param dataInfo
     * @param model
     * @return
     */
    @GetMapping(value = "/find-data-point")
    public String findDataPoint(HttpServletRequest request, DataInfo dataInfo, Model model) {
    	log.info("@@@@@@ dataInfo = {}, referrer = ", dataInfo.getReferrer());
    	
    	// list, modify 에서 온것 구분하기 위함
    	String referrer = dataInfo.getReferrer();
    	dataInfo = dataService.getData(dataInfo);
		
		String dataInfoJson = "";
		try {
			dataInfoJson = objectMapper.writeValueAsString(dataInfo);
		} catch(JsonProcessingException e) {
			log.info("@@@@@@@@@@@@ jsonProcessing exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}
		
		model.addAttribute("referrer", referrer);
		model.addAttribute("dataInfo", dataInfo);
		model.addAttribute("dataInfoJson", dataInfoJson);
        
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
        return "/map/find-point";
    }

    /**
	 * 위치(경도, 위도) 보기
     * @param request
     * @param model
     * @return
     */
    @GetMapping(value = "/fly-to-point")
    public String flyToPoint(HttpServletRequest request, Model model, @RequestParam(value="readOnly",required=false) Boolean readOnly,
    		@RequestParam(value="longitude",required=false) String longitude, @RequestParam(value="latitude",required=false) String latitude) {

        UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
        UserPolicy userPolicy = userPolicyService.getUserPolicy(userSession.getUserId());
        GeoPolicy geoPolicy = geoPolicyService.getGeoPolicy();
        try {
        	if(!StringUtils.isEmpty(longitude)) {
            	geoPolicy.setInitLongitude(longitude);
        	}
        	if(!StringUtils.isEmpty(latitude)) {
            	geoPolicy.setInitLatitude(latitude);
        	}
        	if(readOnly == null) {
        		readOnly = true;
        	}
            model.addAttribute("geoPolicyJson", objectMapper.writeValueAsString(geoPolicy));
        } catch(JsonProcessingException e) {
			log.info("@@@@@@@@@@@@ jsonProcessing exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
        } catch(DataAccessException e) {
        	log.info("@@@@@@@@@@@@ dataAccess exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(RuntimeException e) {
			log.info("@@@@@@@@@@@@ runtime exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		} catch(Exception e) {
			log.info("@@@@@@@@@@@@ exception. message = {}", e.getCause() != null ? e.getCause().getMessage() : e.getMessage());
		}

        model.addAttribute("readOnly", readOnly);
        model.addAttribute("baseLayers", userPolicy.getBaseLayers());
        return "/map/fly-to-point";
    }
}
