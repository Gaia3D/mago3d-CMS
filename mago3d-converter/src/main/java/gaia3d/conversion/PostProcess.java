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
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

@Slf4j
public class PostProcess {

    /**
     * 데이터 변환 로그파일 파싱 및 전송
     *
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

        // 2. splitInfo 파일 파싱
        UploadDataType uploadDataType = queueMessage.getUploadDataType();
        parserSplitInfo(objectMapper, queueMessage.getOutputFolder(), converterResultLog);

        // 3. 위치, 속성 파일 파싱
        if (UploadDataType.CITYGML == uploadDataType || UploadDataType.INDOORGML == uploadDataType || UploadDataType.LAS == uploadDataType || UploadDataType.OBJ == uploadDataType) {
            parseLocationAttributeFile(uploadDataType, objectMapper, queueMessage.getOutputFolder(), converterResultLog);
        }

        // 4. API 호출
        String url = "/api-internal/converters/" + converterJob.getConverterJobId() + "/logs";
        log.info("##### execute url = {}", url);
        URI uri = getSendURI(propertiesConfig, queueMessage.getServerTarget(), url);
        try {
        ResponseEntity<ConverterResultLog> responseEntity = restTemplate.postForEntity(uri, converterResultLog, ConverterResultLog.class);
        log.info(">>>>>>>>>> status : {}, errorCode : {}", responseEntity.getStatusCode(), Objects.requireNonNull(responseEntity.getBody()).getFailureLog());
        } catch (Exception e) {
            log.info(" execute. message = {} ", e.getMessage());
        }

    }

    /**
     * 데이터 라이브러리 로그파일 파싱 및 전송
     * 
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
        String url = "/api-internal/data-library-converters/" + dataLibraryConverterJob.getDataLibraryConverterJobId() + "/logs";
        log.info("##### execute url = {}", url);
        URI uri = getSendURI(propertiesConfig, queueMessage.getServerTarget(), url);
        ResponseEntity<DataLibraryConverterResultLog> responseEntity = restTemplate.postForEntity(uri, dataLibraryConverterResultLog, DataLibraryConverterResultLog.class);
        log.info(">>>>>>>>>> status : {}, errorCode : {}", responseEntity.getStatusCode(), Objects.requireNonNull(responseEntity.getBody()).getFailureLog());
    }

    /**
     * API를 호출하여 F4D 변환 결과를 갱신
     *
     * @param converterJob  converterJob
     * @param propertiesConfig  propertiesConfig
     * @param restTemplate  restTemplate
     */
    public static void executeException(ConverterJob converterJob, PropertiesConfig propertiesConfig, RestTemplate restTemplate) {
        URI uri;
        try {
            String url = "/api-internal/converters/" + converterJob.getConverterJobId() + "/status";
            uri = getSendURI(propertiesConfig, converterJob.getServerTarget(), url);
            log.info("##### executeException url = {}", url);
            ResponseEntity<ConverterJob> responseEntity = restTemplate.postForEntity(uri, converterJob, ConverterJob.class);
            log.info(">>>>>>>>>> status : {}", responseEntity.getStatusCode());
            log.info(">>>>>>>>>> errorCode : {}", Objects.requireNonNull(responseEntity.getBody()).getErrorCode());
        } catch (URISyntaxException e) {
            log.info(" executeException. message = {} ", e.getMessage());
        }
    }

    /**
     * API를 호출하여 데이터 라이브러리 변환 결과를 갱신
     *
     * @param dataLibraryConverterJob  converterJob
     * @param propertiesConfig  propertiesConfig
     * @param restTemplate  restTemplate
     */
    public static void executeException(DataLibraryConverterJob dataLibraryConverterJob, PropertiesConfig propertiesConfig, RestTemplate restTemplate) {
        URI uri;
        try {
            String url = "/api-internal/data-library-converters/" + dataLibraryConverterJob.getDataLibraryConverterJobId() + "/status";
            uri = getSendURI(propertiesConfig, dataLibraryConverterJob.getServerTarget(), url);
            log.info("##### executeException url = {}", url);
            ResponseEntity<DataLibraryConverterJob> responseEntity = restTemplate.postForEntity(uri, dataLibraryConverterJob, DataLibraryConverterJob.class);
            log.info(">>>>>>>>>> status : {}", responseEntity.getStatusCode());
            log.info(">>>>>>>>>> errorCode : {}", Objects.requireNonNull(responseEntity.getBody()).getErrorCode());
        } catch (URISyntaxException e) {
            log.info(" executeException. message = {} ", e.getMessage());
        }
    }

    /**
     * 변환을 수행한 서버(ADMIN, USER)로 전송하기 위해 호출할 URI를 생성
     *
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
     *
     * @param objectMapper  objectMapper
     * @param logFilePath  logFilePath
     * @return  로그파일 파싱 결과
     * @throws IOException  IOException
     */
    private static ConverterResultLog parseLogFile(ObjectMapper objectMapper, String logFilePath) throws IOException {
        if (invalidFilePath(logFilePath))
            throw new FileNotFoundException("The file in the specified path cannot be found. filePath : [" + logFilePath + "]");

        return objectMapper.readValue(Paths.get(logFilePath).toFile(), ConverterResultLog.class);
    }

