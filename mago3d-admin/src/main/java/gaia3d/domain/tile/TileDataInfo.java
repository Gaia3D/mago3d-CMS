package gaia3d.domain.tile;

import lombok.*;

import java.io.Serializable;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TileDataInfo implements Serializable {

    private static final long serialVersionUID = -7984877223778160466L;

    // 스마트 타일링 고유번호
    private Integer tileId;
    // 타일명
    private String tileName;
    // 타일 Key
    private String tileKey;
    // 스마트 타일 경로
    private String tilePath;

    private List<TileDataGroup> tileDataGroupList;
}
