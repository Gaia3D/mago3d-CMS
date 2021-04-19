package gaia3d.domain.cache;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CacheParams {
	// 캐시명
	private CacheName cacheName;
	// 캐시 유형
	private CacheType cacheType;
}
