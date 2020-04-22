package mago3d.controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.extern.slf4j.Slf4j;
import mago3d.common.BaseControllerTest;
import mago3d.domain.Key;
import mago3d.domain.UserSession;
import mago3d.service.AttributeRepositoryService;

@Slf4j
@TestMethodOrder(OrderAnnotation.class)
public class AttributeRepositoryTest extends BaseControllerTest {
	@Autowired
	private AttributeRepositoryService attributeRepositoryService;

	@BeforeEach
	public void initSession() throws Exception {
		UserSession userSession = UserSession.builder()
									.userId("admin")
									.userGroupId(1)
									.build();
		this.session.setAttribute(Key.USER_SESSION.name(), userSession);
	}

	@Test
	@Order(1)
	public void 조회() throws Exception {
		log.info("test ======= {} ", attributeRepositoryService.getDataAttribute("11_085"));
	}
}
