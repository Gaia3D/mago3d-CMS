package gaia3d.controller.rest;

import gaia3d.domain.search.SearchParam;
import gaia3d.support.LogMessageSupport;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;

@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping(value = "/search")
public class SearchRestController {

    @GetMapping(value = "/places", produces = "application/json; charset=UTF-8")
    public ResponseEntity<?> searchPlaces(SearchParam searchParam) {
        String url = "http://api.vworld.kr/req/search";
        String requestURI = searchParam.getSearchRequestURI(url);
        log.info("---------------- requestURI = {}", requestURI);
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(new MediaType("application", "json", StandardCharsets.UTF_8));
        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<?> response = ResponseEntity.noContent().build();
        try {
            response = restTemplate.exchange(new URI(requestURI), HttpMethod.GET, entity, String.class);
        } catch (URISyntaxException e) {
            String message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
            LogMessageSupport.printMessage(e, "@@ exception. message = {}", message);
        }
        return response;
    }

}
