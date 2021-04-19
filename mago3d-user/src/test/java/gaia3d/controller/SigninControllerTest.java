package gaia3d.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.web.servlet.MockMvc;

import gaia3d.Mago3dUserApplication;
import gaia3d.controller.view.SigninController;
import gaia3d.service.AccessLogService;

@WebMvcTest(SigninController.class)
@ContextConfiguration(classes = Mago3dUserApplication.class)
class SigninControllerTest {

    @Autowired
    private MockMvc mockMvc;
    @MockBean
    protected AccessLogService accessLogService;

    @Test
    void signin() throws Exception {
        mockMvc.perform(get("/sign/signin")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(model().hasNoErrors())
                .andExpect(status().is2xxSuccessful());
    }
}