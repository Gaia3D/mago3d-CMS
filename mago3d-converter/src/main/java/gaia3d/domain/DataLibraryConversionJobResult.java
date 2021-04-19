package gaia3d.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;

@ToString(callSuper = true)
@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class DataLibraryConversionJobResult implements Serializable {

    private static final long serialVersionUID = -2611799341055794019L;

    // 지리참조 여부
    private boolean bGeoReferenced;
    // bGeoReferenced가 false일때, bbox
    private float[] bbox;

    // 시작시각
    private String startTime;
    // 종료시각
    private String endTime;

    // 파일명
    private String fileName;
    // 파일전체 경로
    private String fullPath;

    // 실패 시 메세지
    private String message;

    // 성공여부 (success, failure)
    private ConverterJobResultStatus resultStatus;

    // 속성정보
    private String attributes;

    @JsonProperty(value = "bGeoReferenced")
    public boolean getBGeoReferenced() {
        return bGeoReferenced;
    }
    public void setBGeoReferenced(boolean bGeoReferenced) {
        this.bGeoReferenced = bGeoReferenced;
    }

    @JsonProperty(value = "resultStatus")
    public ConverterJobResultStatus getResultStatus() {
        return resultStatus;
    }
    public void setResultStatus(String resultStatus) {
        this.resultStatus = ConverterJobResultStatus.findByStatus(resultStatus);
    }

}