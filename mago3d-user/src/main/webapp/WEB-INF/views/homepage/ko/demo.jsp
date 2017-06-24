<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp" %>
<%@ include file="/WEB-INF/views/common/config.jsp" %>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Mago3D User</title>
	<%-- <link rel="stylesheet" href="/css/${lang}/font/font.css" /> --%>
<%-- 	<link rel="stylesheet" href="/images/${lang}/icon/glyph/glyphicon.css" />
	<link rel="stylesheet" href="/externlib/${lang}/normalize/normalize.min.css" /> --%>
<%-- 	<link rel="stylesheet" href="/css/${lang}/style.css" /> --%>
<!-- 	<link rel="stylesheet" href="/sample/style.css" /> -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Noto+Sans"> 
	<link rel="stylesheet" href="/css/${lang}/homepage-demo.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	
	<link rel="stylesheet" href="/externlib/${lang}/cesium/Widgets/widgets.css" />
</head>

<body>

	<div class="trigger" >
		<button type="button">메뉴</button>
		<ul>
			<li><a href="../../homepage/ko/tutorial.html">Tutorials</a></li>
			<li><a href="../../homepage/ko/download.html">Download</a></li>
			<li><a href="../../homepage/ko/mago3d.html">Mago3D</a></li>
			<li>Home</li>	
		</ul>
	</div>

	<ul class="dropdownmenu">
<c:forEach var="dataGroup" items="${projectDataGroupList}">
		<li>${dataGroup.data_group_name}
			<ul>
				<li>BoundingBox 표시</li>
				<li>색깔 변경</li>
				<li>위치 변환</li>
			</ul>
		</li>
</c:forEach>	
	</ul>
	
	<!-- 맵영역 -->
	<div id="magoContainer" style="position: absolute; width: 99%; height: 95%; margin-top: 0; padding: 0; overflow: hidden;"></div>
	
	<!-- 레이어 -->
	<div style="display: none;" class="layer" style="top:50%; left:50%; width:350px; margin:-250px 0 0 -150px; ">
	    <div class="layerHeader">
	        <h2>레이어</h2>
	        <div>
	            <button type="button" title="닫기">닫기</button>
	        </div>
	    </div>
	    <div class="layerContents">
	        <h4>테이블</h4>
	        <table>
	        	<tr>
	        		<th>소제목</th>
	        		<td>
	        			<input type="text">
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>소제목</th>
	        		<td>
	        			<select>
	        				<option>Web</option>
	        				<option>App</option>
	        			</select>
	        		</td>
	        	</tr>
	        	<tr>
	        		<th>내용</th>
	        		<td>
	        			<textarea name="" id="" cols="30" rows="1"></textarea>
	        		</td>
	        	</tr>
	        </table>
	        
	       <!--  <h4>체크박스 타입</h4>
	        <ul class="group">
	            <li><label><input type="checkbox"> 기온</label></li>
	            <li><label><input type="checkbox"> 최고기온</label></li>
	            <li><label><input type="checkbox"> 최저기온</label></li>
	        </ul> -->
	         
	        <h4>라디오버튼</h4>
	        <ul class="group">
	            <li><label><input type="radio"> 기온</label></li>
	            <li><label><input type="radio"> 최고기온</label></li>
	            <li><label><input type="radio"> 최저기온</label></li>
	        </ul>
	        <div class="btns">
	            <button id="">적용</button>
	        </div>
	    </div>
	</div>
<!-- END 편집차단 -->

<script type="text/javascript" src="/externlib/${lang}/cesium/Cesium.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Code.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/API.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Config.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Callback.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Constant.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Message.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ManagerFactory.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Atmosphere.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeometryUtil.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeometryModifier.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Line.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Plane.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Point3D.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Shader.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ShaderSource.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ReaderWriter.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Renderer.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Selection.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VBOManager.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/CesiumManager.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/PostFxShader.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/FBO.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Geometry.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Accessor.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/NeoTexture.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/BoundingBox.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/BlockModels.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/FileRequestControler.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/ManagerUtils.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/NeoReferenceModels.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/OcclusionCullOctree.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Octree.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VisibleObjectsControler.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Matrix4.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Lego.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Camera.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeoLocationData.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/MagoFacade.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Policy.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Box.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Vertex.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Triangle.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TriSurface.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TriPolyhedron.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VertexList.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/VertexMatrix.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Color.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Quaternion.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/domain/ProjectLayer.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/MetaData.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/SceneState.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/SplitValue.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/Frustum.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GeographicCoord.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/TerranTile.js"></script>
<script type="text/javascript" src="/js/${lang}/mago3d/GlobeTile.js"></script>
<script>
	var policyJson = ${policyJson};
	var dataGroupMap = ${dataGroupMap};
	
	var managerFactory = new ManagerFactory(null, "magoContainer", policyJson, dataGroupMap);
</script>
</body>
</html>