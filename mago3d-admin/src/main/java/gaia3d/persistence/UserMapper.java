package gaia3d.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import gaia3d.domain.user.UserInfo;

/**
 * 사용자
 * @author jeongdae
 *
 */
@Repository
public interface UserMapper {

	/**
	 * 사용자 수
	 * @param userInfo
	 * @return
	 */
	Long getUserTotalCount(UserInfo userInfo);

	/**
	 * 사용자 목록
	 * @param userInfo
	 * @return
	 */
	List<UserInfo> getListUser(UserInfo userInfo);
	
	/**
	 * getListUserByGroupId
	 * @param userGroupId
	 * @return
	 */
	List<String> getListUserByGroupId(Integer userGroupId);

	/**
	 * 사용자 정보 취득
	 * @param userId
	 * @return
	 */
	UserInfo getUser(String userId);

    /**
     * 사용자 ID 중복 체크
     * @param userInfo
     * @return
     */
	Boolean isUserIdDuplication(UserInfo userInfo);
	
	/**
	 * 사용자 상태 집계
	 * @return
	 */
	List<UserInfo> getUserStatusCount();

	/**
	 * 사용자 등록
	 * @param userInfo
	 * @return
	 */
	int insertUser(UserInfo userInfo);

	/**
	 * 사용자 수정
	 * @param userInfo
	 * @return
	 */
	int updateUser(UserInfo userInfo);

	/**
	 * 사용자 상태 수정
	 * @param userInfo
	 * @return
	 */
	int updateUserStatus(UserInfo userInfo);
	
	/**
	 * 사용자 비밀번호 수정
	 * @param userInfo
	 * @return
	 */
	int updatePassword(UserInfo userInfo);

	/**
	 * 사용자 삭제
	 * @param userId
	 * @return
	 */
	int deleteUser(String userId);
}
