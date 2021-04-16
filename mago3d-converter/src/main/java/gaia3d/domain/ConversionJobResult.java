package gaia3d.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

@ToString(callSuper = true)
@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class ConversionJobResult implements Serializable {

    private static final long serialVersionUID = 3378990302698130808L;

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

    // 위치정보
    private ConverterLocation[] location;

    // 속성정보
    private String[] attributes;

    // 분리된 F4D 정보
    private String[] splitResult;

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

    // TODO: restTemplate 에 list 를 넘길 수 없어서 일단 이렇게 처리
    public void setLocation(List<ConverterLocation> location) {
        if (location != null) {
            this.location = location.toArray(ConverterLocation[]::new);
        }
    }

    public void setSplitResult(List<String> splitResult) {
        if (splitResult != null) {
            this.splitResult = splitResult.toArray(String[]::new);
        }
    }

    public void setAttributes(List<String> attributes) {
        if (attributes != null) {
            this.attributes = attributes.toArray(String[]::new);
        }
    }


}