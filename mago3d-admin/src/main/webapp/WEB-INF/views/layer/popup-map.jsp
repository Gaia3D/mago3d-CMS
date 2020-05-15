<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
    <meta charset="utf-8">
    <meta name="referrer" content="origin">
    <meta name="viewport" content="width=device-width">
    <meta name="robots" content="index,nofollow"/>
    <title>Layer 수정 | mago3D</title>
    <link rel="stylesheet" href="/css/${lang}/font/font.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/normalize/normalize.min.css?cacheVersion=${contentCacheVersion}" />
	<link rel="stylesheet" href="/externlib/jquery-ui-1.12.1/jquery-ui.min.css?cacheVersion=${contentCacheVersion}" />
    <link rel="stylesheet" href="/css/${lang}/admin-style.css?cacheVersion=${contentCacheVersion}" />
    <script type="text/javascript" src="/externlib/jquery-3.3.1/jquery.min.js?cacheVersion=${contentCacheVersion}"></script>
<script type="text/javascript" src="/externlib/jquery-ui-1.12.1/jquery-ui.min.js?cacheVersion=${contentCacheVersion}"></script>
    <script type="text/javascript" src="/externlib/ol45/ol.js?cacheVersion=${contentCacheVersion}"></script>
    <script type="text/javascript" src="/js/${lang}/map-view.js?cacheVersion=${contentCacheVersion}"></script>
 </head>
<body>
    <div style="height: 100%;">
        <div id="map" style="position: absolute; width: 100%; height: 100%; overflow: hidden;"></div>
    </div>
</body>
<script type="text/javascript">
    var policy = JSON.parse('${policyJson}');
    var layer = JSON.parse('${layerJson}');
    var mapViewer = new mapViewer(policy, layer, '${versionId}');
</script>
</html>