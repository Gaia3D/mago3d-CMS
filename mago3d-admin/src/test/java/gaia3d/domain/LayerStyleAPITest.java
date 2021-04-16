package gaia3d.domain;

import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.jupiter.api.Disabled;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import gaia3d.geospatial.LayerStyleParser;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LayerStyleAPITest {
	
	@Disabled
	public void getLayerList() {
		try {
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders headers = new HttpHeaders();
			// 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
			List<MediaType> acceptList = new ArrayList<>();
			acceptList.add(MediaType.ALL);
			headers.setAccept(acceptList);
			// 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
			headers.setContentType(MediaType.TEXT_XML);
			// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding 
			headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( ("admin:geoserver").getBytes()) );
			
			List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
			//Add the String Message converter
			messageConverters.add(new StringHttpMessageConverter());
			//Add the message converters to the restTemplate
			restTemplate.setMessageConverters(messageConverters);
		    
			HttpEntity<String> entity = new HttpEntity<>(headers);
			
//			String url = "http://localhost:8080/geoserver/rest/workspaces/mago3d/layers";
			String url = "http://192.168.10.9:8080/geoserver/rest/layers";
			ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
			JSONObject layerJson = new JSONObject((String)response.getBody());
			JSONArray layerList = layerJson.getJSONObject("layers").getJSONArray("layer");
			log.info("layerList ================== {} " ,layerList);
			for(int i=0; i < layerList.length(); i++) {
				log.info("layerName =============== {} ", (String) layerList.getJSONObject(i).get("name"));
			}
			log.info("-------- statusCode = {}, body = {}", response.getStatusCodeValue(), response.getBody());
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public void stylesInsert() {
		try {
			RestTemplate restTemplate = new RestTemplate();
			
			HttpHeaders headers = new HttpHeaders();
			// 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
			List<MediaType> acceptList = new ArrayList<>();
			acceptList.add(MediaType.ALL);
			headers.setAccept(acceptList);
			// 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
			headers.setContentType(MediaType.TEXT_XML);
//			headers.setContentType(new MediaType("application", "vnd.ogc.sld+xml"));
			// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding 
			headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( ("admin:geoserver").getBytes()) );
			
			List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
			//Add the String Message converter
			messageConverters.add(new StringHttpMessageConverter());
			//Add the message converters to the restTemplate
			restTemplate.setMessageConverters(messageConverters);
		    
			HttpEntity<String> entity = new HttpEntity<>(getEmptyStyleFile("test_style"),  headers);
			
			String url = "http://localhost:8080/geoserver/rest/workspaces/mago3d/styles";
//			String url = "http://dj.gaia3d.com:19999/geoserver/rest/workspaces/hhi/styles";
			ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.POST, entity, String.class);
			log.info("-------- statusCode = {}, body = {}", response.getStatusCodeValue(), response.getBody());
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateGeoserverLayerStyle() throws Exception {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		// 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
		List<MediaType> acceptList = new ArrayList<>();
		acceptList.add(MediaType.APPLICATION_JSON);
		headers.setAccept(acceptList);
		// 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
		headers.setContentType(new MediaType("application", "vnd.ogc.sld+xml"));
		// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
		headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( ("admin:geoserver").getBytes()) );

		List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
		// Add the String Message converter
		messageConverters.add(new StringHttpMessageConverter());
		// Add the message converters to the restTemplate
		restTemplate.setMessageConverters(messageConverters);
		
		String styleData = getLayerDefaultStyleFileData("polygon");
		LayerStyleParser layerStyleParser = new LayerStyleParser("polygon", "#5F00FF", Float.valueOf(50), "#000000", Float.valueOf(1), styleData.trim());
        layerStyleParser.updateLayerStyle();
		HttpEntity<String> entity = new HttpEntity<>(layerStyleParser.getStyleData(), headers);

		String url = "http://localhost:8080/geoserver/rest/workspaces/mago3d/styles/test_style";
		ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.PUT, entity, String.class);
		log.info("-------- updateGeoserverLayerStyle statusCode = {}, body = {}", response.getStatusCodeValue(),
				response.getBody());
	}
	
	
	public void deleteGeoserverLayer() {
		HttpStatus httpStatus = null;
		try {
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.TEXT_XML);
			// geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
			headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( ("admin:geoserver").getBytes()) );

			List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
			// Add the String Message converter
			messageConverters.add(new StringHttpMessageConverter());
			// Add the message converters to the restTemplate
			RestTemplate restTemplate = new RestTemplate();
			restTemplate.setMessageConverters(messageConverters);

			HttpEntity<String> entity = new HttpEntity<>(headers);

			String url = "http://localhost:8080/geoserver/rest/workspaces/mago3d/styles/layer_poly?recurse=true";
			log.info("-------- url = {}", url);
			ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.DELETE, entity, String.class);
			httpStatus = response.getStatusCode();
		} catch (Exception e) {
			log.info("-------- exception message = {}", e.getMessage());
			httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
		}
	}
	
	private String getLayerDefaultStyleFileData(String geometryType) {
        String layerStyleFileData = null;
        HttpStatus httpStatus = null;
        try {
            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders headers = new HttpHeaders();
            // 클라이언트가 서버에 어떤 형식(MediaType)으로 달라는 요청을 할 수 있는데 이게 Accpet 헤더를 뜻함.
            List<MediaType> acceptList = new ArrayList<>();
            acceptList.add(MediaType.ALL);
            headers.setAccept(acceptList);

            // 클라이언트가 request에 실어 보내는 데이타(body)의 형식(MediaType)를 표현
            headers.setContentType(MediaType.TEXT_XML);
            // geoserver basic 암호화 아이디:비밀번호 를 base64로 encoding
            headers.add("Authorization", "Basic " + Base64.getEncoder().encodeToString( ("admin:geoserver").getBytes()) );

            List<HttpMessageConverter<?>> messageConverters = new ArrayList<HttpMessageConverter<?>>();
            //Add the String Message converter
            messageConverters.add(new StringHttpMessageConverter());
            //Add the message converters to the restTemplate
            restTemplate.setMessageConverters(messageConverters);

            HttpEntity<String> entity = new HttpEntity<>(headers);

            String url = "http://localhost:8080/geoserver/rest/styles/"+geometryType.toLowerCase()+".sld";
            ResponseEntity<?> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            httpStatus = response.getStatusCode();
            layerStyleFileData = response.getBody().toString();
            log.info("-------- getLayerStyle geometry type = {}, statusCode = {}, body = {}", geometryType , response.getStatusCodeValue(), response.getBody());
        } catch(Exception e) {
            log.info("-------- exception message = {}", e.getMessage());
            String message = e.getMessage();
            if(message.indexOf("404") >= 0) {
                httpStatus = HttpStatus.NOT_FOUND;
                layerStyleFileData = null;
            } else {
                httpStatus = HttpStatus.INTERNAL_SERVER_ERROR;
                layerStyleFileData = null;
            }
        }

        return layerStyleFileData;
    }
	
	private String reoloadStyle() {
		StringBuilder builder = new StringBuilder()
				.append("<layer>")
				.append("<enabled>true</enabled>")
				.append("<defaultStyle>")
				.append("<name>layer_lot_number</name>")
				.append("<workspace>hhi</workspace>")
				.append("</defaultStyle>")
				.append("</layer>");
		return builder.toString();
	}
	
	private String getEmptyStyleFile(String layerKey) {
        String fileName = layerKey + ".sld";
        StringBuilder builder = new StringBuilder()
                .append("<style>")
                .append("<name>" + layerKey + "</name>")
                .append("<filename>" + fileName + "</filename>")
                .append("</style>");
        return builder.toString();
    }
	
	private String getPolygon(String styleName, String fill, String stroke, String strokeWidth) {
		StringBuilder builder = new StringBuilder()
				.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ")
				.append("<StyledLayerDescriptor version=\"1.0.0\" ") 
				.append("xsi:schemaLocation=\"http://www.opengis.net/sld StyledLayerDescriptor.xsd\"  ")
				.append("xmlns=\"http://www.opengis.net/sld\"  ")
				.append("xmlns:ogc=\"http://www.opengis.net/ogc\" ") 
				.append("xmlns:xlink=\"http://www.w3.org/1999/xlink\" ") 
				.append("xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"> ")
				.append("<NamedLayer> ")
				.append("<Name>" + styleName + "</Name>")
				.append("<UserStyle> ")
				.append("<Title>Default Polygon</Title>")
				.append("<Abstract>A sample style that draws a polygon</Abstract>")
				.append("<FeatureTypeStyle> ")
				
				.append("<Rule> ")
				.append("<Name>rule1</Name> ")
				.append("<Title>Gray Polygon with Black Outline</Title> ")
				.append("<Abstract>A polygon with a gray fill and a 1 pixel black outline</Abstract> ")
				.append("<PolygonSymbolizer> ")
				.append("<Fill> ")
				.append("<CssParameter name=\"fill\">" + fill + "</CssParameter> ")
				.append("</Fill> ")
				.append("<Stroke> ")
				.append("<CssParameter name=\"stroke\">" + stroke + "</CssParameter> ")
				.append("<CssParameter name=\"stroke-width\">" + strokeWidth + "</CssParameter> ")
				.append("</Stroke> ")
				.append("</PolygonSymbolizer> ")
				.append("</Rule> ")
				.append("</FeatureTypeStyle> ")
				.append("</UserStyle> ")
				.append("</NamedLayer> ")
				.append("</StyledLayerDescriptor> ");
		return builder.toString();
	}
	
	
	private String getPoint(String styleName, String fill, String stroke, String strokeWidth) {
		StringBuilder builder = new StringBuilder()
				.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ")
				.append("<StyledLayerDescriptor version=\"1.0.0\" ") 
				.append("xsi:schemaLocation=\"http://www.opengis.net/sld StyledLayerDescriptor.xsd\"  ")
				.append("xmlns=\"http://www.opengis.net/sld\"  ")
				.append("xmlns:ogc=\"http://www.opengis.net/ogc\" ") 
				.append("xmlns:xlink=\"http://www.w3.org/1999/xlink\" ") 
				.append("xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"> ")
				.append("<NamedLayer> ")
				.append("<Name>" + styleName + "</Name>")
				.append("<UserStyle> ")
				.append("<Title>Default Point</Title>")
				.append("<Abstract>A sample style that draws a point</Abstract>")
				
				.append("<FeatureTypeStyle>")
				.append("<Rule> ")
				.append("<Name>rule1</Name> ")
				.append("<Title>Red Square</Title> ")
				.append("<Abstract>A 6 pixel square with a red fill and no stroke</Abstract> ")
				.append("<PointSymbolizer>")
				.append("<Graphic>")
				.append("<Mark>")
				.append("<WellKnownName>circle</WellKnownName>")
				.append("<Fill>")
				.append("<CssParameter name=\"fill\">" + fill + "</CssParameter>")
				.append("</Fill>")
				.append("<Stroke>")
				.append("<CssParameter name=\"stroke\">" + stroke + "</CssParameter>")
				.append("<CssParameter name=\"stroke-width\">" + strokeWidth + "</CssParameter>")
				.append("</Stroke>")
				.append("</Mark>")
				.append("<Size>6</Size>")
				.append("</Graphic>")
				.append("</PointSymbolizer>")
				.append("</Rule> ")
				.append("</FeatureTypeStyle> ")
				.append("</UserStyle> ")
				.append("</NamedLayer> ")
				.append("</StyledLayerDescriptor> ");
		return builder.toString();
	}
	
	private String getLine(String styleName, String fill, String stroke, String strokeWidth) {
		StringBuilder builder = new StringBuilder()
				.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?> ")
				.append("<StyledLayerDescriptor version=\"1.0.0\" ") 
				.append("xsi:schemaLocation=\"http://www.opengis.net/sld StyledLayerDescriptor.xsd\"  ")
				.append("xmlns=\"http://www.opengis.net/sld\"  ")
				.append("xmlns:ogc=\"http://www.opengis.net/ogc\" ") 
				.append("xmlns:xlink=\"http://www.w3.org/1999/xlink\" ") 
				.append("xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"> ")
				.append("<NamedLayer> ")
				.append("<Name>" + styleName + "</Name>")
				.append("<UserStyle> ")
				.append("<Title>Default Line</Title>")
				.append("<Abstract>A sample style that draws a line</Abstract>")
				.append("<FeatureTypeStyle>")
				.append("<Rule> ")
				.append("<Name>rule1</Name> ")
				.append("<Title>Blue Line</Title> ")
				.append("<Abstract>A solid blue line with a 1 pixel width</Abstract> ")
				.append("<LineSymbolizer>")
				.append("<Stroke>")
				.append("<CssParameter name=\"stroke\">" + stroke + "</CssParameter>")
				.append("<CssParameter name=\"stroke-width\">" + strokeWidth + "</CssParameter>")
				.append("</Stroke>")
				.append("</LineSymbolizer>")
				.append("</Rule> ")
				.append("</FeatureTypeStyle> ")
				.append("</UserStyle> ")
				.append("</NamedLayer> ")
				.append("</StyledLayerDescriptor> ");
		return builder.toString();
	}

}
