package com.gaia3d.persistence;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.gaia3d.domain.UserInfo;

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
	 * user_group_id 그룹을 제외한 사용자 수
	 * @param userInfo
	 * @return
	 */
	Long getExceptUserGroupUserByGroupIdTotalCount(UserInfo userInfo);
	
	/**
	 * 사용자 목록
	 * @param userInfo
	 * @return
	 */
	List<UserInfo> getListUser(UserInfo userInfo);
	
	/**
	 * user_group_id를 제외한 사용자 목록
	 * @param userInfo
	 * @return
	 */
	List<UserInfo> getListExceptUserGroupUserByGroupId(UserInfo userInfo);
	
	/**
	 * 사용자 아이디 중복 건수
	 * @param user_id
	 * @return
	 */
	Integer getDuplicationIdCount(String user_id);
	
	/**
	 * 사용자 정보 취득
	 * @param user_id
	 * @return
	 */
	UserInfo getUser(String user_id);
	
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
	 * 사용자 테이블의 사용자 그룹 정보 변경
	 * @param userInfo
	 * @return
	 */
	int updateUserGroupUser(UserInfo userInfo);
	
	/**
	 * 사용자 상태 수정
	 * @param userInfo
	 * @return
	 */
	int updateUserStatus(UserInfo userInfo);
	
	/**
	 * 사용자 등록 방법에 의한 사용자 상태 수정
	 * @param userInfo
	 * @return
	 */
	int updateUserStatusByInsertType(UserInfo userInfo);
	
	/**
	 * 로그인 실패 횟수 초과로 잠김 상태 사용자 해제 처리
	 * @param userInfo
	 * @return
	 */
	int updateUserFailLockRelease(UserInfo userInfo);
	
	/**
	 * 사용자 로그인 실패 횟수 및 상태 수정
	 * @param userInfo
	 * @return
	 */
	int updateUserFailLoginCount(UserInfo userInfo);
	
	/**
	 * 사용자 비밀번호 수정
	 * @param userInfo
	 * @return
	 */
	int updatePassword(UserInfo userInfo);
	
	/**
	 * 사용자 삭제
	 * @param user_id
	 * @return
	 */
	int deleteUser(String user_id);
}
