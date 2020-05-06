package gaia3d.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.List;

import org.assertj.core.internal.bytebuddy.implementation.bind.annotation.IgnoreForBinding;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;

import lombok.extern.slf4j.Slf4j;
import gaia3d.common.BaseControllerTest;
import gaia3d.domain.CivilVoice;
import gaia3d.domain.CivilVoiceComment;
import gaia3d.domain.Key;
import gaia3d.domain.UserSession;
import gaia3d.service.CivilVoiceService;

@Slf4j
@TestMethodOrder(OrderAnnotation.class)
public class CivilVoiceDummyTests extends BaseControllerTest {
	@Autowired CivilVoiceService civilVoiceService;
	private final Integer LIST_COUNT = 30;


	@BeforeEach
	public void initSession() throws Exception {
		UserSession adminSession = UserSession.builder().userId("admin").userGroupId(1).build();
		this.session.setAttribute(Key.USER_SESSION.name(), adminSession);
	}

	@Test
	@Order(1)
	public void 시민참여_글_생성() throws Exception {

		for(int i=1;i<=LIST_COUNT;i++) {
			Double longitudeMax = 127.19975486309424;
			Double longitudeMin = 126.83225331801371;
			Double latitudeMax = 37.614468145431594;
			Double latitudeMin = 37.4523280631381;
			Double longitude = Math.random() * (longitudeMax - longitudeMin) + longitudeMin;
			Double latitude = Math.random() * (latitudeMax - latitudeMin) + latitudeMin;

			CivilVoice civilVoice = CivilVoice.builder()
					.clientIp("0.0.0.0")
					.title("달라진 현대차 노조 고객 없으면 노조도 없다_"+i)
					.contents("그는 수상 이후 페이스북에 올린 글에서 봉준호 감독의 오스카상을 축하하면서 “아니나 다를까 ‘이문덕’이란다”며 “이게 다 문재인 덕(이란 말)”이라고 썼다. 그는 자신이 오래전 저서를 통해 받은 인세로 모친에게 선물한 뒤 들은 이야기가 있다며 “우리 어머니 고작 하시는 말씀이 ‘아이고, 하나님 감사합니다’(였다)”면서 “황당해서 ‘그 책 하나님이 아니라 내가 쓴 거랬더니’ (어머님은) 다 하나님 덕이라고(말하셨다)”고 했다.그는 수상 이후 페이스북에 올린 글에서 봉준호 감독의 오스카상을 축하하면서 “아니나 다를까 ‘이문덕’이란다”며 “이게 다 문재인 덕(이란 말)”이라고 썼다. 그는 자신이 오래전 저서를 통해 받은 인세로 모친에게 선물한 뒤 들은 이야기가 있다며 “우리 어머니 고작 하시는 말씀이 ‘아이고, 하나님 감사합니다’(였다)”면서 “황당해서 ‘그 책 하나님이 아니라 내가 쓴 거랬더니’ (어머님은) 다 하나님 덕이라고(말하셨다)”고 했다.그는 수상 이후 페이스북에 올린 글에서 봉준호 감독의 오스카상을 축하하면서 “아니나 다를까 ‘이문덕’이란다”며 “이게 다 문재인 덕(이란 말)”이라고 썼다. 그는 자신이 오래전 저서를 통해 받은 인세로 모친에게 선물한 뒤 들은 이야기가 있다며 “우리 어머니 고작 하시는 말씀이 ‘아이고, 하나님 감사합니다’(였다)”면서 “황당해서 ‘그 책 하나님이 아니라 내가 쓴 거랬더니’ (어머님은) 다 하나님 덕이라고(말하셨다)”고 했다.")
					.longitude(longitude.toString())
					.latitude(latitude.toString())
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
	public void 시민참여_댓글_생성() throws Exception {
		// 목록 가져옴
		List<CivilVoice> listCivilVoice = civilVoiceService.getListCivilVoice(new CivilVoice());
		int min = 1;
		int max = 150;

		for(CivilVoice civilVoice : listCivilVoice) {
			if(civilVoice.getCommentCount() == 0) {
				int random = (int)(Math.random() * (max - min) + min);
				log.info(">>>>>>>>>>>>>>> {} >>>>>>>>> {} 건 생성", civilVoice.getCivilVoiceId(), random);

				for(int i=0; i<random; i++) {
					// session
					UserSession userSession = null;
					if(i%3 == 0) {
						userSession = UserSession.builder().userId("admin").userGroupId(1).build();
					} else {
						userSession = UserSession.builder().userId("mago3d").userGroupId(2).build();
					}
					this.session.setAttribute(Key.USER_SESSION.name(), userSession);

					// set data
					CivilVoiceComment civilVoiceComment = CivilVoiceComment.builder()
							.clientIp("0.0.0.0")
							.title("동의합니다")
							.civilVoiceId(civilVoice.getCivilVoiceId())
							.build();

					// 등록
					mockMvc.perform(post("/civil-voice-comments/")
							.session(session)
							.contentType(MediaType.APPLICATION_JSON)
							.flashAttr("civilVoiceComment", civilVoiceComment));
				}
			}
		}
	}

	@IgnoreForBinding
	public void createLonLat() {
		double longitudeMax = 127.19975486309424;
		double longitudeMin = 126.83225331801371;
		double latitudeMax = 37.614468145431594;
		double latitudeMin = 37.4523280631381;
		double longitude = Math.random() * (longitudeMax - longitudeMin) + longitudeMin;
		double latitude = Math.random() * (latitudeMax - latitudeMin) + latitudeMin;

		log.info("{}", longitude);
		log.info("{}", latitude);
	}
}
