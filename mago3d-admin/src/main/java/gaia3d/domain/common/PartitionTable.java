package gaia3d.domain.common;

import lombok.*;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class PartitionTable {

    // 테이블명
    private String tableName;
    // 생성 테이블 시작 시간
    private String startTime;
    // 생성 테이블 끝 시간
    private String endTime;
}
