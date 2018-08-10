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
	<script type="text/javascript" src="/externlib/jquery/jquery.js"></script>
	<script type="text/javascript" src="/js/homepage-scrolling.js"></script>
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
						<li><a href="/homepage/news.do" style="color: white" onclick="alert('준비 중 입니다.'); return false">News</a></li>
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
				<li id="languageKO" class="on">KO</li>
				<li id="languageEN"><a href="/homepage/spec.do" onclick="changeLanguage('en');">EN</a></li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="docs-main content">
			<h2 style="margin-bottom: 5px;">F4D Converter</h2>
			<div class="line"></div>
			<div class="sub_main">
				<div class="sub_title">1. Format structure</div>
				<div>F4D is composed of 1 header file, 3 folders for indoor data structure, 3 binary files for outdoor data structure and 4 image files for textures used in LOD 2~5. Different with LOD systems of other 3D graphics fields, LOD system of F4D has reverse LOD order. The lower number LOD a model has, the more detailed data it has. It is for, in future, supporting flexible LOD based on an idea that bigger buildings can be seen from further distance. The name of the folder which contains one F4D dataset is ‘F4D_[dataKey]’ where ‘dataKey’ is an unique key for an F4D dataset.</div>
				<img src="/images/${lang}/homepage/spec0.png">
				<div class="description">Figure 1. Overall Structure of F4D Format</div>
				<div>objectIndexFile.ihe is necessary to publish F4D data through web services. This file is a temporary metadata, which is going to nothing. (The role of this file is being implemented in other parts mago3D and this file is being removed. not removed completely yet.) This file should be in F4D data folder for web service at the same depth as each F4D data folders.</div>
				<img src="/images/${lang}/homepage/spec1.png">
				<div class="description">Figure 2. objectIndexFile.ihe</div>
				<ul>
					<li>"Length of Bytes” in all following table contents are described by C++ style.</li>
				</ul>
				<div class="sub_title">1.1 HeaderAsimetric.hed</div>
				<p>It contains the metadata for 3D GIS of datasets in an F4D folder and serves as a header file of datasets. Overall structure of HeaderAsimetric.hed is explained in Table 1, 1-1, and 1-2.</p>
<!-- Table 1 -->	
				<br><b>Table 1 Structure of HeaderAsimetric.hed</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>version</td>
						<td>5 x sizeof(char) bytes</td>
						<td>F4D version info. Latest verison is 0.0.1</td>
					</tr>
					<tr>
						<td>guidLength</td>
						<td>sizeof(int) bytes</td>
						<td>Length of guid</td>
					</tr>
					<tr>
						<td>guid</td>
						<td>[guidLength] x sizeof(char) bytes</td>
						<td>Guid. Reserved. Not used now.</td>
					</tr>
					<tr>
						<td>longitude<br>latitude</td>
						<td>2 x sizeof(double) bytes</td>
						<td>Longitude, latitude(degree) of datasets. Not used now.</td>
					</tr>
					<tr>
						<td>altitude</td>
						<td>sizeof(float) bytes</td>
						<td>Altitude (unit: m) of datasets. Not used now.</td>
					</tr>
					<tr>
						<td>bbox</td>
						<td>6 x sizeof(float) bytes</td>
						<td>Bounding box of minX, minY, minZ, maxX, maxY, maxZ in meter</td>
					</tr>
					<tr>
						<td>octree dimension</td>
						<td>flexible</td>
						<td>Hierarchy info of octree structure</td>
					</tr>
					<tr>
						<td>textureCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Count of textures used in the F4D</td>
					</tr>
					<tr>
						<td>textureInfo</td>
						<td><img src="/images/${lang}/homepage/spec2.png" class="specImage" style="width: 130px;"><span> bytes</span></td>
						<td>all texture information</td>
					</tr>
					<tr>
						<td>lodCount</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Count of all supported LOD</td>
					</tr>
					<tr>
						<td>lodInfo</td>
						<td><img src="/images/${lang}/homepage/spec3.png" class="specImage" style="width: 100px;"><span> bytes</span></td>
						<td>all supported LOD info</td>
					</tr>
				</table>
