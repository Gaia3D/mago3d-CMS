package gaia3d.controller.rest;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import gaia3d.controller.AuthorizationController;
import gaia3d.domain.Key;
import gaia3d.domain.tile.TileInfo;
import gaia3d.domain.user.UserSession;
import gaia3d.service.TileService;
import lombok.extern.slf4j.Slf4j;

/**
 * 타일링
 * @author kimhj
 *
 */
@Slf4j
@RestController
@RequestMapping("/tiles")
public class TileRestController implements AuthorizationController {

	@Autowired
	private TileService tileService;

	/**
	 * 사용자 ID 중복 체크
	 * @param request
	 * @param tileInfo
	 * @return
	 */
	@GetMapping(value = "/duplication")
	public Map<String, Object> tileKeyCheck(HttpServletRequest request, TileInfo tileInfo) {
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		// TODO @Valid 로 구현해야 함
		if(StringUtils.isEmpty(tileInfo.getTileKey())) {
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", "tile.key.empty");
			result.put("message", message);
			return result;
		}

		Boolean duplication = tileService.isTileKeyDuplication(tileInfo);
		log.info("@@ duplication = {}", duplication);
		int statusCode = HttpStatus.OK.value();

		result.put("duplication", duplication);
		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 타일 등록
	 * @param request
	 * @param tileInfo
	 * @param bindingResult
	 * @return
	 */
	@PostMapping
	public Map<String, Object> insert(HttpServletRequest request, @Valid @ModelAttribute TileInfo tileInfo, BindingResult bindingResult) {
		log.info("@@@@@ insert-tile tileInfo = {}", tileInfo);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		UserSession userSession = (UserSession)request.getSession().getAttribute(Key.USER_SESSION.name());
		if(bindingResult.hasErrors()) {
			message = bindingResult.getAllErrors().get(0).getDefaultMessage();
			log.info("@@@@@ message = {}", message);
			result.put("statusCode", HttpStatus.BAD_REQUEST.value());
			result.put("errorCode", errorCode);
			result.put("message", message);
			return result;
		}

		tileInfo.setUserId(userSession.getUserId());
		tileService.insertTile(tileInfo);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}

	/**
	 * 타일 정보 수정
	 * @param request
	 * @param tileInfo
	 * @return
	 */
	@PostMapping(value = "/{tileId}")
	public Map<String, Object> update(HttpServletRequest request, @PathVariable Integer tileId, @ModelAttribute TileInfo tileInfo) {
		log.info("@@@@@ urbanUpdate tileInfo = {}", tileInfo);

		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		tileInfo.setTileId(tileId);

		String userId = ((UserSession)request.getSession().getAttribute(Key.USER_SESSION.name())).getUserId();
		tileInfo.setUserId(userId);

		tileService.updateTile(tileInfo);
		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", null);
		result.put("message", null);


		return result;
	}

	/**
	 * 타일 삭제
	 * @param request
	 * @param tileId
	 * @return
	 */
	@DeleteMapping(value = "/{tileId:[0-9]+}")
	public Map<String, Object> deleteTile(HttpServletRequest request, @PathVariable Integer tileId) {

		log.info("@@@@@@@ tileId = {}", tileId);
		Map<String, Object> result = new HashMap<>();
		String errorCode = null;
		String message = null;

		TileInfo tileInfo = new TileInfo();
		tileInfo.setTileId(tileId);
		tileService.deleteTile(tileInfo);

		int statusCode = HttpStatus.OK.value();

		result.put("statusCode", statusCode);
		result.put("errorCode", errorCode);
		result.put("message", message);
		return result;
	}
}
