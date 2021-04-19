package gaia3d.controller.api;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.api.APIController;
import gaia3d.domain.agent.ConverterResultLog;
import gaia3d.domain.converter.ConverterJob;
import gaia3d.service.ApiLogService;
import gaia3d.service.ConverterService;
import gaia3d.support.LogMessageSupport;
import gaia3d.utils.LocaleUtils;
import gaia3d.utils.WebUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping(value = "/api-internal/converters")
public class ConverterAPIController implements APIController {

    @Autowired
    private ConverterService converterService;
    @Autowired
    private ApiLogService apiLogService;
    @Autowired
    private MessageSource messageSource;

    @PostMapping(value = "{converterJobId}/status", consumes = "application/json", produces = "application/json")
    public ResponseEntity<ConverterJob> status(@RequestBody ConverterJob converterJob,
                                               @PathVariable("converterJobId") Long converterJobId,
                                               HttpServletRequest request, HttpServletResponse response) {

        HttpStatus statusCode = HttpStatus.OK;
        String errorCode = null;
        String message = null;
        Locale locale = LocaleUtils.getUserLocale(request);

        try {
            log.info(" >>>>>> converterJobId = {}", converterJobId);
            converterService.updateConverterJob(converterJob);
        } catch (DataAccessException e) {
            statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
            errorCode = messageSource.getMessage("db.exception", null, locale);
            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
            LogMessageSupport.printMessage(e, "@@ db.exception. message = {}", message);
        } catch (RuntimeException e) {
            statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
            errorCode = messageSource.getMessage("runtime.exception", null, locale);
            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
            LogMessageSupport.printMessage(e, "@@ runtime.exception. message = {}", message);
        } catch (Exception e) {
            statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
            errorCode = messageSource.getMessage("unknown.exception", null, locale);
            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
            LogMessageSupport.printMessage(e, "@@ exception. message = {}", message);
        }
        converterJob.setErrorCode(errorCode);
        insertLog(apiLogService, WebUtils.getClientIp(request), request.getRequestURL().toString(), statusCode.value(), message);

        return new ResponseEntity<>(converterJob, statusCode);
    }

    @PostMapping(value = "{converterJobId}/logs", consumes = "application/json", produces = "application/json")
    public ResponseEntity<ConverterResultLog> logs(@RequestBody ConverterResultLog converterResultLog,
                                                   @PathVariable("converterJobId") Long converterJobId,
                                                   HttpServletRequest request, HttpServletResponse response) {

        HttpStatus statusCode = HttpStatus.OK;
        String errorCode = null;
        String message = null;
        Locale locale = LocaleUtils.getUserLocale(request);

        try {
            log.info(" >>>>>> converterJobId = {}", converterJobId);
            converterService.updateConverterJobStatus(converterResultLog);
        } catch (DataAccessException e) {
            statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
            errorCode = messageSource.getMessage("db.exception", null, locale);
            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
            LogMessageSupport.printMessage(e, "@@ db.exception. message = {}", message);
        } catch (RuntimeException e) {
            statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
            errorCode = messageSource.getMessage("runtime.exception", null, locale);
            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
            LogMessageSupport.printMessage(e, "@@ runtime.exception. message = {}", message);
        } catch (Exception e) {
            statusCode = HttpStatus.INTERNAL_SERVER_ERROR;
            errorCode = messageSource.getMessage("unknown.exception", null, locale);
            message = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
            LogMessageSupport.printMessage(e, "@@ exception. message = {}", message);
        }
        converterResultLog.setFailureLog(errorCode);
        insertLog(apiLogService, WebUtils.getClientIp(request), request.getRequestURL().toString(), statusCode.value(), message);

        return new ResponseEntity<>(converterResultLog, statusCode);
    }

}