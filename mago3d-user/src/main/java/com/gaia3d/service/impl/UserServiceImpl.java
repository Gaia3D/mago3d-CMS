package com.gaia3d.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gaia3d.domain.CacheManager;
import com.gaia3d.domain.Policy;
import com.gaia3d.domain.UserInfo;
import com.gaia3d.persistence.UserMapper;
import com.gaia3d.service.UserService;
import com.gaia3d.util.StringUtil;

/**
 * 사용자
 * @author jeongdae
 *
 */
@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserMapper userMapper;
/*	@Autowired
	private UserDeviceService userDeviceService;
	@Autowired
	private SSOService sSOService;*/
	
	/**
	 * 사용자 수
	 * @param userInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getUserTotalCount(UserInfo userInfo) {
		return userMapper.getUserTotalCount(userInfo);
	}
	
	/**
	 * user_group_id를 제외한 사용자 수
	 * @param userInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public Long getExceptUserGroupUserByGroupIdTotalCount(UserInfo userInfo) {
		return userMapper.getExceptUserGroupUserByGroupIdTotalCount(userInfo);
	}
	
	/**
	 * 사용자 목록
	 * @param userInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserInfo> getListUser(UserInfo userInfo) {
		return userMapper.getListUser(userInfo);
	}
	
	/**
	 * user_group_id를 제외한 사용자 목록
	 * @param userInfo
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<UserInfo> getListExceptUserGroupUserByGroupId(UserInfo userInfo) {
		return userMapper.getListExceptUserGroupUserByGroupId(userInfo);
	}
	
	/**
	 * 사용자 아이디 중복 건수
	 * @param user_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public Integer getDuplicationIdCount(String user_id) {
		return userMapper.getDuplicationIdCount(user_id);
	}
	
	/**
	 * 사용자 정보 취득
	 * @param user_id
	 * @return
	 */
	@Transactional(readOnly=true)
	public UserInfo getUser(String user_id) {
		return userMapper.getUser(user_id);
	}
	
	/**
	 * 사용자 등록
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int insertUser(UserInfo userInfo) {
		return userMapper.insertUser(userInfo);
	}
	
	/**
	 * 선택 사용자 그룹내 사용자 등록
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int updateUserGroupUser(UserInfo userInfo) {
		// user_group 에 등록되지 않은 사용자
		String[] leftUserId = userInfo.getUser_all_id();
		// user_group 에 등록된 사용자
		String[] rightUserId = userInfo.getUser_select_id();
		
		if(leftUserId != null && leftUserId.length >0) {
			for(String user_id : leftUserId) {
				userInfo.setUser_id(user_id);
				userMapper.updateUserGroupUser(userInfo);
			}
		} 
		
//		// 임시 그룹으로 보냄
//		if(rightUserId != null && rightUserId.length >0) {
//			for(String user_id : rightUserId) {
//				userInfo.setUser_group_id(UserGroup.TEMP_GROUP);
//				userInfo.setUser_id(user_id);
//				userMapper.updateUserGroupUser(userInfo);
//			}
//		}
		return 0;
	}
	
	/**
	 * 사용자 수정
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int updateUser(UserInfo userInfo) {
		// TODO 환경 설정 값을 읽어 와서 update 할 건지, delete 할건지 분기를 타야 함
		return userMapper.updateUser(userInfo);
	}
	
	/**
	 * 사용자 상태 수정
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int updateUserStatus(UserInfo userInfo) {
		return userMapper.updateUserStatus(userInfo);
	}
	
	/**
	 * 사용자 비밀번호 초기화
	 * @param userIds
	 * @return
	 */
	@Transactional
	public int updateUserPasswordInit(String userIds) {
		String[] user_ids = userIds.split(",");
		Policy policy = CacheManager.getPolicy();
		boolean passwordCreateWithUserId = false;
		if(Policy.PASSWORD_CREATE_WITH_USER_ID.equals(policy.getPassword_create_type())) {
			passwordCreateWithUserId = true;
		}
		String initChar = StringUtil.getDefaultValue(policy.getPassword_create_char());
		
		ShaPasswordEncoder shaPasswordEncoder = new ShaPasswordEncoder(512);
		shaPasswordEncoder.setIterations(1000);
		for(String user_id : user_ids) {
			UserInfo userInfo = userMapper.getUser(user_id);
			String tempPassword = null;
			if(passwordCreateWithUserId) {
				tempPassword = user_id + initChar;
			} else {
				tempPassword = initChar;
			}
			String encryptPassword = shaPasswordEncoder.encodePassword(tempPassword, userInfo.getSalt());
			userInfo.setPassword(encryptPassword);
			
			// DB 처리
			if(UserInfo.STATUS_FAIL_LOGIN_COUNT_OVER.equals(userInfo.getStatus())) {
				// status = 2. 비밀번호 실패 횟수 초과 잠금의 경우 실패 횟수 count = 0
//				userInfo.setFail_login_count(0);
			} else if(UserInfo.STATUS_SLEEP.equals(userInfo.getStatus())) {
				// status = 3. 휴면의 경우 last_login_date = 현재 시간으로 update 해줘야 함
//				String today = DateUtil.getToday(FormatUtil.YEAR_MONTH_DAY_TIME14 + DateUtil.MICROSECOND);
//				userInfo.setLast_login_date(today);
			}
			userInfo.setDb_status(userInfo.getStatus());
			userInfo.setStatus(UserInfo.STATUS_TEMP_PASSWORD);
			userMapper.updatePassword(userInfo);
		}
		return user_ids.length;
	}
	
	/**
	 * 사용자 상태 수정
	 * @param business_type
	 * @param status_value
	 * @param check_ids
	 * @return
	 */
	@Transactional
	public List<String> updateUserStatus(String business_type, String status_value, String check_ids) {
		
		List<String> result = new ArrayList<String>();
		String[] userIds = check_ids.split(",");
		
		for(String user_id : userIds) {
			UserInfo userInfo = new UserInfo();
			userInfo.setUser_id(user_id);
			if("LOCK".equals(status_value)) {
				userInfo.setStatus(UserInfo.STATUS_FORBID);
			} else if("UNLOCK".equals(status_value)) {
				userInfo.setFail_login_count(0);
				userInfo.setStatus(UserInfo.STATUS_USE);
			}
			userMapper.updateUserStatus(userInfo);
		}
		
		return result;
	}
	
	/**
	 * 사용자 등록 방법에 의한 사용자 상태 수정
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int updateUserStatusByInsertType(UserInfo userInfo) {
		return userMapper.updateUserStatusByInsertType(userInfo);
	}
	
	/**
	 * 로그인 실패 횟수 초과로 잠김 상태 사용자 해제 처리
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int updateUserFailLockRelease(UserInfo userInfo) {
		return userMapper.updateUserFailLockRelease(userInfo);
	}
	
	/**
	 * 사용자 로그인 실패 횟수 및 상태 수정
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int updateUserFailLoginCount(UserInfo userInfo) {
		return userMapper.updateUserFailLoginCount(userInfo);
	}
	
	/**
	 * 사용자 비밀번호 수정
	 * @param userInfo
	 * @return
	 */
	@Transactional
	public int updatePassword(UserInfo userInfo) {
		return userMapper.updatePassword(userInfo);
	}
	
	/**
	 * 사용자 삭제
	 * @param user_id
	 * @return
	 */
	@Transactional
	public int deleteUser(String user_id) {
		Policy policy = CacheManager.getPolicy();
		String userDeleteType = policy.getUser_delete_type();
		
		UserInfo userInfo = userMapper.getUser(user_id);
		if((Policy.LOGICAL_DELETE_USER).equals(userDeleteType)) {
			// 논리적 정보 삭제
			userInfo.setStatus(UserInfo.STATUS_LOGICAL_DELETE);
			return userMapper.updateUser(userInfo);
		} else if((Policy.PHYSICAL_DELETE_USER).equals(userDeleteType)) {
			// 물리적 정보 삭제
			//sSOService.deleteSSOLog(user_id);
//			userDeviceService.deleteUserDeviceByUserId(user_id);
			return userMapper.deleteUser(user_id);
		} else {
			return 0;
		}
	}
	
	/**
	 * 일괄 사용자 삭제
	 * @param check_ids
	 * @return
	 */
	@Transactional
	public int deleteUserList(String check_ids) {
		String[] userIds = check_ids.split(",");
		for(String user_id : userIds) {
			deleteUser(user_id);
		}
		
		return check_ids.length();
	}
}
