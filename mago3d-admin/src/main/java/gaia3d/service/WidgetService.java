package gaia3d.service;

import java.util.List;

import gaia3d.domain.widget.Widget;

/**
 * 위젯
 * @author jeongdae
 *
 */
public interface WidgetService {
	
	/**
	 * 위젯 목록
	 * @param widget
	 * @return
	 */
	List<Widget> getListWidget(Widget widget);

	/**
	 * 위젯 저장
	 * @param widget
	 * @return
	 */
	int insertWidget(Widget widget);
	
	/**
	 * 위젯 수정
	 * @param widgetList
	 * @return
	 */
	int updateWidget(List<Widget> widgetList);
}
