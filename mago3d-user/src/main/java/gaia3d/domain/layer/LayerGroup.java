package gaia3d.domain.layer;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LayerGroup implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 784422683223454122L;
	
	/****** 화면 표시용 *******/
	// up : 위로, down : 아래로
	private String updateType;
	
	/**
	 * 레이어 그룹 고유번호 
	 */
	private Integer layerGroupId;
	private Integer userGroupId;
	
	/**
	 * 레이어 그룹명
	 */
	private String layerGroupName; 
	
	/**
	 * 사용자 아이디
	 */
	private String userId;
	
	private Integer ancestor;
	
	/**
	 * 부모
	 */
	private Integer parent;
	private String parentName;
	
	/**
	 * 깊이
	 */
	private Integer depth;
	
	/**
	 * 나열 순서 
	 */
	private Integer viewOrder;
	
	// 자식 존재 유무
	private Integer children;
	
	/**
	 * 사용 유무
	 */
	private Boolean available;
	
	/**
	 * 설명 
	 */
	private String description;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime updateDate;

	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime insertDate;
	
	/**
	 * 자식 레이어 목록
	 */
	private List<Layer> layerList;
}
