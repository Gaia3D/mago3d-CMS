package com.gaia3d.domain;

/**
 * TODO 검색에 사용되는 공통 기능. 모든 domain의 member 변수로 리팩토링 해야 함. mybatis 가 귀찮아서 임시로 이렇게 함
 * @author Cheon JeongDae
 *
 */
public class SearchFilter {

	// 페이지 처리를 위한 시작
	private Long offset;
	// 페이지별 표시할 건수
	private Long limit;
	
	/********** 검색 조건 ************/
	private String search_word;
	// 검색 옵션. 0 : 일치, 1 : 포함
	private String search_option;
	private String search_value;
	private String start_date;
	private String end_date;
	private String order_word;
	private String order_value;
	private Long list_counter = 10l;
	
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
	public String getSearch_word() {
		return search_word;
	}
	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}
	public String getSearch_option() {
		return search_option;
	}
	public void setSearch_option(String search_option) {
		this.search_option = search_option;
	}
	public String getSearch_value() {
		return search_value;
	}
	public void setSearch_value(String search_value) {
		this.search_value = search_value;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getOrder_word() {
		return order_word;
	}
	public void setOrder_word(String order_word) {
		this.order_word = order_word;
	}
	public String getOrder_value() {
		return order_value;
	}
	public void setOrder_value(String order_value) {
		this.order_value = order_value;
	}
	public Long getList_counter() {
		return list_counter;
	}
	public void setList_counter(Long list_counter) {
		this.list_counter = list_counter;
	}
	
	@Override
	public String toString() {
		return "SearchDomain [offset=" + offset + ", limit=" + limit + ", search_word=" + search_word
				+ ", search_option=" + search_option + ", search_value=" + search_value + ", start_date=" + start_date
				+ ", end_date=" + end_date + ", order_word=" + order_word + ", order_value=" + order_value
				+ ", list_counter=" + list_counter + "]";
	}
}
