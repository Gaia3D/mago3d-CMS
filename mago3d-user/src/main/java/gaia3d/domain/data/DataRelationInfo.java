package gaia3d.domain.data;

import lombok.*;

import java.io.Serializable;

/**
 * 데이터 연관관계 정보
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DataRelationInfo implements Serializable {

    private static final long serialVersionUID = -7404245243843461159L;

    // 합체 가능한 데이터 유무. true : 합체, false : 단일
    private Boolean assemble;

    /**************table*****************/
    // 고유번호
    private Long dataRelationId;
    // 데이터 조합 정보
    private String relationInfo;
}
