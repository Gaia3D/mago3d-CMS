package gaia3d.domain;

/**
 * 트리 구조에서의 depth
 * @author Jeongdae
 *
 */
public enum Depth {

	ONE(1),
	TWO(2),
	THREE(3);

	private final int value;
	
	Depth(int value) {
		this.value = value;
	}
	
	public int getValue() {
		return this.value;
	}
	
	/**
	 * TODO values for loop 로 변환
	 * @param value
	 * @return
	 */
	public static Depth findBy(int value) {
		for(Depth depth : values()) {
			if(depth.getValue() == value) return depth; 
		}
		return null;
	}
}
