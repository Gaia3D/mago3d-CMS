<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>${sessionSiteName }</title>
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" />
	<link rel="stylesheet" href="/externlib/${lang}/jquery-ui/jquery-ui.css" />
	<link rel="stylesheet" href="/css/${lang}/style.css" />
	
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/font-awesome.min.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXJ.min.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXButton.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXInput.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXSelect.css" />
	<link type="text/css" rel="stylesheet" href="/externlib/${lang}/axisj/ui/arongi/AXTree.css" />
	
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery-migrate-1.2.1.min.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/jquery-ui/jquery-ui.js"></script>
		
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXJ.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXInput.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXModal.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXSelect.js"></script>
	<script type="text/javascript" src="/externlib/${lang}/axisj/lib/AXTree.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/${lang}/menuTree.js"></script>
	<script type="text/javascript" src="/js/${lang}/navigation.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/layouts/header.jsp" %>
	<%@ include file="/WEB-INF/views/layouts/menu.jsp" %>
	<div class="site-body">
		<div class="container">
			<div class="site-content">
				<%@ include file="/WEB-INF/views/layouts/sub_menu.jsp" %>
				<div class="page-area">
					<%@ include file="/WEB-INF/views/layouts/page_header.jsp" %>
					<div class="page-content">
						<div class="content-header row">
							<h3 class="content-title u-pull-left"><spring:message code='config.menu.information'/> (<a href="#" onclick="reloadMenuCache();"><spring:message code='config.menu.cache'/></a>)</h3>
							<div class="content-desc u-pull-right"><span class="icon-glyph glyph-emark-dot color-warning"></span><spring:message code='check'/></div>
						</div><!-- .content-header -->
						
						<div class="row">
							<div class="one-third column">
								<div id="AXTreeTarget" class="tree"></div>
								<button type="button" class="btn btn-success btn-sm" onclick="addTree(); return false;"><spring:message code='add'/></button>
								<button type="button" class="btn btn-success btn-sm" onclick="addChildTree(); return false;"><spring:message code='config.menu.down.add'/></button>
								<button type="button" class="btn btn-success btn-sm" onclick="delTree(); return false;"><spring:message code='config.menu.select.delete'/></button>
								<button type="button" class="btn btn-success btn-sm" onclick="updateTree(); return false;"><spring:message code='config.menu.modified'/></button>
								<button type="button" class="btn btn-warning btn-sm" onclick="moveUpTree(); return false;"><spring:message code='config.menu.up'/></button>
								<button type="button" class="btn btn-danger btn-sm" onclick="moveDownTree(); return false;"><spring:message code='config.menu.down'/></button>
							</div>
							
							<div class="two-third column">
								<div class="node">
									<div id="tree_content_area" class="info">
										<form id="treeWriteForm" name="treeWriteForm" method="post" onsubmit="return false;">
							    			<input type="hidden" id="writeMode" name="writeMode" value="" />
					                        <input type="hidden" id="menu_id" name="menu_id" value="" />
					                        <input type="hidden" id="parent" name="parent" value="" />
					                        <input type="hidden" id="depth" name="depth" value="" /> 
					                        <input type="hidden" id="view_order" name="view_order" value="1" />
					                        <input type="hidden" id="update_type" name="update_type" value="" />
										<table class="input-table scope-row">
											<col class="col-label" />
											<col class="col-input" />
											<tr>
												<th class="col-label" scope="row">
													<label for="name"><spring:message code='config.menu.name'/></label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input"><input type="text" id="name" name="name" class="m" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<label for="name_en"><spring:message code='config.menu.name.en'/></label>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input"><input type="text" id="name_en" name="name_en" class="m" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row">
													<span><spring:message code='config.menu.use.not'/></span>
													<span class="icon-glyph glyph-emark-dot color-warning"></span>
												</th>
												<td class="col-input radio-set">
													<input type="radio" id="useY" name="use_yn" value="Y"/>
													<label for="useY"><spring:message code='use'/></label>
													<input type="radio" id="useN" name="use_yn" value="N"/>
													<label for="useN"><spring:message code='not.use'/></label>
												</td>
											</tr>
											<tr>
												<th class="col-label" scope="row"><label for="url">Url</label></th>
												<td class="col-input"><input type="text" id="url" name="url" class="l" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row"><label for="image"><spring:message code='config.menu.image'/></label></th>
												<td class="col-input"><input type="text" id="image" name="image" class="l" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row"><label for="image_alt"><spring:message code='config.menu.image.alt'/></label></th>
												<td class="col-input"><input type="text" id="image_alt" name="image_alt" class="l" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row"><label for="css_class">CSS Class</label></th>
												<td class="col-input"><input type="text" id="css_class" name="css_class" class="m" /></td>
											</tr>
											<tr>
												<th class="col-label" scope="row"><label for="description"><spring:message code='description'/></label></th>
												<td class="col-input"><input type="text" id="description" name="description" class="l" /></td>
											</tr>
											<tr>
												<td colspan="2">
													<div class="button-group">
														<div class="center-buttons">
															<input type="submit" value="<spring:message code='save'/>" onclick="appendTree();" />
															<input type="reset" value="<spring:message code='config.menu.cancel'/>" onclick="resetForm();" />
														</div>
													</div>
												</td>
											</tr>
										</table>
										</form>
									</div>
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="/WEB-INF/views/layouts/footer.jsp" %>
	
<script type="text/javascript">
	var MENU_TREE_DATA = null;
    $(document).ready(function() {
    	getAjaxMenuList();
		fnObj.pageStart.delay(0.1);
	});
    
    // 캐시 갱신
    var cacheFlag = true;
	function reloadMenuCache() {
		if(cacheFlag) {
			cacheFlag = false;
			var info = "service_name=menu";
			$.ajax({
				url: "/common/ajax-reload-config-cache.do",
				type: "POST",
				data: info,
				cache: false,
				async:false,
				dataType: "json",
				success: function(msg){
					if(msg.result == "success") {
						alert(JS_MESSAGE["cache.reloaded"]);
						location.reload();
					} else {
						alert(JS_MESSAGE[msg.result]);
					}
					cacheFlag = true;
				},
				error:function(request,status,error){
					alert(JS_MESSAGE["ajax.error.message"]);
			        cacheFlag = true;
				}
			});
		} else {
			alert(JS_MESSAGE["button.dobule.click"]);
			return;
		}
	}
</script>
</body>
</html>