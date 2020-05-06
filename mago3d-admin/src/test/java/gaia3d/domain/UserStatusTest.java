package gaia3d.domain;

import org.junit.jupiter.api.Test;

import lombok.extern.slf4j.Slf4j;
import gaia3d.domain.RoleKey;

@Slf4j
class UserStatusTest {

	@Test
	void test() {
		log.info("=== {} ", RoleKey.valueOf("ADMIN_SIGNIN"));
	}

}