<!-- Table 1-1 -->				
				<br><b>Table 1-1 Detailed Structure of “octree dimension” Specified in Table 1</b>
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
<!-- Table 1-2 -->					
				<br><b>Table 1-2 Detailed Structure of “textureInfo” Specified in Table 1</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>textureTypeLength</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Length of string for texture type</td>
					</tr>
					<tr>
						<td>textureType</td>
						<td>[textureTypeLength] × sizeof(char) bytes</td>
						<td>Texture type. Only “diffuse” is used now.</td>
					</tr>
					<tr>
						<td>textureFileNameLength</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Length of string for texture file name</td>
					</tr>
					<tr>
						<td>textureFileName</td>
						<td>[textureFileNameLength] × sizeof(char) bytes</td>
						<td>Texture file name</td>
					</tr>
				</table>
<!-- Table 1-3 -->	
				<br><b>Table 1-3 Detailed Structure of “lodInfo” Specified in Table 1</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>lod</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>LOD number</td>
					</tr>
					<tr>
						<td>bDividedBySpatialOctree</td>
						<td>sizeof(bool) bytes</td>
						<td>whether this LOD is divided by octree</td>
					</tr>
					<tr>
						<td>lodFileNameLength</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Length of string for LOD data file name</td>
					</tr>
					<tr>
						<td>lodFileName</td>
						<td>[lodFileNameLength] × sizeof(char) bytes</td>
						<td>LOD data file name. Only available when lod >= 3.(that is, only outdoor)</td>
					</tr>
					<tr>
						<td>lodTextureFileNameLength</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Length of string for LOD texture file name</td>
					</tr>
					<tr>
						<td>lodTextureFileName</td>
						<td>[lodTextureFileNameLength] × sizeof(char) bytes</td>
						<td>LOD texture file name. Only available when LOD >=2.(that is, only data made by NSM method)</td>
					</tr>
				</table>				

				<div class="sub_title">1.2 Bricks Folder</div>
				<p>This folder contains binary files of LOD2 geometric data. F4D converter splits an original 3D model data into smaller-sized models divided by octrees, and applies NSM(Net Surface Mesh) method on each octree to reduce data size and creates rougher data. The name of each files is “[octreeNumber]_brick”. The count of digit of octreeNumber represents the depth of octree system and non-existing octreeNumber means that there is no intersection between original model and the octree of that octreeNumber.</p>
				<img alt="" src="/images/${lang}/homepage/spec4.png">
				<div class="description">Figure 3. before/after NSM is applied.</div>
				<img alt="" src="/images/${lang}/homepage/spec5.png">
				<div class="description">Figure 4. Sample “Bricks” folder of depth 1 octree. Octree 4, 7, and 8 are removed.</div>
<!-- Table 2 -->				
				<div class="sub_title">Overall structure of LOD2 files in “Bricks” folder is explained in Table 2.</div>
				<b>Table 2 Overall Structure of LOD2 file</b>
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
						<td>x, y, z components of normal vectors. Only record when bNormal == true</td>
					</tr>
					<tr>
						<td>bColor</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether colour array is existing or not</td>
					</tr>
					<tr>
						<td>colorCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of colours (same as No. of vertex count) Only record when bColour == true</td>
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
				<p>This folder contains original 3D objects information called Models that constitutes F4D itself. Models will be made to be an instance physically in the 3D space by pairing Reference information in Reference folder. Structure of F4D’s Model information is shown in Table 3, 3-1, 3-2.</p>
<!-- Table 3 -->
				<br><b>Table 3 Overall Structure of Models File</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>version</td>
						<td>5 × sizeof(char) bytes</td>
						<td>Version of F4D. latest version is 0.0.1</td>
					</tr>
					<tr>
						<td>modelCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of Models that References in octree refers</td>
					</tr>
					<tr>
						<td>modelData</td>
						<td><img src="/images/${lang}/homepage/spec6.png" class="specImage" style="width: 100px;"> bytes</td>
						<td>Data of each Model</td>
					</tr>
				</table>
<!-- Table 3-1 -->				
				<br><b>Table 3-1 Detailed Structure of “modelData” in Table 3</b>
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
						<td><img src="/images/${lang}/homepage/spec7.png" class="specImage" style="width: 100px;"> bytes</td>
						<td>Data of each VBO</td>
				</table>
