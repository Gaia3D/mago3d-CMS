<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/taglib.jsp"%>
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<!DOCTYPE html>
<html lang="${accessibility}">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=1250">
	<title>spec | mago3D User</title>
	<!--[if lt IE 9]>
	   	<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<link rel="stylesheet" href="/css/${lang}/homepage-style.css" />
	<link rel="stylesheet" href="/css/${lang}/font/font.css" />
	<script type="text/javascript" src="/externlib/${lang}/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/${lang}/homepage-scrolling.js"></script>
	<script type="text/javascript" src="/js/${lang}/common.js"></script>
	<script type="text/javascript" src="/js/${lang}/message.js"></script>
	<script type="text/javascript" src="/js/analytics.js"></script>
</head>
<body>
<header></header>
<nav class="nav">
		<div>
			<h1>
				<a href="/homepage/index.do">mago3D</a>
			</h1>
			<ul class="menu">
				<li class="mm" onclick='selectMenu();'>mago3D<span></span>
					<ul>
						<li><a href="/homepage/about.do" style="color: white">About</a></li>
						<li><a href="/homepage/news.do" style="color: white" onclick="alert('Coming soon.'); return false">News</a></li>
					</ul>
				</li>
				<li class="mm" onclick='selectMenu();'>Demo<span></span>
					<ul>
						<li><a href="/homepage/demo.do" style="color: white">Cesium</a></li>
						<li><a href="/homepage/demo.do?viewLibrary=worldwind"
							style="color: white">World Wind</a></li>
					</ul>
				</li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li class="mm on" onclick='selectMenu();'>Documentation<span></span>
					<ul>
						<li><a href="/homepage/api.do" style="color: white" target="_blank">API</a></li>
						<li><a href="/homepage/spec.do" style="color: white">F4D Spec</a></li>
					</ul>
				</li>
				<li><a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO"><a href="/homepage/spec.do" onclick="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on">EN</li>
			</ul>
		</div>
	</nav>
