package mago3d.domain;

import java.net.URLEncoder;

/**
 * 검색 공통 항목
 * @author Jeongdae
 *
 */
public class Search {

	public Search() {
	}
	
	public Search(Long totalCount, Long offset, Long limit, String searchWord, String searchOption, String searchValue,
			String startDate, String endDate, String orderWord, String orderValue, Long listCounter) {
		super();
		this.totalCount = totalCount;
		this.offset = offset;
		this.limit = limit;
		this.searchWord = searchWord;
		this.searchOption = searchOption;
		this.searchValue = searchValue;
		this.startDate = startDate;
		this.endDate = endDate;
		this.orderWord = orderWord;
		this.orderValue = orderValue;
		this.listCounter = listCounter;
	}

	// 총건수
	private Long totalCount;

	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;

	/********** 검색 조건 ************/
	private String searchWord;
	// 검색 옵션. 0 : 일치, 1 : 포함
	private String searchOption;
	private String searchValue;
	private String startDate;
	private String endDate;
	private String orderWord;
	private String orderValue;
	private Long listCounter = 10l;
	
	public Long getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Long totalCount) {
		this.totalCount = totalCount;
	}
	public Long getOffset() {
		return offset;
	}
	public void setOffset(Long offset) {
		this.offset = offset;
	}
	public Long getLimit() {
		return limit;
	}
	public void setLimit(Long limit) {
		this.limit = limit;
	}
	public String getSearchWord() {
		return searchWord;
	}
	public void setSearchWord(String searchWord) {
		this.searchWord = searchWord;
	}
	public String getSearchOption() {
		return searchOption;
	}
	public void setSearchOption(String searchOption) {
		this.searchOption = searchOption;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getOrderWord() {
		return orderWord;
	}
	public void setOrderWord(String orderWord) {
		this.orderWord = orderWord;
	}
	public String getOrderValue() {
		return orderValue;
	}
	public void setOrderValue(String orderValue) {
		this.orderValue = orderValue;
	}
	public Long getListCounter() {
		return listCounter;
	}
	public void setListCounter(Long listCounter) {
		this.listCounter = listCounter;
	}
	
	/**
	 * 검색 조건
	 * @param search
	 * @return
	 */
	public String getParameters() {
		StringBuffer buffer = new StringBuffer();
		buffer.append("&");
		buffer.append("searchWord=" + getDefaultValue(this.searchWord));
		buffer.append("&");
		buffer.append("searchOption=" + getDefaultValue(this.searchOption));
		buffer.append("&");
		buffer.append("searchValue=" + getDefaultValue(this.searchValue));
		buffer.append("&");
		buffer.append("startDate=" + getDefaultValue(this.startDate));
		buffer.append("&");
		buffer.append("endDate=" + getDefaultValue(this.endDate));
		buffer.append("&");
		buffer.append("orderWord=" + getDefaultValue(this.orderWord));
		buffer.append("&");
		buffer.append("orderValue=" + getDefaultValue(this.orderValue));
		buffer.append("&");
		buffer.append("listCounter=" + this.listCounter);
		return buffer.toString();
	}

	private String getDefaultValue(String value) {
		if(value == null || "".equals(value.trim())) {
			return "";
		}

		return value;
	}

	@Override
	public String toString() {
		return "Search [totalCount=" + totalCount + ", offset=" + offset + ", limit=" + limit + ", searchWord="
				+ searchWord + ", searchOption=" + searchOption + ", searchValue=" + searchValue + ", startDate="
				+ startDate + ", endDate=" + endDate + ", orderWord=" + orderWord + ", orderValue=" + orderValue
				+ ", listCounter=" + listCounter + "]";
	}
}
