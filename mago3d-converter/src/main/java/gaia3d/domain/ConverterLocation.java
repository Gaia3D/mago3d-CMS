package gaia3d.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.math.BigDecimal;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class ConverterLocation implements Serializable {

    private static final long serialVersionUID = -3475237723073093024L;

    // 데이터 키
    private String data_key;
    // 위도
    private BigDecimal latitude;
    // 경도
    private BigDecimal longitude;

}
