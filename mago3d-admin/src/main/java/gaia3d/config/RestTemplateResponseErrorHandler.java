package gaia3d.config;
//package gaia3d.config;
//
//import java.io.IOException;
//
//import org.springframework.http.HttpStatus;
//import org.springframework.http.client.ClientHttpResponse;
//import org.springframework.stereotype.Component;
//import org.springframework.web.client.ResponseErrorHandler;
//
//import hmd.exception.NotFoundException;
//import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Component
//public class RestTemplateResponseErrorHandler implements ResponseErrorHandler {
//
//	@Override
//	public boolean hasError(ClientHttpResponse httpResponse) throws IOException {
//
////		log.info("@@@@@@@@@@@@ hasError = {}", httpResponse.getStatusCode().series());
//		return (httpResponse.getStatusCode().series() == HttpStatus.Series.CLIENT_ERROR
//				|| httpResponse.getStatusCode().series() == HttpStatus.Series.SERVER_ERROR);
//	}
//
//	@Override
//	public void handleError(ClientHttpResponse httpResponse) throws IOException {
//
//		log.info("@@@@@@@@@@@@ handleError = {}", httpResponse.getStatusCode().series());
//		if (httpResponse.getStatusCode().series() == HttpStatus.Series.SERVER_ERROR) {
//			// Handle SERVER_ERROR
//		} else if (httpResponse.getStatusCode().series() == HttpStatus.Series.CLIENT_ERROR) {
//			// Handle CLIENT_ERROR
//			if (httpResponse.getStatusCode() == HttpStatus.NOT_FOUND) {
//				throw new NotFoundException();
//			}
//		}
//	}
//}