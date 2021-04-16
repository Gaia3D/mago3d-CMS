package gaia3d.controller.api;

import gaia3d.domain.tile.TileInfo;
import gaia3d.service.TileService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping(value = "/api-internal/tilers")
public class TilerAPIController {

    @Autowired
    private TileService tileService;

    @PutMapping(value = "{tilerId}")
    public ResponseEntity<TileInfo> updateTileInfo(@RequestBody TileInfo tileInfo, @PathVariable("tilerId") Long tileId) {
        log.info("--------------- updateTileInfo tileInfo = {}", tileInfo);
        tileService.updateTileInfo(tileInfo);
        return new ResponseEntity<>(tileInfo, HttpStatus.OK);
    }

}
