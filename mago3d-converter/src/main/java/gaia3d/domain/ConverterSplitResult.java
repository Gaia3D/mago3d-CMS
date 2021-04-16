package gaia3d.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class ConverterSplitResult implements Serializable {

    private static final long serialVersionUID = 2840239727974119878L;

    // 원본파일명
    private String original;
    // 분리된 F4D 경로
    private String[] result;
}