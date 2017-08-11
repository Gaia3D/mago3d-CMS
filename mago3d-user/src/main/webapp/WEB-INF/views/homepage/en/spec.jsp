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
				<li><a href="/homepage/about.do">mago3D</a></li>
				<li class="mm" onclick='selectMenu();'>Demo<span></span>
					<ul>
						<li><a href="/homepage/demo.do" style="color: white">Cesium</a></li>
						<li><a href="/homepage/demo.do?viewLibrary=worldwind"
							style="color: white">World Wind</a></li>
					</ul>
				</li>
				<li><a href="/homepage/download.do">Download</a></li>
				<li class="on">Documentation<span></span></li>
				<li><a href="/homepage/faq.do">FAQ</a></li>
			</ul>
			<ul class="language">
				<li id="languageKO"><a href="#" onclick="changeLanguage('ko');">KO</a></li>
				<li id="languageEN" class="on">EN</li>
			</ul>
		</div>
	</nav>
	<section>
		<div class="docs-menu">
			<ul>
				<li><a href="/homepage/docs.do">Docs</a></li>
				<li><a href="/homepage/api.do" target="_blank">mago3D.js</a></li>
				<li class="on"><a href="/homepage/spec.do">F4D Converter</a>
			</ul>
		</div>
		<div class="docs-main">
			<div class="title">F4D Converter</div>
			<p>
				
			</p>
			<div class="sub_title">1. Introduction</div>
			<div>Although there have been numerous attempts to integrate BIM and 3D GIS on a single geospatial platform, the outcome of those attempts are not so satisfactory till to date. Difference of data model, massive number of data to be rendered, big volume of file size are among those major technical barriers that hindered seamless integration of BIM and 3D GIS. And there are many increasing demands to see and integrate BIM and 3D GIS on a web browser since web environment has been proven as an effective collaborative platform in architecture and geospatial domains. This abstract introduces an open source based BIM-GIS integration platform called Mago3D(https://github.com/Gaia3D/mago3djs) that could manage, handle, and visualise massive 3D data from BIM and 3D GIS simultaneously on a web browser. Mago3D platform has been developed on top of well-known open source GIS projects, Cesium(http://cesiumjs.org/) and NASA World Wind(https://worldwind.arc.nasa.gov/), to make the best of their existing features and at the same time to expand the functionalities to BIM and AEC(Architecture, Engineering and Construction) areas. </div>
			<div class="sub_title">2. Development of the Mago3D Platform</div>
			<div class="sub_main">
				<div class="sub_title">2.1 Mago3D as a JavaScript Plug-In </div>
				<p>Mago3D has been designed and implemented as a JavaScript plug-in for existing WebGL Globe to expand WebGL Globe's functionality and usability to indoor space and architectural(BIM) areas. To do this, Mago3D.js has been designed and developed as a WebGL independent JavaScript to avoid lock-in to specific WebGL Globe and to increase portability and expandability. 
					Mago3D.js is composed of 6 main components like follows:
				</p>
				<ul>
					<li>Mago3D Connector that interacts with WebGL Globe such as Cesium, World Wind</li>
					<li>Mago3D Renderer that shades and renders 3D data</li>
					<li>Mago3D Accelerator that carries out performance enhancing such as frustum & occlusion culling, indexing, LOD(Level Of Detail) handing</li>
					<li>Mago3D Data Container that contains and manages 3D data</li>
					<li>Mago3D Process Manager that manages whole process from data receiving to rendering</li>
					<li>Mago3D REST API that provides API for 3D data sending and receiving</li>
				</ul>
				<p>
					By plug in Mago3D.js to Cesium, World Wind, or to other WebGL Globe, users can expand those WebGL Globe functionalities and usability to BIM and indoor space without losing the features provided by WebGL Globe as default functions. 
				</p>
				<img alt="mago3DJS 아키텍쳐" src="/images/${lang}/homepage/mago3djs.png">
				<div class="description">Figure 1 Six main components of Mago3D.js</div>
				<div class="sub_title">2.2	Adopting Variable Depth Octree</div>
				<p>To increase the rendering speed and to reduce network traffic, F4D adopted variable depth octree indexing. This indexing recursively decomposes the 3 dimensional space and removes empty space till to find so-called ‘Survived’ octree. The conceptual diagram of this algorithm is explained in Figure 2. </p>
				<img alt="Depth Octree" src="/images/${lang}/homepage/spec2.png" style="margin-left: 50px">
				<div class="description">Figure 2 Conceptual Diagram of Variable Depth Octree</div>
				<p>This kind of Octree indexing gives several benefits over conventional method. First, server can use this indexing information as an efficient data packet. Second, client can increase the rendering speed by easily determining which object should be drawn. Thirdly, network traffic can be reduced by sending/receiving the bundle of Octree data. </p>
				<img alt="Speed using Octree" src="/images/${lang}/homepage/spec3.png" style="margin-left: 30px">
				<div class="description">Figure 3 How to Increase the Rendering Speed using Octree</div>
				<img alt="" src="/images/${lang}/homepage/spec4.png" style="margin-left:40px">
				<div class="description">Figure 4 Reducing network traffic by sending/receiving octree data</div>
				<div class="sub_title">2.3 Devising a New Format</div>
				<p>	
					One of big hurdle to integrate BIM and 3D GIS simultaneously is handling and visualisation of massive 3D data. The file size of 3D surface model converted from parametric BIM model is usually very large. And converted 3D surface model has a tendency to contain many duplicated objects and meshes since those objects are mainly artificial ones. It is very hard to visualise those large size 3D surface model with WebGL Globe itself. To overcome this hurdle, new format called F4D has been devised for reducing file size and increasing rendering speed. F4D format aims at reducing file size of surface model by removing duplicated objects and recording only one object information for duplicated objects with block reference concept. F4D format makes use of unique mesh IDs, transformation matrix, and colour to constitute each 3D objects. 
					Also a format converter that converts popular 3D format to F4D has been developed. Currently industry standard IFC(Industry Foundation Classes), JT(Jupiter Tessellation), and popular 3D formats such as OBJ, 3DS, COLLADA DAE can be converted to F4D format. F4D format coupled with Mago3D.js has proven that it can increase memory management efficiency and rendering speed. MAGO3D can visualise massive 3D data including indoor objects, at least 100k objects, in a single scene seamlessly with traditional outdoor 3D GIS objects on a web browser. 
					Conceptual diagram of how to make F4D format is as follows:
				</p>
				<img alt="" src="/images/${lang}/homepage/spec5.png" style="margin-left:10px">
				<div class="description">Figure 5 Conceptual Diagram of F4D Format</div>
				<p>F4D format is not file based but folder based that contains several datasets. F4D format is composed of 1 header file and 3 sub folders, those are HeaderAsimetric.hed, Bricks folder, Models folder and References folder respectively. Parents folder name of datasets is the same as that of object name in BIM or other 3D files. </p>
				<img src="/images/${lang}/homepage/spec6.png">
				<div class="description">Figure 6 Overall Structure of F4D Format</div>
				<div class="sub_title">2.3.1 HeaderAsimetric.hed</div>
				<p>It contains the metadata of datasets in the F4D format folder and serves as a header file of datasets. Overall structure of HeaderAsimetric.hed is explained in Table 1. </p>
				<b>Table 1 Overall Structure of F4D Format</b>
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
				<b>Table 2 Detailed Stricutre of Octree Dimension Specified in F4D Format</b>
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
				<div class="sub_title">2.3.2 Bricks Folder</div>
				<p>This folder contains low resolution rough geometry information of the objects. F4D converter creates the Lego block style data to increase the rendering speed of large scale 3D objects. This trick could lower the usage of memory of the client and at the same time could increase the rendering speed of large size 3D objects by showing only rough geometry when viewer sees the objects from the long distance. </p>
				<img alt="" src="/images/${lang}/homepage/spec7.png">
				<div class="description">Figure 7 Roughness of objects can be controlled by adjusting block size</div>
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
				</table>
				<div class="sub_title">2.3.3 Models Folder</div>
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
				<b>Table 5 Detailed Structure of Model Data</b>
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
				<b>Table 6 Detailed Structure of VBO Data</b>
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
				<div class="sub_title">2.3.4 Reference Folder</div>
				<p>This folder contains reference information such as position, ID, indexes of 3D objects that is constituting F4D. By combining Reference information and Models information, real 3D objects will be physically rendered on the described place with attributes. Structure of F4D’s Reference information is shown in Table 7, 8.</p>
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
				</table>
				<b>Table 8 Detailed Structure of Reference Data</b>
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
						<td>colorValueType1</td>
						<td>sizeof(unsigned short) bytes</td>
						<td>Default colour value type. Record when bSingleColor == true</td>
					</tr>
					<tr>
						<td>colorDimension1</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Default value is 4(RGBA). Record when bSingleColor == true</td>
					</tr>
					<tr>
						<td>singleColor</td>
						<td>4 × sizeof(unsigned char) bytes</td>
						<td>Reference default colour value(RGBA)</td>
					</tr>
					<tr>
						<td>bVertexColor</td>
						<td>sizeof(bool) bytes</td>
						<td>Record whether to assign colour value to each vertex</td>
					</tr>
					<tr>
						<td>colorValueType2</td>
						<td>sizeof(unsigned short) bytes</td>
						<td>Vertex colour value type. Record when bVertexColor == true.</td>
					</tr>
					<tr>
						<td>colorDimension2</td>
						<td>sizeof(unsigned char) bytes</td>
						<td>Default value is 3(RGB). Record when bVertexColor == true</td>
					</tr>
					<tr>
						<td>vertexCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of vertex that reference has</td>
					</tr>
					<tr>
						<td>vertexColors</td>
						<td>[vertexCount]×3×sizeof(unsigned char) bytes</td>
						<td>Colour value of each vertex</td>
					</tr>
					<tr>
						<td>bTextureCoord</td>
						<td>sizeof(bool) bytes</td>
						<td>Whether uses texture or not</td>
					</tr>
					<tr>
						<td>textureCount</td>
						<td>sizeof(unsigned int) bytes</td>
						<td>No. of texture used</td>
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