<!-- Table 3-2 -->	
				<br><b>Table 3-2 Detailed Structure of “vboData” in Table 3-1</b>
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
						<td>[normalCount] × 3 × sizeof(char) bytes</td>
						<td>Normal vectors of x, y, z</td>
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
						<td>Array that records indexes of vertex of each triangle</td>
					</tr>
					<tr>
						<td>dummy boolean</td>
						<td>sizeof(bool) bytes</td>
						<td>just false.</td>
					</tr>
				</table>
				
				<div class="sub_title">1.4 Reference Folder</div>
				<p>This folder contains binary files of reference information such as position, ID, indexes of 3D objects that is constituting F4D. By combining Reference information and Models information, real 3D objects will be physically rendered on the described place with attributes (- called as “3D objects are instantiated.”). Reference files are created along spatial octrees so that the name of a reference file is “[octreeNumber]_ref”. </p>
				<img src="/images/${lang}/homepage/spec8.png">
				<div class="description">Figure 5. Sample “Reference” folder of depth 1 octree. Octree 4, 7, and 8 are removed.</div>
<!-- Table 4 -->		
				<div class="sub_title">Structure of F4D’s Reference information is shown in Table 4, 4-1, 4-2, 4-3.</div>
				<b>Table 4 Overall Structure of Reference File</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>version</td>
						<td>5 × sizeof(char) bytes</td>
						<td>Version of F4D. latest version is 0.0.1</td>
					</tr>
					<tr>
						<td>refereneCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of reference in the octree</td>
					</tr>
					<tr>
						<td>referenceData</td>
						<td><img src="/images/${lang}/homepage/spec9.png" class="specImage" style="width: 150px;"/> bytes</td>
						<td>Data of each reference</td>
					</tr>
					<tr>
						<td>triangleCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Total triangle count in this reference</td>
					</tr>
					<tr>
						<td>exteriorVisibilityIndices</td>
						<td>flexible</td>
						<td>Visibility indices for exterior occlusion culling. Written recursively for all vision octrees</td>
					</tr>
					<tr>
						<td>interiorVisibilityIndices</td>
						<td>flexible</td>
						<td>Visibility indices for exterior occlusion culling. Written recursively for all vision octrees</td>
					</tr>
				</table>
<!-- Table 4-1 -->					
				<br><b>Table 4-1 Detailed Structure of “referenceData” in Table 4</b>
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
						<td>transformMatrixType</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Transform matrix type. 0 is for identity, 1 is for translation so that only 3 floating numbers are written for transform matrix, and 2 is for translation & rotation so that full 16 floating numbers are written for transform matrix.</td>
					</tr>
					<tr>
						<td>transformMatrix</td>
						<td>- transformMatrixType == 0
							<br>Not write anything
							<br>- transformMatrixType == 1
							<br>3 × sizeof(float) bytes
							<br>- transformMatrixType == 2
							<br>16 × sizeof(float) bytes
						</td>
						<td>- transformMatrixType == 0
							<br>Identity matrix
							<br>- transformMatrixType == 1
							<br>3 elements of transform matrix
							<br>- transformMatrixType == 2
							<br>16 elements of transform matrix
						</td>
					</tr>
					<tr>
						<td>bSingleColor</td>
						<td>sizeof(bool) bytes</td>
						<td>whether a representative color is available</td>
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
						<td>Count of VBO(vertex buffer object). </td>
					</tr>
					<tr>
						<td>vertexColorAndTextureCoordinateInfo</td>
						<td>∑sizeOfvertexColor&textureCoord</td>
						<td>vertex colours and texture coordinates of this reference on each vbo</td>
					</tr>
					<tr>
						<td>textureIndex</td>
						<td>sizeof(int) bytes</td>
						<td>index to a texture file name used by this reference in the list written in HeaderAsimetric.hed. -1 means not using any texture file.</td>
					</tr>
				</table>