    /**
     * 로그파일 파싱
     *
     * @param objectMapper  objectMapper
     * @param logFilePath  logFilePath
     * @return  로그파일 파싱 결과
     * @throws IOException  IOException
     */
    private static DataLibraryConverterResultLog parseDataLibraryLogFile(ObjectMapper objectMapper, String logFilePath) throws IOException {
        log.info("#### logFilePath = {}", logFilePath);
        if (invalidFilePath(logFilePath))
            throw new FileNotFoundException("The file in the specified path cannot be found. filePath : [" + logFilePath + "]");

        return objectMapper.readValue(Paths.get(logFilePath).toFile(), DataLibraryConverterResultLog.class);
    }

    /**
     * 위치, 속성 파일 파싱
     *
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
            String outputFilePath = outputFolder + QueueMessage.F4D_PREFIX + dataKey;

            String[] splitResults = result.getSplitResult();
            List<String> splitResultList = new ArrayList<>();
            splitResultList.add(outputFilePath);
            // F4D 가 분리된 경우
            if (splitResults.length > 1) {
                splitResultList.clear();
                for (String splitKey : splitResults) {
                    splitResultList.add(outputFolder + QueueMessage.F4D_PREFIX + splitKey);
                }
            }
            List<ConverterLocation> locationList = new ArrayList<>();
            List<String> attributeList = new ArrayList<>();
            splitResultList.forEach(f -> {
                try {
                    getLocation(f + File.separator + "lonsLats.json", uploadDataType, objectMapper, locationList);
                    getAttribute(f + File.separator + "attributes.json", uploadDataType, attributeList);
                } catch (IOException e) {
                    LogMessageSupport.printMessage(e);
                }
            });
            if (locationList.size() > 0) result.setLocation(locationList);
            if (attributeList.size() > 0) result.setAttributes(attributeList);
        }
    }

    /**
     * location 정보 파싱
     * @param filePath 파일 경로
     * @param uploadDataType 파일 타입
     * @param objectMapper objectMapper
     * @param locationList location List 객체
     * @throws IOException
     */
    private static void getLocation(String filePath, UploadDataType uploadDataType, ObjectMapper objectMapper, List<ConverterLocation> locationList) throws IOException {
        log.info("locationPath =============== {} ", filePath);
        boolean isLocationFileExist = true;
        if (UploadDataType.OBJ == uploadDataType) {
            if (invalidFilePath(filePath)) {
                isLocationFileExist = false;
                log.info("@@ obj 파일은 좌표계가 없는 경우도 있음");
            }
        } else {
            if (invalidFilePath(filePath))
                throw new FileNotFoundException("The file in the specified path cannot be found.");
        }

        if (isLocationFileExist) {
            ConverterLocation location = objectMapper.readValue(Paths.get(filePath).toFile(), ConverterLocation.class);
            log.info("longitude = {}, latitude = {}", location.getLongitude(), location.getLatitude());
            locationList.add(location);
        }
    }

    /**
     * 속성 정보 파싱
     * @param filePath 파일 경로
     * @param uploadDataType 파일 타입
     * @param attributeList attribute list 객체
     * @throws IOException
     */
    private static void getAttribute(String filePath, UploadDataType uploadDataType, List<String> attributeList) throws IOException {
        log.info("attributePath =============== {} ", filePath);
            if (UploadDataType.CITYGML == uploadDataType || UploadDataType.INDOORGML == uploadDataType) {
            if (!invalidFilePath(filePath)) {
                    // json 파일을 Object로 변환하여 전송할 예정이였으나, json string으로 DB에 넣기 때문에 string 변경함.
                byte[] jsonData = Files.readAllBytes(Paths.get(filePath));
                    String attributes = new String(jsonData, StandardCharsets.UTF_8);
                    log.info(">>>>>>>>>> attributesJson : {}", attributes);
                attributeList.add(attributes);
            }
        }
    }

    /**
     * splitIno 파일 파싱
     *
     * @param objectMapper objectMapper
     * @param outputFolder outputFolder
     * @throws IOException IOException
     */
    private static void parserSplitInfo(ObjectMapper objectMapper, String outputFolder, ConverterResultLog resultLog) throws IOException {
        for (ConversionJobResult result : resultLog.getConversionJobResult()) {
            if (ConverterJobResultStatus.SUCCESS != result.getResultStatus()) {
                continue;
            }

            String fileName = result.getFileName();
            String dataKey = fileName.substring(0, fileName.lastIndexOf("."));
            String splitFilePath = outputFolder + fileName + "_splitInfo.json";
            result.setSplitResult(Collections.singletonList(dataKey));
            // splitInfo.json 파일이 있을때만 read
            if (!invalidFilePath(splitFilePath)) {
                ConverterSplitResult converterSplitResult = objectMapper.readValue(Paths.get(splitFilePath).toFile(), ConverterSplitResult.class);
                List<String> splitResult = new ArrayList<>();
                for (String split : converterSplitResult.getResult()) {
                    splitResult.add(split.substring(QueueMessage.F4D_PREFIX.length()));
                }
                result.setSplitResult(splitResult);
            }
        }
    }

    /**
     * 전송할 파일의 유효성 검사
     *
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