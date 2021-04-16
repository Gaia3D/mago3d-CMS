package gaia3d.controller.view;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import gaia3d.domain.layer.LayerGroup;
import gaia3d.domain.policy.Policy;
import gaia3d.service.LayerGroupService;
import gaia3d.service.PolicyService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/layer-group")
public class LayerGroupController {

	@Autowired
	private LayerGroupService layerGroupService;

	@Autowired
	private PolicyService policyService;

	/**
	 * 레이어 그룹 목록
	 * @param request
	 * @param layerGroup
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/list")
	public String list(HttpServletRequest request, @ModelAttribute LayerGroup layerGroup, Model model) {
//		List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroupAndLayer();
		List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroup();

		model.addAttribute("layerGroupList", layerGroupList);

		return "/layer-group/list";
	}

	/**
	 * 레이어 그룹 등록 페이지 이동
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/input")
	public String input(Model model) {
		Policy policy = policyService.getPolicy();

		List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroup();

		LayerGroup layerGroup = new LayerGroup();
		layerGroup.setParentName(policy.getContentLayerGroupRoot());
		layerGroup.setParent(0);

		model.addAttribute("policy", policy);
		model.addAttribute("layerGroup", layerGroup);
		model.addAttribute("layerGroupList", layerGroupList);

		return "/layer-group/input";
	}

	/**
	 * 레이어 그룹 수정 페이지 이동
	 * @param request
	 * @param layerGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/modify")
	public String modify(HttpServletRequest request, @RequestParam Integer layerGroupId, Model model) {
		LayerGroup layerGroup = new LayerGroup();
		layerGroup.setLayerGroupId(layerGroupId);
		layerGroup = layerGroupService.getLayerGroup(layerGroup);
		Policy policy = policyService.getPolicy();
		List<LayerGroup> layerGroupList = layerGroupService.getListLayerGroup();

		if(layerGroup.getParent() == 0) {
			layerGroup.setParentName(policy.getContentLayerGroupRoot());
		}

		model.addAttribute("policy", policy);
		model.addAttribute("layerGroup", layerGroup);
		model.addAttribute("layerGroupList", layerGroupList);

		return "/layer-group/modify";
	}

	/**
	 * 레이어 그룹 삭제
	 * @param layerGroupId
	 * @param model
	 * @return
	 */
	@GetMapping(value = "/delete")
	public String delete(@RequestParam("layerGroupId") Integer layerGroupId, Model model) {
		// TODO validation 체크 해야 함
		LayerGroup layerGroup = new LayerGroup();
		layerGroup.setLayerGroupId(layerGroupId);

		layerGroupService.deleteLayerGroup(layerGroup);

		return "redirect:/layer-group/list";
	}
}
