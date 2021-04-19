package gaia3d.domain.agent;

import java.io.Serializable;
import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class ConverterLocation implements Serializable {

    private static final long serialVersionUID = 467269131451829359L;

    // 데이터 키
    private String data_key;
    // 위도
    private BigDecimal latitude;
    // 경도
    private BigDecimal longitude;

}