<section>
		<div class="docs-main content">
			<h2 style="margin-bottom: 5px;">F4D Converter</h2>
			<div class="line"></div>
			<div class="sub_main">
				<div class="sub_title">1. Format structure</div>
				<div>F4D format is not file based but folder based that contains several datasets. F4D format is composed of mandatory parts(1 header file and 3 sub folders) and optional parts(1 image file and 1 sub folder). Former are HeaderAsimetric.hed, Bricks folder, Models folder and References folder, and later are SimpleBuildingTexture3x3.png and Images_Resized folder respectively. Parent folder name of datasets is usually used as an id. </div>
				<img src="/images/${lang}/homepage/spec0.png" style="margin-left: 250px">
				<div class="description">Figure 1. Overall Structure of F4D Format</div>
				<div>objectIndexFile.ihe is necessary to publish F4D data through web services. This file is a temporary metadata, which is going to nothing. (The role of this file is being implemented in other parts mago3D and this file is being removed. not removed completely yet.) This file should be in F4D data folder for web service at the same depth as each F4D data folders. </div>
				<img src="/images/${lang}/homepage/spec1.png">
				<div class="description">Figure 2. objectIndexFile.ihe</div>
				<ul>
					<li>"Length of Bytes” in all following table contents are described by C++ style.</li>
				</ul>
				<div class="sub_title">1.1 HeaderAsimetric.hed</div>
				<p>It contains the metadata for 3D GIS of datasets in the F4D format folder and serves as a header file of datasets. Overall structure of HeaderAsimetric.hed is explained in Table 1. </p>
				<b>Table 1 Structure of HeaderAsimetric.hed</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>version</td>
						<td>5 x sizeof(char) bytes</td>
						<td>F4D version info</td>
					</tr>
					<tr>
						<td>guidLength</td>
						<td>sizeof(int) bytes</td>
						<td>Length of guid</td>
					</tr>
					<tr>
						<td>guid</td>
						<td>[guidLength] x sizeof(char) bytes</td>
						<td>guid</td>
					</tr>
					<tr>
						<td>longitude<br>latitude</td>
						<td>2 x sizeof(double) bytes</td>
						<td>Longitude, latitude(degree) of datasets</td>
					</tr>
					<tr>
						<td>altitude</td>
						<td>sizeof(float) bytes</td>
						<td>Altitude(unit:m) of datasets</td>
					</tr>
					<tr>
						<td>bbox</td>
						<td>6 x sizeof(float) bytes</td>
						<td>Bounding box of minX, minY, minZ, maxX, maxY, maxZ</td>
					</tr>
					<tr>
						<td>octree dimension</td>
						<td>flexible</td>
						<td>Hierarchy info of octree structure</td>
					</tr>
				</table>
				<b>Table 2 Detailed Structure of  “octree dimension” Specified in above table</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>depth</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Depth of this octree</td>
					</tr>
					<tr>
						<td>bbox</td>
						<td>6 × sizeof(float)  bytes</td>
						<td>Bounding box of minX, minY, minZ, maxX, maxY, MaxZ. Only record when depth == 0</td>
					</tr>
					<tr>
						<td>childCount</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>No. of child octree </td>
					</tr>
					<tr>
						<td>triangleCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of triangle in this octree</td>
					</tr>
					<tr>
						<td>chidrenDimensions</td>
						<td>flexible</td>
						<td>Recursively record the child octree dimensions</td>
					</tr>
				</table>
				<div class="sub_title">1.2 Bricks Folder</div>
				<p>This folder contains low resolution rough geometry information of the objects. F4D converter creates the Lego block style data to increase the rendering speed of large scale 3D objects. This trick could lower the usage of memory of the client and at the same time could increase the rendering speed of large size 3D objects by showing only rough geometry when viewer sees the objects from the long distance. </p>
				<img alt="" src="/images/${lang}/homepage/spec7.png" style="margin-left: 380px;">
				<div class="description" style="margin-left: 350px;">Figure 3 Roughness of objects can be controlled by adjusting block size</div>
				<div class="sub_title">Overall structure of Brick file is explained in Table 3. </div>
				<b>Table 3 Overall Structure of Brick File</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>bbox</td>
						<td>6 × sizeof(float)  bytes</td>
						<td>Bounding box of minX, minY, minZ, maxX, maxY, MaxZ</td>
					</tr>
					<tr>
						<td>vertexCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of vertex in a Brick</td>
					</tr>
					<tr>
						<td>vertexPositions</td>
						<td>[vertexCount] × 3 × sizeof(float) bytes</td>
						<td>x, y, z coordinates of each vertex(unit: m)</td>
					</tr>
					<tr>
						<td>bNormal</td>
						<td>sizeof(bool) bytes</td>
						<td>Whether normal vector existing or not</td>
					</tr>
					<tr>
						<td>normalCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of normal vectors(same as No. of vertex count) Only record when bNormal == true</td>
					</tr>
					<tr>
						<td>normalVectors</td>
						<td>[normalCount] × 3 × sizeof(char) bytes</td>
						<td>Normal vectors of x, y, z. Only record when bNormal == true</td>
					</tr>
					<tr>
						<td>bColor</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether colour array is existing or not</td>
					</tr>
					<tr>
						<td>colorCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Length of colour array(same as No. of vertex count) Only record when bColour == true</td>
					</tr>
					<tr>
						<td>vertexColors</td>
						<td>[colorCount]×4×sizeof(unsigned char) bytes</td>
						<td>Colour values (red, green, blue and alpha) of each vertex. Only record when bColour == true</td>
					</tr>
					<tr>
						<td>bTextureCoord</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether texture coordinate array is existing or not</td>
					</tr>
					<tr>
						<td>texgtureCoordType</td>
						<td>sizeof(unsigned short) bytes</td>
						<td>GL enumeration value for type of texture coordinate description. Now only 5126(float) type available. Only record when bTextureCoord == true</td>
					</tr>
					<tr>
						<td>vertexCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of vertex count. Only record when bTextureCoord == true</td>
					</tr>
					<tr>
						<td>textureCoordinates</td>
						<td>[vertexCount] × 2 × sizeof(float)</td>
						<td>u, v coordinate of each vertex. Only record when bTextureCoord == true</td>
					</tr>
				</table>
				<div class="sub_title">1.3 Models Folder</div>
				<p>This folder contains original 3D objects information called Models that constitutes F4D itself. Models will be made to be an instance physically in the 3D space by pairing Reference information in Reference folder. Structure of F4D’s Model information is shown in Table 4, 5, 6.</p>
				<b>Table 4 Overall Structure of Models File</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>modelCount</td>
						<td>sizeof(unsigned int)bytes</td>
						<td>No. of Models that References in octree refers</td>
					</tr>
					<tr>
						<td>modelData</td>
						<td><img src="/images/${lang}/homepage/spec8.png" class="specImage">bytes</td>
						<td>Data of each Model</td>
					</tr>
				</table>
				<b>Table 5 Detailed Structure of Model Data in above table</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>modelIndex</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Unique ID of Model. This ID is unique number throughout the datasets</td>
					</tr>
					<tr>
						<td>bbox</td>
						<td>3 x sizeof(float) bytes</td>
						<td>Bounding box of minX, minY, minZ, maxX, maxY, MaxZ</td>
					</tr>
					<tr>
						<td>vboCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of VBO(Vertex Buffer Object) that constitutes Model</td>
					</tr>
					<tr>
						<td>vboData</td>
						<td><img src="/images/${lang}/homepage/spec9.png" class="specImage">bytes</td>
						<td>Data of each VBO</td>
				</table>
				<b>Table 6 Detailed Structure of VBO Data in above talbe</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>vertexCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of vertex that constitutes VBO</td>
					</tr>
					<tr>
						<td>vertesxPositions</td>
						<td>[vertexCount] x 3 x sizeof(float)</td>
						<td>x, y, z coordinates of each vertex(unit: m)</td>
					</tr>
					<tr>
						<td>normalCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of normal vectors(same as vertexCount)</td>
					</tr>
					<tr>
						<td>normalVectors</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of normal vectors(same as vertexCount)</td>
					</tr>
					<tr>
						<td>indexCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of index of vertex that constitutes triangle</td>
					</tr>
					<tr>
						<td>sizeLevels</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>No. of levels to be used when storing index of triangles in order of size </td>
					</tr>
					<tr>
						<td>sizeThresholds</td>
						<td>[sizeLevels] × sizeof(float) bytes</td>
						<td>Delimiter of each segment</td>
					</tr>
					<tr>
						<td>indexMarkers</td>
						<td>[sizeLevels] × sizeof(unsigned int) bytes</td>
						<td>The positions of the indexes whose size is first changed in the sorted triangle index array.</td>
					</tr>
					<tr>
						<td>indexArray</td>
						<td>[indexCount] × sizeof(unsigned short) bytes</td>
						<td>Array that records indexes of vertex of each triangle </td>
					</tr>
				</table>
				<div class="sub_title">1.4 Reference Folder</div>
				<p>This folder contains reference information such as position, ID, indexes of 3D objects that is constituting F4D. By combining Reference information and Models information, real 3D objects will be physically rendered on the described place with attributes (- called as “3D objects are instantiated.”). Structure of F4D’s Reference information is shown in Table 7, 8, and 9.</p>
				<b>Table 7 Overall Structure of Reference File</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>refereneCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of reference in the octree</td>
					</tr>
					<tr>
						<td>referenceData</td>
						<td><img src="/images/${lang}/homepage/spec11.png" class="specImage"/>bytes</td>
						<td>Data of each reference</td>
					</tr>
				</table>
				<b>Table 8 Detailed Structure of Reference Data in above table</b>
				<table>
					<tr>
						<th>Name of the Filed</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>referenceIndex</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Unique ID of reference. This ID is unique number throughout the datasets</td>
					</tr>
					<tr>
						<td>objectIdLength</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Length of object ID</td>
					</tr>
					<tr>
						<td>objectId</td>
						<td>[objectIdLength] ×sizeof(char) bytes</td>
						<td>Object ID</td>
					</tr>
					<tr>
						<td>modelIndex</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Unique ID of original model referred by reference information</td>
					</tr>
					<tr>
						<td>transformMatrix</td>
						<td>16 × sizeof(float) bytes</td>
						<td>4 x 4 transformation matrix for placing and rotating the models</td>
					</tr>
					<tr>
						<td>bSingleColor</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether it uses the default colour</td>
					</tr>
					<tr>
						<td>singleColorValueType</td>
						<td>sizeof(unsigned short) bytes</td>
						<td>Default colour value type in GL enumeration for color value. Now only 5121(unsigned byte) supported. Only record when bSingleColor == true</td>
					</tr>
					<tr>
						<td>singleColorDimension</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Channel count of default color. Now fixed as 4(RGBA). Only record when bSingleColor == true</td>
					</tr>
					<tr>
						<td>singleColor</td>
						<td>[colorDimension1] × sizeof(unsigned char) bytes</td>
						<td>default colour value of this reference</td>
					</tr>
					<tr>
						<td>bVertexColor</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether vertex colours are available</td>
					</tr>
					<tr>
						<td>bTextureCoord</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether texture coordinates are available</td>
					</tr>
					<tr>
						<td>vboCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td></td>
					</tr>
					<tr>
						<td>vertexColorAndTextureCoordinateInfo</td>
						<td>∑sizeOfvertexColor&textureCoord</td>
						<td>vertex colours and texture coordinates of this reference on each vbo</td>
					</tr>
				</table>
				<b>Table 9 Detailed Structure of vertexColorAndTextureCoordinateInfo in above table</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>referenceIndex</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Unique ID of reference. This ID is unique number throughout the datasets</td>
					</tr>
					<tr>
						<td>objectIdLength</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Length of object ID</td>
					</tr>
					<tr>
						<td>objectId</td>
						<td>[objectIdLength] ×sizeof(char) bytes</td>
						<td>Object ID</td>
					</tr>
					<tr>
						<td>modelIndex</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Unique ID of original model referred by reference information</td>
					</tr>
					<tr>
						<td>transformMatrix</td>
						<td>16 × sizeof(float) bytes</td>
						<td>4 x 4 transformation matrix for placing and rotating the models</td>
					</tr>
					<tr>
						<td>bSingleColor</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether it uses a default colour</td>
					</tr>
					<tr>
						<td>singleColorValueType</td>
						<td>sizeof(unsigned short) bytes</td>
						<td>Default colour value type in GL enumeration for color value. Now only 5121(unsigned byte) supported. Only record when bSingleColor == true</td>
					</tr>
					<tr>
						<td>singleColorDimension</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Channel count of default color. Now fixed as 4(RGBA). Only record when bSingleColor == true</td>
					</tr>
					<tr>
						<td>singleColor</td>
						<td>[colorDimension1] × sizeof(unsigned char) bytes</td>
						<td>default colour value of this reference</td>
					</tr>
					<tr>
						<td>bVertexColor</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether vertex colours are available</td>
					</tr>
					<tr>
						<td>bTextureCoord</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether texture coordinates are available</td>
					</tr>
					<tr>
						<td>vboCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td></td>
					</tr>
					<tr>
						<td>vertexColorAndTextureCoordinateInfo</td>
						<td>∑sizeOfvertexColor&textureCoord</td>
						<td>vertex colours and texture coordinates of this reference on each vbo</td>
					</tr>
				</table>
				<b>Table 9 Detailed Structure of vertexColorAndTextureCoordinateInfo in above table</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>vertexColorType</td>
						<td>sizeof(unsigned short) bytes</td>
						<td>GL enumeration value for color. Now only 5121 supported. Only record when bVertexColor in above table == true</td>
					</tr>
					<tr>
						<td>vertexColorDimension</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Channel count of vertex colour. Now fixed as 3. Only record when bVertexColor in above table == true</td>
					</tr>
					<tr>
						<td>vertexCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Vertex count in this vbo. Only record when bVertexColor in above table == true</td>
					</tr>
					<tr>
						<td>vertexColors</td>
						<td>[vertexCount] × vertexColorDimension × sizeof(unsigned char) bytes</td>
						<td>Vertex color of each vertex. Only record when bVertexColor in above table == true</td>
					</tr>
					<tr>
						<td>textureCoordinateValueType</td>
						<td>sizeof(unsigned short) bytes</td>
						<td>GL enumeration value for texture coordinate. Now firxed as 5126. Only record when bTextureCoord in above table == true</td>
					</tr>
					<tr>
						<td>vertexCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Vertex count in this vbo. Only record when bTextureCoord in above table == true</td>
					</tr>
					<tr>
						<td>textureCoordinates</td>
						<td>[vertexCount] × 2 × sizeof(float) bytes</td>
						<td>u, v coordinate of each vertex. Only record when bTextureCoord in above table == true</td>
					</tr>
				</table>
				<div class="sub_title">1.5 Images_Resized folder</div>
				<p>This folder is for image files for texture mapping. Files in this folder are created only when raw data has images for texture. Because WebGL accepts texture images only with width and height of power of 2 pixels, resized texture images are created if necessary.</p>
				<div class="sub_title">1.6 SimpleBuildingTexture3x3.png</div>
				<p>This file is for texture mapping of meshes in Bricks folder(now 512 by 512). As same as files in Image_resized, this file is created only when raw data has images for texture. In Future, regardless of whether original data has textures or not, texture mapping for lego structures will be supported.</p>
				<div class="sub_title">1.7 objectIndexFile.ihe</div>
				<p>As described in “1. Format structure”, this file is metadata of full set of all F4D data on web service.</p>
				<p>Structure of objectIndexFile.ihe is shown in Table 10 and 11.</p>
				<b>Table 10 Overall Structure of Reference File</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>dataFolderCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Count of F4D folders on service</td>
					</tr>
					<tr>
						<td>eachDataFolderInfo</td>
						<td>∑dataFolderInfoSize</td>
						<td>Simple information of each F4D data folder.</td>
					</tr>
				</table>
				<b>Table 11 Detailed Structure of eachDataFolderInfo in above table</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>dataFolderNameLength</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Length of this F4D data folder name</td>
					</tr>
					<tr>
						<td>dataFolderName</td>
						<td>[dataFolderNameLength] × sizeof(char) bytes</td>
						<td>Name of this F4D data folder.</td>
					</tr>
					<tr>
						<td>lonLatAlt</td>
						<td>sizeof(double) + sizeof(double) + sizeof(float)</td>
						<td>Representative longitude, latitude, and altitude of this F4D(Deprecated)</td>
					</tr>
					<tr>
						<td>boundingBox</td>
						<td>sizeof(float) × 6</td>
						<td>minX, minY, minZ, maxX, maxY, maxZ of bounding box of this F4D data</td>
					</tr>
				</table>
			</div> 
		</div>
	</section>
	<footer style="margin-top: 67px;">
	<div>
		<h2>
			Contact <span></span>
		</h2>
		<p>mago3D 에 관심있는 고객들께서는 연락(이메일, 전화) 또는 직접 방문을 부탁드립니다.</p>
		<ul class="contact">
			<li class="company">www.gaia3d.com</li>
			<li class="address">+82-(0)2-3397-3475</li>
			<li class="mail">info@gaia3d.com</li>
		</ul>
		<p class="copyright">&copy; 2017 Gaia3D, Inc.</p>
	</div>
	</footer>
</body>

</html>