package gaia3d.domain;

import lombok.*;

import java.io.Serializable;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TileInfo implements Serializable {

    private static final long serialVersionUID = -8445974456746504651L;

    // 스마트 타일링 고유번호
    private Integer tileId;
    // 타일명
    private String tileName;
    // 타일 Key
    private String tileKey;
    // 스마트 타일 경로
    private String tilePath;
    // 변환 상태 SUCCESS(성공), FAIL(실패)
    private TilerJobStatus status;

    // 스마트 타일링 호출 서버정보 - USER(사용자에서 호출한 경우), ADMIN(관리자에서 호출한 경우)
    private ServerTarget serverTarget;

}
