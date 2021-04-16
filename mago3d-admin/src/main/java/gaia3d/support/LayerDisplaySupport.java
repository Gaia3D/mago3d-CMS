package gaia3d.support;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import gaia3d.domain.layer.Layer;
import gaia3d.domain.layer.LayerGroup;

public class LayerDisplaySupport {
	
	public static List<LayerGroup> getListDisplayLayer(List<LayerGroup> layerGroupList, String baseLayers) {

		// 사용자가 설정한 레이어가 있을경우 해당 레이어만 지도상에 표출 하도록 defaultDisplay 옵션을 변경해준다.
		if (baseLayers != null) {
			String[] userLayers = baseLayers.split(",");
			Map<String, Integer> baseLayerMap = Arrays.stream(userLayers)
					.collect(Collectors.toMap(Function.identity(), String::length));
			layerGroupList.stream().filter(a -> a.getLayerList().size() > 0).forEach(group -> {
				List<Layer> layerList = group.getLayerList();
				for (Layer layer : layerList) {
					String layerKey = layer.getLayerKey();
					if (baseLayerMap.containsKey(layerKey)) {
						layer.setDefaultDisplay(true);
					} else {
						layer.setDefaultDisplay(false);
					}
				}
			});
		}

		return layerGroupList;
	}
}