<!-- Table 4-2 -->					
				<br><b>Table 4-2 Detailed Structure of “vertexColorAndTextureCoordinateInfo” in Table 4-1</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>vertexColorType</td>
						<td>sizeof(unsigned short) bytes</td>
						<td>GL enumeration value for color. Now only 5121 supported. Only record when bVertexColor in Table 4-1 == true</td>
					</tr>
					<tr>
						<td>vertexColorDimension</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Channel count of vertex colour. Now fixed as 3. Only record when bVertexColor in Table 4-1 == true</td>
					</tr>
					<tr>
						<td>vertexCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Vertex count in this vbo. Only record when bVertexColor in Table 4-1 == true</td>
					</tr>
					<tr>
						<td>vertexColors</td>
						<td>[vertexCount] × vertexColorDimension × sizeof(unsigned char) bytes</td>
						<td>Vertex color of each vertex. Only record when bVertexColor in Table 4-1 == true</td>
					</tr>
					<tr>
						<td>textureCoordinateValueType</td>
						<td>sizeof(unsigned short) bytes</td>
						<td>GL enumeration value for texture coordinate. Now firxed as 5126. Only record when bTextureCoord in Table 4-1 == true</td>
					</tr>
					<tr>
						<td>vertexCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Vertex count in this vbo. Only record when bTextureCoord in Table 4-1 == true</td>
					</tr>
					<tr>
						<td>textureCoordinates</td>
						<td>[vertexCount] × 2 × sizeof(float) bytes</td>
						<td>u, v coordinate of each vertex. Only record when bTextureCoord in Table 4-1 == true</td>
					</tr>
				</table>
<!-- Table 4-3 -->				
				<br><b>Table 4-3 Detailed Structure of “exteriorVisibilityIndices” and “interiorVisibilityIndices” in Table 4</b>
				<table>
					<tr>
						<th>Name of the Field</th>
						<th>Length of Bytes</th>
						<th>Remarks</th>
					</tr>
					<tr>
						<td>bRoot</td>
						<td>sizeof(bool) bytes</td>
						<td>Whether this vision octree is root</td>
					</tr>
					<tr>
						<td>bbox</td>
						<td>sizeof(float) × 6 bytes</td>
						<td>minX, maxX, minY, maxY, minZ, maxZ of this vision octree. Only record when bRoot == true
							<br>(Be cautious of the order of saving. Different with that of bounding box in the file “HeaderAsimetric.hed”)
						</td>
					</tr>
					<tr>
						<td>childCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>Count of available children of this vision octree</td>
					</tr>
					<tr>
						<td>referenceCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of references which can be seen from this vision octree. Only record when childCount == 0(that is, this octree is a leaf octree)</td>
					</tr>
					<tr>
						<td>referenceIndices</td>
						<td>[referenceCount] × sizeof(unsigned int) bytes</td>
						<td>Indices of references which can be seen from this vision octree. Only record when childCount == 0(that is, this octree is a leaf octree)</td>
					</tr>
					<tr>
						<td>childVisionOctreeInfo</td>
						<td>flexible</td>
						<td>Record contents of this table recursively. Only record when childCount > 0</td>
					</tr>
				</table>
				
				<div class="sub_title">1.5 Images_Resized folder</div>
				<p>This folder is for image files for texture mapping. Files in this folder are created only when raw data has images for texture. Because WebGL accepts texture images only with width and height of power of 2 pixels, resized texture images are created if necessary.</p>
				<div class="sub_title">1.6	lod[lod] (lod : 3, 4, 5)</div>
				<p>These files are geometric data for LOD 3~5. Data structure of these files are exactly same as files in “Bricks” folder, that is, LOD2 data file.</p>
				<div class="sub_title">1.7	MosaicTextureLOD[lod].png (lod : 2, 3, 4, 5)</div>
				<p>This files are for texture mapping of LOD 2~5.</p>
				<div class="sub_title">1.8	objectIndexFile.ihe</div>
				<p>As described in “1. Format structure”, this file is metadata of full set of all F4D data on web service.
					<br>Structure of objectIndexFile.ihe is shown in Table 10 and 11.
				</p>				
<!-- Table 5 -->					
				<br><b>Table 5 Overall Structure of Reference File</b>
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
<!-- Table 5-1 -->	
				<br><b>Table 5-1 Detailed Structure of “eachDataFolderInfo” in Table 5</b>
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
						<td>sizeof(float) × 6 bytes</td>
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