package gaia3d.controller;

import gaia3d.Mago3dUserApplication;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

@AutoConfigureMockMvc
@SpringBootTest(classes = Mago3dUserApplication.class)
class SigninControllerTest {

    @Autowired
    protected MockMvc mockMvc;

    @Test
    void signin() throws Exception {
        mockMvc.perform(get("/sign/signin")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(model().hasNoErrors())
                .andExpect(status().is2xxSuccessful());

        System.out.println(mockMvc);
    }
}