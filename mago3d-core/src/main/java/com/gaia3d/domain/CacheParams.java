package com.gaia3d.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CacheParams {

	// project 고유 식별자
	private Long project_id;
	// 캐시명
	private CacheName cacheName;
	// 캐시 유형
	private CacheType cacheType;
}
