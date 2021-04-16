package gaia3d.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import gaia3d.domain.widget.Widget;
import gaia3d.persistence.WidgetMapper;
import gaia3d.service.WidgetService;

/**
 * 위젯
 * @author jeongdae
 *
 */
@Service
public class WidgetServiceImpl implements WidgetService {

	@Autowired
	private WidgetMapper widgetMapper;
	
	/**
	 * 위젯 목록
	 * @param widget
	 * @return
	 */
	@Transactional(readOnly=true)
	public List<Widget> getListWidget(Widget widget) {
		return widgetMapper.getListWidget(widget);
	}

	/**
	 * 위젯 저장
	 * @param widget
	 * @return
	 */
	@Transactional
	public int insertWidget(Widget widget) {
		widget.setWidgetId(widgetMapper.getMaxWidgetId());
		return widgetMapper.insertWidget(widget);
	}
	
	/**
	 * 위젯 수정
	 * @param widgetList
	 * @return
	 */
	@Transactional
	public int updateWidget(List<Widget> widgetList) {
		// TODO 그냥 foreach
		widgetList.forEach(widget -> widgetMapper.updateWidget(widget));
		return widgetList.size();
	}
}
