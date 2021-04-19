package gaia3d.conversion;

import com.fasterxml.jackson.databind.ObjectMapper;
import gaia3d.config.PropertiesConfig;
import gaia3d.domain.*;
import gaia3d.support.LogMessageSupport;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Objects;

@Slf4j
public class PostProcess {

    /**
     * 데이터 변환 로그파일 파싱 및 전송
     * @param converterJob  converterJob
     * @param objectMapper  objectMapper
     * @param propertiesConfig  propertiesConfig
     * @param restTemplate  restTemplate
     * @param queueMessage  queueMessage
     * @throws IOException  IOException
     * @throws URISyntaxException   URISyntaxException
     */
    public static void execute(ConverterJob converterJob, ObjectMapper objectMapper, PropertiesConfig propertiesConfig,
                               RestTemplate restTemplate, QueueMessage queueMessage) throws IOException, URISyntaxException {

        // 1. 로그 파일 파싱
        ConverterResultLog converterResultLog = parseLogFile(objectMapper, queueMessage.getLogPath());
        converterResultLog.setConverterJob(converterJob);

        // 2. 위치, 속성 파일 파싱
        UploadDataType uploadDataType = queueMessage.getUploadDataType();
        if (UploadDataType.CITYGML == uploadDataType || UploadDataType.INDOORGML == uploadDataType || UploadDataType.LAS == uploadDataType) {
            parseLocationAttributeFile(uploadDataType, objectMapper, queueMessage.getOutputFolder(), converterResultLog);
        }

        // 3. API 호출
        String url = "/api/converters/" + converterJob.getConverterJobId() + "/logs";
        log.info("##### execute url = {}", url);
        URI uri = getSendURI(propertiesConfig, queueMessage.getServerTarget(), url);
        ResponseEntity<ConverterResultLog> responseEntity = restTemplate.postForEntity(uri, converterResultLog, ConverterResultLog.class);
        log.info(">>>>>>>>>> status : {}, errorCode : {}", responseEntity.getStatusCode(), Objects.requireNonNull(responseEntity.getBody()).getFailureLog());
    }

    /**
     * 데이터 라이브러리 로그파일 파싱 및 전송
     * @param dataLibraryConverterJob
     * @param objectMapper  objectMapper
     * @param propertiesConfig  propertiesConfig
     * @param restTemplate  restTemplate
     * @param queueMessage  queueMessage
     * @throws IOException  IOException
     * @throws URISyntaxException   URISyntaxException
     */
    public static void execute(DataLibraryConverterJob dataLibraryConverterJob, ObjectMapper objectMapper, PropertiesConfig propertiesConfig,
                               RestTemplate restTemplate, QueueMessage queueMessage) throws IOException, URISyntaxException {

        // 1. 로그 파일 파싱
        DataLibraryConverterResultLog dataLibraryConverterResultLog = parseDataLibraryLogFile(objectMapper, queueMessage.getLogPath());
        log.info("=========== dataLibraryConverterResultLog = {}", dataLibraryConverterResultLog);
        dataLibraryConverterResultLog.setDataLibraryConverterJob(dataLibraryConverterJob);

        // 3. API 호출
        String url = "/api/data-library-converters/" + dataLibraryConverterJob.getDataLibraryConverterJobId() + "/logs";
        log.info("##### execute url = {}", url);
        URI uri = getSendURI(propertiesConfig, queueMessage.getServerTarget(), url);
        ResponseEntity<DataLibraryConverterResultLog> responseEntity = restTemplate.postForEntity(uri, dataLibraryConverterResultLog, DataLibraryConverterResultLog.class);
        log.info(">>>>>>>>>> status : {}, errorCode : {}", responseEntity.getStatusCode(), Objects.requireNonNull(responseEntity.getBody()).getFailureLog());
    }

    /**
     * API를 호출하여 F4D 변환 결과를 갱신
     * @param converterJob  converterJob
     * @param propertiesConfig  propertiesConfig
     * @param restTemplate  restTemplate
     */
    public static void executeException(ConverterJob converterJob, PropertiesConfig propertiesConfig, RestTemplate restTemplate) {
        URI uri;
        try {
            String url = "/api/converters/" + converterJob.getConverterJobId() + "/status";
            uri = getSendURI(propertiesConfig, converterJob.getServerTarget(), url);
            log.info("##### executeException url = {}", url);
            ResponseEntity<ConverterJob> responseEntity = restTemplate.postForEntity(uri, converterJob, ConverterJob.class);
            log.info(">>>>>>>>>> status : {}", responseEntity.getStatusCode());
            log.info(">>>>>>>>>> errorCode : {}", Objects.requireNonNull(responseEntity.getBody()).getErrorCode());
        } catch (URISyntaxException e) {
            LogMessageSupport.printMessage(e);
        }
    }

