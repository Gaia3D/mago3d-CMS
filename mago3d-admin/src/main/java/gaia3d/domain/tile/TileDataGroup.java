package gaia3d.domain.tile;

import java.time.LocalDateTime;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import org.springframework.format.annotation.DateTimeFormat;

import gaia3d.domain.data.DataInfoSimple;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 스마트 타일 그룹 정보
 */
@ToString(callSuper = true)
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class TileDataGroup {

    // 스마트 타일 데이터 그룹 고유번호
    private Integer tileDataGroupId;

    // 스마트 타일링 고유번호
    private Integer tileId;

    // 데이터 그룹 고유 번호
    private Integer dataGroupId;
    // 데이터 그룹 키
    private String dataGroupKey;

    // 스마트 타일 경로
    private String tilePath;
    // 데이터 그룹 경로
    private String dataGroupPath;
    // 데이터 그룹 절대 경로
    private String absoluteDataGroupPath;

    // 스마트 타일용 데이터 정보
    private List<DataInfoSimple> dataInfoList;

    @Getter(AccessLevel.NONE)
    @Setter(AccessLevel.NONE)
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
    private LocalDateTime viewInsertDate;

    public LocalDateTime getViewInsertDate() {
        return this.insertDate;
    }

    // 등록일
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private LocalDateTime insertDate;
}
