//package gaia3d.controller;
//
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
//import org.junit.jupiter.api.Order;
//import org.junit.jupiter.api.Test;
//import org.junit.jupiter.api.TestMethodOrder;
//import org.springframework.beans.factory.annotation.Autowired;
//
//import lombok.extern.slf4j.Slf4j;
//import gaia3d.common.BaseControllerTest;
//import gaia3d.domain.Key;
//import gaia3d.domain.UserSession;
//import gaia3d.service.AttributeRepositoryService;
//
//@Slf4j
//@TestMethodOrder(OrderAnnotation.class)
//public class AttributeRepositoryTest extends BaseControllerTest {
//	@Autowired
//	private AttributeRepositoryService attributeRepositoryService;
//
//	@BeforeEach
//	public void initSession() throws Exception {
//		UserSession userSession = UserSession.builder()
//									.userId("admin")
//									.userGroupId(1)
//									.build();
//		this.session.setAttribute(Key.USER_SESSION.name(), userSession);
//	}
//
//	@Test
//	@Order(1)
//	public void 조회() throws Exception {
//		log.info("test ======= {} ", attributeRepositoryService.getDataAttribute("11_085"));
//	}
//}