    /**
     * API를 호출하여 데이터 라이브러리 변환 결과를 갱신
     * @param dataLibraryConverterJob  converterJob
     * @param propertiesConfig  propertiesConfig
     * @param restTemplate  restTemplate
     */
    public static void executeException(DataLibraryConverterJob dataLibraryConverterJob, PropertiesConfig propertiesConfig, RestTemplate restTemplate) {
        URI uri;
        try {
            String url = "/api/data-library-converters/" + dataLibraryConverterJob.getDataLibraryConverterJobId() + "/status";
            uri = getSendURI(propertiesConfig, dataLibraryConverterJob.getServerTarget(), url);
            log.info("##### executeException url = {}", url);
            ResponseEntity<DataLibraryConverterJob> responseEntity = restTemplate.postForEntity(uri, dataLibraryConverterJob, DataLibraryConverterJob.class);
            log.info(">>>>>>>>>> status : {}", responseEntity.getStatusCode());
            log.info(">>>>>>>>>> errorCode : {}", Objects.requireNonNull(responseEntity.getBody()).getErrorCode());
        } catch (URISyntaxException e) {
            LogMessageSupport.printMessage(e);
        }
    }

    /**
     * 변환을 수행한 서버(ADMIN, USER)로 전송하기 위해 호출할 URI를 생성
     * @param propertiesConfig  propertiesConfig
     * @param serverTarget    serverTarget
     * @param url   url
     * @return 호출할 URI
     * @throws URISyntaxException   URISyntaxException
     */
    private static URI getSendURI(PropertiesConfig propertiesConfig, ServerTarget serverTarget, String url) throws URISyntaxException {
        URI uri;
        if (ServerTarget.USER == serverTarget) {
            uri = new URI(propertiesConfig.getCmsUserRestServer() + url);
        } else {
            uri = new URI(propertiesConfig.getCmsAdminRestServer() + url);
        }
        return uri;
    }

    /**
     * 로그파일 파싱
     * @param objectMapper  objectMapper
     * @param logFilePath  logFilePath
     * @return  로그파일 파싱 결과
     * @throws IOException  IOException
     */
    private static ConverterResultLog parseLogFile(ObjectMapper objectMapper, String logFilePath) throws IOException {
        if (invalidFilePath(logFilePath)) throw new FileNotFoundException("The file in the specified path cannot be found. filePath : [" + logFilePath + "]");

        return objectMapper.readValue(Paths.get(logFilePath).toFile(), ConverterResultLog.class);
    }

    /**
     * 로그파일 파싱
     * @param objectMapper  objectMapper
     * @param logFilePath  logFilePath
     * @return  로그파일 파싱 결과
     * @throws IOException  IOException
     */
    private static DataLibraryConverterResultLog parseDataLibraryLogFile(ObjectMapper objectMapper, String logFilePath) throws IOException {
        log.info("#### logFilePath = {}", logFilePath);
        if (invalidFilePath(logFilePath)) throw new FileNotFoundException("The file in the specified path cannot be found. filePath : [" + logFilePath + "]");

        return objectMapper.readValue(Paths.get(logFilePath).toFile(), DataLibraryConverterResultLog.class);
    }

    /**
     * 위치, 속성 파일 파싱
     * @param uploadDataType
     * @param objectMapper
     * @param outputFolder
     * @param resultLog
     * @throws IOException
     */
    private static void parseLocationAttributeFile(UploadDataType uploadDataType, ObjectMapper objectMapper, String outputFolder, ConverterResultLog resultLog) throws IOException {

        for (ConversionJobResult result : resultLog.getConversionJobResult()) {
            if (ConverterJobResultStatus.SUCCESS != result.getResultStatus()) {
                continue;
            }

            String fileName = result.getFileName();
            String dataKey = fileName.substring(0, fileName.lastIndexOf("."));
            String outputFilePath = outputFolder + File.separator + QueueMessage.F4D_PREFIX + dataKey;
            String locationFilePath = outputFilePath + File.separator + "lonsLats.json";
            String attributeFilePath = outputFilePath + File.separator + "attributes.json";

            if (invalidFilePath(locationFilePath)) throw new FileNotFoundException("The file in the specified path cannot be found.");

            ConverterLocation location = objectMapper.readValue(Paths.get(locationFilePath).toFile(), ConverterLocation.class);
            log.info("longitude = {}, latitude = {}", location.getLongitude(), location.getLatitude());
            result.setLocation(location);

            // File attributeFile = attributeFilePath.toFile();
            // List<Map<String, Object>> attributes = objectMapper.readValue(attributeFile, new TypeReference<>() {});

            if (UploadDataType.CITYGML == uploadDataType || UploadDataType.INDOORGML == uploadDataType) {
                if(!invalidFilePath(attributeFilePath)) {
                    // json 파일을 Object로 변환하여 전송할 예정이였으나, json string으로 DB에 넣기 때문에 string 변경함.
                    byte[] jsonData = Files.readAllBytes(Paths.get(attributeFilePath));
                    String attributes = new String(jsonData, StandardCharsets.UTF_8);
                    log.info(">>>>>>>>>> attributesJson : {}", attributes);
                    result.setAttributes(attributes);
                }
            }
        }
    }

    /**
     * 전송할 파일의 유효성 검사
     * @param filePath  filePath
     * @return 파일 유효성 검사
     */
    private static boolean invalidFilePath(String filePath) {
        boolean result = false;
        Path sendFilePath = Paths.get(filePath);
        File sendFile = sendFilePath.toFile();
        if (!sendFile.exists()) {
            result = true;
        }
        return result;
    }
}