package gaia3d.domain.agent;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import gaia3d.domain.converter.ConverterJob;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

/**
 * TODO: converter 로 합쳐야 함
 */
@ToString(callSuper = true)
@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class ConverterResultLog implements Serializable {

    // TODO: 사용자, 관리자 동시에 들어올 경우 테스트 필요
    private static final long serialVersionUID = 9122521223392537909L;

    private ConverterJob converterJob;

    // ConverterJob 변환결과
    private List<ConversionJobResult> conversionJobResult;

    // 시작시각
    private String startTime;
    // 종료시각
    private String endTime;

    // 실패로그
    private String failureLog;
    // 성공여부
    private boolean isSuccess;

    // 변환된 파일 갯수
    private int numberOfFilesConverted;
    // 변환 되어야 할 파일 갯수
    private int numberOfFilesToBeConverted;

    @JsonProperty(value="isSuccess")
    public boolean getIsSuccess() {
        return isSuccess;
    }
    public void setIsSuccess(boolean isSuccess) {
        this.isSuccess = isSuccess;
    }

}