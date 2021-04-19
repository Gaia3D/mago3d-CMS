package gaia3d.domain.cache;

/**
 * cache 전파 유형. self 자신만, user 사용자 페이지 갱신. broadcase 전체
 * @author Jeongdae
 *
 */
public enum CacheType {
	SELF,
	USER,
	BROADCAST
}
