package gaia3d.domain.cache;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import gaia3d.domain.menu.Menu;
import gaia3d.domain.policy.GeoPolicy;
import gaia3d.domain.policy.Policy;
import gaia3d.domain.user.UserGroupMenu;

/**
 * TODO: 귀찮고, 전부 select 성 데이터고 관리자가 혼자라서 getInstance를 사용하지 않았음. 바람직 하지는 않음
 * 환경 설정 관련 모든 요소를 캐시 처리
 *
 * @author jeongdae
 *
 */
public class CacheManager {

    private volatile static CacheManager cacheManager = new CacheManager();

    private CacheManager() {
    }
    
	// 운영환경인지, 로컬 환경인지 확인
	private String profile;
    // 2D, 3D 운영 정책
    private GeoPolicy geoPolicy;
    // 운영 정책
    private Policy policy;

    // 대메뉴 정보
 	private Map<Integer, Menu> menuMap = null;
 	// url과 menu_id를 매핑
 	private Map<String, Integer> menuUrlMap = null;
 	
	public static String getProfile() {
		return cacheManager.profile;
	}

	public static void setProfile(String profile) {
		cacheManager.profile = profile;
	}

 	public static GeoPolicy getGeoPolicy() {
		return cacheManager.geoPolicy;
	}

	public static void setGeoPolicy(GeoPolicy geoPolicy) {
		cacheManager.geoPolicy = geoPolicy;
	}

	public static Policy getPolicy() {
		return cacheManager.policy;
	}

	public static void setPolicy(Policy policy) {
		cacheManager.policy = policy;
	}
 	
	/**
	 * 대메뉴(1 Depth) Map, 화면 왼쪽 메뉴 표시용
	 * @return
	 */
	public static Map<Integer, Menu> getMenuMap() {
		if(cacheManager.menuMap == null) {
			return new HashMap<>();
		}
		return cacheManager.menuMap;
	}
	
	public static void setMenuMap(Map<Integer, Menu> menuMap) {
		cacheManager.menuMap = menuMap;
	}
	
	/**
	 * url과  menuId를 매핑
	 * @return
	 */
	public static Map<String, Integer> getMenuUrlMap() {
		if(cacheManager.menuUrlMap == null) {
			return new HashMap<>();
		}
		return cacheManager.menuUrlMap;
	}
	
	public static void setMenuUrlMap(Map<String, Integer> menuUrlMap) {
		cacheManager.menuUrlMap = menuUrlMap;
	}

	public static Menu getMenuByUrl(String url) {
		Integer menuId = cacheManager.menuUrlMap.get(url);
		if(menuId != null) return cacheManager.menuMap.get(menuId);

		return null;
	}
    
    // 사용자 그룹별 메뉴 목록
    private Map<Integer, List<UserGroupMenu>> userGroupMenuMap = null;
    // 사용자 그룹별 Role 목록
    private Map<Integer, List<String>> userGroupRoleMap = null;

    public static Map<Integer, List<UserGroupMenu>> getUserGroupMenuMap() {
        return cacheManager.userGroupMenuMap;
    }
    public static List<UserGroupMenu> getUserGroupMenuList(Integer userGroupId) {
        return cacheManager.userGroupMenuMap.get(userGroupId);
    }
    public static void setUserGroupMenuMap(Map<Integer, List<UserGroupMenu>> userGroupMenuMap) {
        cacheManager.userGroupMenuMap = userGroupMenuMap;
    }
    public static List<String> getUserGroupRoleKeyList(Integer userGroupId) {
        return cacheManager.userGroupRoleMap.get(userGroupId);
    }
    public static Map<Integer, List<String>> getUserGroupRoleMap() {
        return cacheManager.userGroupRoleMap;
    }
    public static void setUserGroupRoleMap(Map<Integer, List<String>> userGroupRoleMap) {
        cacheManager.userGroupRoleMap = userGroupRoleMap;
    }
}
