package gaia3d.maker;

import com.fasterxml.jackson.databind.ObjectMapper;
import gaia3d.Mago3dTilerApplication;
import gaia3d.config.PropertiesConfig;
import gaia3d.domain.TileInfo;
import gaia3d.domain.TileLog;
import gaia3d.domain.TileMessage;
import gaia3d.domain.TilerJobStatus;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.web.client.RestTemplate;

@Slf4j
@SpringBootTest(classes = Mago3dTilerApplication.class)
class PostProcessTest {

    @Autowired
    private ObjectMapper objectMapper;
    @Autowired
    private RestTemplate restTemplate;
    @Autowired
    private PropertiesConfig propertiesConfig;

    @Disabled
    void 스마트_타일_변환_갱신() {
        TileMessage tileMessage = TileMessage.builder()
                .tileId(105)
                .tileName("스마트타일")
                .tileKey("smart")
                .tilePath("infra/tile/smart")
                .build();
        TileInfo tileInfo = tileMessage.toTileInfo();
        tileInfo.setStatus(TilerJobStatus.SUCCESS);
        PostProcess postProcess = new PostProcess(objectMapper, restTemplate, propertiesConfig);
        postProcess.updateTileInfo(tileInfo);
    }

    @Disabled
    void 스마트_타일_변환_상태_갱신() {
        TileMessage tileMessage = TileMessage.builder()
                .tileId(105)
                .tileName("스마트타일")
                .tileKey("smart")
                .tilePath("infra/tile/smart")
                .build();
        TileInfo tileInfo = tileMessage.toTileInfo();
        tileInfo.setStatus(TilerJobStatus.FAIL);
        PostProcess postProcess = new PostProcess(objectMapper, restTemplate, propertiesConfig);
        postProcess.updateTileInfo(tileInfo);
    }

    @Disabled
    void 스마트_타일_변환_로그_갱신() {
        //TileLog tileLog = new TileLog();
        //PostProcess.updateTileLog(tileLog);
    }

}