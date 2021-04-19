package gaia3d.common;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.document;
import static org.springframework.restdocs.mockmvc.MockMvcRestDocumentation.documentationConfiguration;
import static org.springframework.restdocs.operation.preprocess.Preprocessors.preprocessRequest;
import static org.springframework.restdocs.operation.preprocess.Preprocessors.preprocessResponse;
import static org.springframework.restdocs.operation.preprocess.Preprocessors.prettyPrint;

import java.nio.charset.StandardCharsets;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.restdocs.RestDocumentationContextProvider;
import org.springframework.restdocs.RestDocumentationExtension;
import org.springframework.restdocs.mockmvc.RestDocumentationResultHandler;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.filter.CharacterEncodingFilter;

import gaia3d.Mago3dUserApplication;
import gaia3d.config.PropertiesConfig;
import gaia3d.domain.Key;
import gaia3d.domain.user.UserSession;
import gaia3d.interceptor.CSRFHandlerInterceptor;
import gaia3d.service.AccessLogService;
/**
 * rest document & mockMvc 설정
 */
@ExtendWith({RestDocumentationExtension.class, SpringExtension.class})
@ContextConfiguration(classes = Mago3dUserApplication.class)
public class BaseControllerTest {

	protected MockMvc mockMvc;
    protected RestDocumentationResultHandler documentHandler;
	@Autowired
    private PropertiesConfig propertiesConfig;
    @MockBean
    protected AccessLogService accessLogService;
    @MockBean
    private CSRFHandlerInterceptor csrfHandlerInterceptor;
    @Value("${server.port}")
    private int port;

    protected MockHttpSession mockSession = new MockHttpSession();

    @BeforeEach
    public void setup(WebApplicationContext ctx, RestDocumentationContextProvider restDocumentation) throws Exception {
        String scheme = propertiesConfig.getRestTemplateMode();
        String host = propertiesConfig.getServerIp();
        // restDoc snippet 폴더 생성 규칙 변경, request, response 정렬
        documentHandler = document("{class-name}/{method-name}",
                preprocessRequest(prettyPrint()),
                preprocessResponse(prettyPrint()));
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx)
                .apply(documentationConfiguration(restDocumentation)
                        .uris()
                        .withScheme(scheme)
                        .withHost(host)
                        .withPort(port)
                )
                // restDoc encoding
                .alwaysDo(documentHandler).addFilters(new CharacterEncodingFilter(StandardCharsets.UTF_8.name(), true))
                .build();
        // 다른 사용자 그룹을 테스트 할 경우는 테스트 하는 쪽에서 변경하기
        UserSession userInfo = UserSession.builder().userId("admin").userGroupId(1).build();
        mockSession.setAttribute(Key.USER_SESSION.name(), userInfo);
        // csrf mocking
        given(csrfHandlerInterceptor.preHandle(any(), any(), any())).willReturn(true);
    }
}
