package com.gaia3d.domain;

import com.gaia3d.domain.Policy;

/**
 * TODO 귀찮고, 전부 select 성 데이터고 관리자가 혼자라서 getInstance를 사용하지 않았음. 바람직 하지는 않음
 * 환경 설정 관련 모든 요소를 캐시 처리
 * 
 * @author jeongdae
 *
 */
public class CacheManager {

	private volatile static CacheManager cache = new CacheManager();;
	
	private CacheManager() {
	}
	
	// 개인정보 마스킹 처리 유무
	private boolean userInfoMasking = false; 
	// 운영 정책
	private Policy policy = null;
	
//	/**
//	 * 객체 리턴
//	 * @return
//	 */
//	public static ConfigCache getInstance() {
//		if(configCache == null) {
//			synchronized (ConfigCache.class) {
//				if(configCache == null) {
//					configCache = new ConfigCache();
//				}
//			}
//		}
//		return configCache;
//	}
	
	/**
	 * 개인정보 마스킹 처리 유무
	 * @return
	 */
	public static boolean isUserInfoMasking() {
		return cache.userInfoMasking;
	}
	
	/**
	 * 운영 정책
	 * @return
	 */
	public static Policy getPolicy() {
		return cache.policy;
	}
	
	public static void setPolicy(Policy policy) {
		cache.policy = policy;
		if("Y".equals(policy.getSecurity_masking_yn())) {
			cache.userInfoMasking = true;
		} else {
			cache.userInfoMasking = false;
		}
	}
}
