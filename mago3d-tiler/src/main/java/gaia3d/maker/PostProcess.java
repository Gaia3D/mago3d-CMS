package gaia3d.maker;

import java.net.URI;
import java.net.URISyntaxException;

import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import gaia3d.config.PropertiesConfig;
import gaia3d.domain.ServerTarget;
import gaia3d.domain.TileInfo;
import gaia3d.support.LogMessageSupport;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class PostProcess {

    private final ObjectMapper objectMapper;
    private final RestTemplate restTemplate;
    private final PropertiesConfig propertiesConfig;

    public void updateTileInfo(TileInfo tileInfo) {
        URI uri;
        try {
            String url = "/api-internal/tilers/" + tileInfo.getTileId();
            uri = getSendURI(propertiesConfig, tileInfo.getServerTarget(), url);
            log.info("##### execute url = {}", url);
            //TileInfo tileInfo = tileMessage.toTileInfo();
            log.info("--------------- updateTileInfo tileInfo = {}", tileInfo);
            restTemplate.put(uri, tileInfo);
        } catch (URISyntaxException e) {
            LogMessageSupport.printMessage(e);
        }
    }

    /**
     * 변환을 수행한 서버(ADMIN, USER)로 전송하기 위해 호출할 URI를 생성
     *
     * @param propertiesConfig propertiesConfig
     * @param serverTarget     serverTarget
     * @param url              url
     * @return 호출할 URI
     * @throws URISyntaxException URISyntaxException
     */
    private URI getSendURI(PropertiesConfig propertiesConfig, ServerTarget serverTarget, String url) throws URISyntaxException {
        URI uri;
        if (ServerTarget.USER == serverTarget) {
            uri = new URI(propertiesConfig.getCmsUserRestServer() + url);
        } else {
            uri = new URI(propertiesConfig.getCmsAdminRestServer() + url);
        }
        return uri;
    }

//    /**
//     * 데이터 변환 로그파일 파싱 및 전송
//     *
//     * @param converterJob     converterJob
//     * @param objectMapper     objectMapper
//     * @param propertiesConfig propertiesConfig
//     * @param restTemplate     restTemplate
//     * @param queueMessage     queueMessage
//     * @throws IOException        IOException
//     * @throws URISyntaxException URISyntaxException
//     */
//    public static void execute(ObjectMapper objectMapper, PropertiesConfig propertiesConfig,
//                               RestTemplate restTemplate, TileMessage tileMessage) throws IOException, URISyntaxException {
//
//        // 1. 로그 파일 파싱
//        ConverterResultLog converterResultLog = parseLogFile(objectMapper, queueMessage.getLogPath());
//        converterResultLog.setConverterJob(converterJob);
//
//        // 4. API 호출
//        String url = "/api-internal/converters/" + converterJob.getConverterJobId() + "/logs";
//        log.info("##### execute url = {}", url);
//        URI uri = getSendURI(propertiesConfig, queueMessage.getServerTarget(), url);
//        try {
//            ResponseEntity<ConverterResultLog> responseEntity = restTemplate.postForEntity(uri, converterResultLog, ConverterResultLog.class);
//            log.info(">>>>>>>>>> status : {}, errorCode : {}", responseEntity.getStatusCode(), Objects.requireNonNull(responseEntity.getBody()).getFailureLog());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }
//
//    /**
//     * API를 호출하여 F4D 변환 결과를 갱신
//     *
//     * @param converterJob     converterJob
//     * @param propertiesConfig propertiesConfig
//     * @param restTemplate     restTemplate
//     */
//    public static void executeException(ConverterJob converterJob, PropertiesConfig propertiesConfig, RestTemplate restTemplate) {
//        URI uri;
//        try {
//            String url = "/api-internal/converters/" + converterJob.getConverterJobId() + "/status";
//            uri = getSendURI(propertiesConfig, converterJob.getServerTarget(), url);
//            log.info("##### executeException url = {}", url);
//            ResponseEntity<ConverterJob> responseEntity = restTemplate.postForEntity(uri, converterJob, ConverterJob.class);
//            log.info(">>>>>>>>>> status : {}", responseEntity.getStatusCode());
//            log.info(">>>>>>>>>> errorCode : {}", Objects.requireNonNull(responseEntity.getBody()).getErrorCode());
//        } catch (URISyntaxException e) {
//            LogMessageSupport.printMessage(e);
//        }
//    }
//
//
//    /**
//     * 로그파일 파싱
//     *
//     * @param objectMapper objectMapper
//     * @param logFilePath  logFilePath
//     * @return 로그파일 파싱 결과
//     * @throws IOException IOException
//     */
//    private static ConverterResultLog parseLogFile(ObjectMapper objectMapper, String logFilePath) throws IOException {
//        if (invalidFilePath(logFilePath))
//            throw new FileNotFoundException("The file in the specified path cannot be found. filePath : [" + logFilePath + "]");
//
//        return objectMapper.readValue(Paths.get(logFilePath).toFile(), ConverterResultLog.class);
//    }
//
//    /**
//     * 전송할 파일의 유효성 검사
//     *
//     * @param filePath filePath
//     * @return 파일 유효성 검사
//     */
//    private static boolean invalidFilePath(String filePath) {
//        boolean result = false;
//        Path sendFilePath = Paths.get(filePath);
//        File sendFile = sendFilePath.toFile();
//        if (!sendFile.exists()) {
//            result = true;
//        }
//        return result;
//    }
}