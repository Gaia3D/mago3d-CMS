package gaia3d.domain.user;

public enum UserGroupType {
    // 슈퍼 관리자
    SUPER_ADMIN(1),
    // 직원
    USER(2),
    // GEST
    GEST(3);

    private final int value;

    UserGroupType(int value) {
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
    public static UserGroupType findBy(int value) {
        for(UserGroupType userGroupType : values()) {
            if(userGroupType.getValue() == value) return userGroupType;
        }
        return null;
    }
}
