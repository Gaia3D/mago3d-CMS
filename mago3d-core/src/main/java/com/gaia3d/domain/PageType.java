package com.gaia3d.domain;

public enum PageType {
	LIST(0), MODIFY(1), DETAIL(2);
	
	private int type;
	PageType(int type) {
		this.type = type;
	}
	
	public PageType valueOf(int type) {
		PageType pageType = null;
		switch (type) {
		case 1:
			pageType = PageType.LIST;
			break;
		case 2:
			pageType = PageType.MODIFY;
			break;
		case 3:
			pageType = PageType.DETAIL;
			break;
		default:
			break;
		}
		return pageType;
	}
	
	public int getType() {
		return this.type;
	}
}
