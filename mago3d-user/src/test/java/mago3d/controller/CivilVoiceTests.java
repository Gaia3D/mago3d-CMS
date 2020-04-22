package mago3d.controller;

import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MvcResult;

import com.fasterxml.jackson.core.type.TypeReference;

import lombok.extern.slf4j.Slf4j;
import mago3d.common.BaseControllerTest;
import mago3d.domain.CivilVoice;
import mago3d.domain.Key;
import mago3d.domain.UserSession;
import mago3d.persistence.CivilVoiceMapper;
import mago3d.service.CivilVoiceCommentService;
import mago3d.service.CivilVoiceService;

@Slf4j
@TestMethodOrder(OrderAnnotation.class)
public class CivilVoiceTests extends BaseControllerTest {
	@Autowired
	CivilVoiceService civilVoiceService;
	@Autowired
	CivilVoiceCommentService civilVoiceCommentService;
	@Autowired
	CivilVoiceMapper civilVoiceMapper;

	private final Integer LIST_COUNT = 30;

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
	public void 시민참여_등록() throws Exception {

		for(int i=0;i<LIST_COUNT;i++) {
			CivilVoice  civilVoice = CivilVoice.builder()
					.clientIp("0.0.0.0")
					.title("test_"+i)
					.build();

			mockMvc.perform(post("/civil-voices")
					.session(session)
					.contentType(MediaType.APPLICATION_JSON)
					.flashAttr("civilVoice", civilVoice))
				.andDo(print())
				.andExpect(status().isOk());
		}
	}

	@Test
	@Order(2)
	public void 시민참여등록_입력오류테스트() throws Exception {
		/**
		 * @NotNull : null - X, "" - O
		 * @NotEmpty : null - X, "" - X, " "(space) 허용
		 * @NotBlank : 셋 다 허용하지 않음
		 */
		CivilVoice  civilVoice = CivilVoice.builder()
				.clientIp("0.0.0.0")
				.build();

		MvcResult result = mockMvc.perform(post("/civil-voices")
				.session(session)
				.contentType(MediaType.APPLICATION_JSON)
				.flashAttr("civilVoice", civilVoice))
			.andDo(print())
//			.andExpect(status().isBadRequest())
			.andReturn();
		// 컨트롤러에서 맵으로 리턴하는데 무조건 httpStats가 200으로 떨어져서 mock결과 받아서 맵으로 변환 후 확인
		@SuppressWarnings("unchecked")
		Map<String, Object> map = objectMapper.readValue(result.getResponse().getContentAsString(), Map.class);

		assertTrue(map.get("statusCode").equals(HttpStatus.BAD_REQUEST.value()));
	}

	@Test
	@Order(3)
	public void 목록_조회() throws Exception {
		// 자신이 쓴 글에 대해서는 수정또는 삭제 가능
		MvcResult result = mockMvc.perform(get("/civil-voices")
				.session(session)
				.contentType(MediaType.APPLICATION_JSON))
			.andDo(print())
			.andReturn();
		@SuppressWarnings("unchecked")
		Map<String, Object> map = objectMapper.readValue(result.getResponse().getContentAsString(), Map.class);
		log.info("map ========================== {} " , map);
//		List<CivilVoice> civilVoiceList = (List<CivilVoice>) map.get("civilVoiceList");
		List<CivilVoice> civilVoiceList = objectMapper.convertValue(map.get("civilVoiceList"),  new TypeReference<List<CivilVoice>>(){});
//		Pagination pagination = (Pagination)map.get("pagination");
		CivilVoice civilVoice = civilVoiceList.get(0);

		assertTrue(map.get("statusCode").equals(HttpStatus.OK.value()));
		assertTrue(civilVoice.getEditable());
	}

	@Test
	@Order(4)
	public void 검색_목록_조회() throws Exception {
		// 검색어 후방일치 결과 조회
		MvcResult result = mockMvc.perform(get("/civil-voices")
				.session(session)
				.contentType(MediaType.APPLICATION_JSON)
				.content("title=test_0"))
			.andDo(print())
			.andReturn();
		@SuppressWarnings("unchecked")
		Map<String, Object> map = objectMapper.readValue(result.getResponse().getContentAsString(), Map.class);
		@SuppressWarnings("unchecked")
		List<CivilVoice> civilVoiceList = (List<CivilVoice>) map.get("civilVoiceList");

		assertTrue(map.get("statusCode").equals(HttpStatus.OK.value()));
		assertTrue(civilVoiceList.size() == 1);
	}

	@Test
	public void 댓글_등록() {
	}

	@Test
	public void 댓글_수정() {
	}

	@Test
	public void 상세_조회() {
		// 단건에 대한 상세 정보 조회
		// 해당 글에 대한 코멘트 정보 같이 출력
	}

	@Test
	public void 시민참여_수정() {
	}

	@Test
	public void 시민참여_삭제() {
	}

	@Test
	public void 댓글_삭제() {
	}
}
