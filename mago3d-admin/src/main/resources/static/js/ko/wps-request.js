function requestBodyRadialLineOfSight(inputCoverage, observerPoint, observerOffset, radius, sides, extent) {
	var xml = '';
	// xml += '<wps:Execute version="1.0.0" service="WPS">';
	xml += requestWPSPostHeader();
	xml += '<ows:Identifier>statistics:RadialLineOfSight</ows:Identifier>';
	xml += '<wps:DataInputs>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>inputCoverage</ows:Identifier>';
	xml += '<wps:Reference mimeType="image/tiff" xlink:href="http://geoserver/wcs" method="POST">';
	xml += '<wps:Body>';
	xml += bodyInputCoverageAll(inputCoverage);
	xml += '</wps:Body>';
	xml += '</wps:Reference>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>observerPoint</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:ComplexData mimeType="application/wkt"><![CDATA[' + observerPoint + ']]></wps:ComplexData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>observerOffset</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>' + observerOffset + '</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>radius</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>' + radius + '</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>sides</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>' + sides + '</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>useCurvature</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>True</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>useRefraction</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>True</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>refractionFactor</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>0.13</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '</wps:DataInputs>';
	xml += '<wps:ResponseForm>';
	xml += '<wps:RawDataOutput mimeType="application/vnd.geo+json">';
	xml += '<ows:Identifier>result</ows:Identifier>';
	xml += '</wps:RawDataOutput>';
	xml += '</wps:ResponseForm>';
	xml += '</wps:Execute>';

	// xml = requestBodyReprojection(xml, sourceProjection, targetProjection);

	return xml;
}


function requestBodyLinearLineOfSight(inputCoverage, observerOffset, observerPoint, targetPoint, extent) {
	var xml = '';
	// xml += '<wps:Execute version="1.0.0" service="WPS">';
	xml += requestWPSPostHeader();
	xml += '<ows:Identifier>statistics:LinearLineOfSight</ows:Identifier>';
	xml += '<wps:DataInputs>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>inputCoverage</ows:Identifier>';
	xml += '<wps:Reference mimeType="image/tiff" xlink:href="http://geoserver/wcs" method="POST">';
	xml += '<wps:Body>';
	// xml += bodyInputCoverage(inputCoverage, extent[0] + ' ' + extent[1], extent[2] + ' ' + extent[3]);
	xml += bodyInputCoverageAll(inputCoverage);
	xml += '</wps:Body>';
	xml += '</wps:Reference>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>observerOffset</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>' + observerOffset + '</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>observerPoint</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:ComplexData mimeType="application/wkt"><![CDATA[' + observerPoint + ']]></wps:ComplexData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>targetPoint</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:ComplexData mimeType="application/wkt"><![CDATA[' + targetPoint + ']]></wps:ComplexData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>useCurvature</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>True</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>useRefraction</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>True</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>refractionFactor</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>0.13</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '</wps:DataInputs>';
	xml += '<wps:ResponseForm>';
	xml += '<wps:RawDataOutput mimeType="application/vnd.geo+json">';
	xml += '<ows:Identifier>result</ows:Identifier>';
	xml += '</wps:RawDataOutput>';
	xml += '</wps:ResponseForm>';
	xml += '</wps:Execute>';

	// xml = requestBodyReprojection(xml, sourceProjection, targetProjection);

	return xml;
}


function requestBodyRasterProfile(inputCoverage, interval, userLine, extent) {
	var xml = '';
	// xml += '<wps:Execute version="1.0.0" service="WPS">';
	xml += requestWPSPostHeader();
	xml += '<ows:Identifier>statistics:RasterProfile</ows:Identifier>';
	xml += '<wps:DataInputs>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>inputCoverage</ows:Identifier>';
	xml += '<wps:Reference mimeType="image/tiff" xlink:href="http://geoserver/wcs" method="POST">';
	xml += '<wps:Body>';
	// xml += bodyInputCoverage(inputCoverage, extent[0] + ' ' + extent[1], extent[2] + ' ' + extent[3]);
	xml += bodyInputCoverageAll(inputCoverage);
	xml += '</wps:Body>';
	xml += '</wps:Reference>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>userLine</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:ComplexData mimeType="application/wkt"><![CDATA[' + userLine + ']]></wps:ComplexData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>interval</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>' + interval + '</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '</wps:DataInputs>';
	xml += '<wps:ResponseForm>';
	xml += '<wps:RawDataOutput mimeType="application/vnd.geo+json">';
	xml += '<ows:Identifier>result</ows:Identifier>';
	xml += '</wps:RawDataOutput>';
	xml += '</wps:ResponseForm>';
	xml += '</wps:Execute>';

	// xml = requestBodyReprojection(xml, sourceProjection, targetProjection);

	return xml;
}


function requestBodyRasterHighLowPoints(inputCoverage, clipArea, valueType, extent) {

	var xml = '';
	// xml += '<wps:Execute version="1.0.0" service="WPS">';
	xml += requestWPSPostHeader();
	xml += '<ows:Identifier>statistics:RasterHighLowPoints</ows:Identifier>';
	xml += '<wps:DataInputs>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>inputCoverage</ows:Identifier>';
	xml += '<wps:Reference mimeType="image/tiff" xlink:href="http://geoserver/wcs" method="POST">';
	xml += '<wps:Body>';
	// xml += bodyInputCoverage(inputCoverage, extent[0] + ' ' + extent[1], extent[2] + ' ' + extent[3]);
	xml += bodyInputCoverageAll(inputCoverage);
	xml += '</wps:Body>';
	xml += '</wps:Reference>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>cropShape</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:ComplexData mimeType="application/wkt"><![CDATA[' + clipArea + ']]></wps:ComplexData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '<wps:Input>';
	xml += '<ows:Identifier>valueType</ows:Identifier>';
	xml += '<wps:Data>';
	xml += '<wps:LiteralData>' + valueType + '</wps:LiteralData>';
	xml += '</wps:Data>';
	xml += '</wps:Input>';
	xml += '</wps:DataInputs>';
	xml += '<wps:ResponseForm>';
	xml += '<wps:RawDataOutput mimeType="application/vnd.geo+json">';
	xml += '<ows:Identifier>result</ows:Identifier>';
	xml += '</wps:RawDataOutput>';
	xml += '</wps:ResponseForm>';
	xml += '</wps:Execute>';

	// xml = requestBodyReprojection(xml, sourceProjection, targetProjection);

	return xml;
}

// 3857
// function bodyInputCoverage(inputCoverage) {
// 	var xml = '';
// 	xml += '<wcs:GetCoverage service="WCS" version="1.1.1">';
// 	xml += '<ows:Identifier>' + inputCoverage + '</ows:Identifier>';
// 	xml += '<wcs:DomainSubset>';
// 	xml += '<gml:BoundingBox crs="urn:ogc:def:crs:EPSG::3857">';
// 	xml += '<ows:LowerCorner>1.4010488298365284E7 3910341.55453927</ows:LowerCorner>';
// 	xml += '<ows:UpperCorner>1.4451076331565324E7 4673902.380091724</ows:UpperCorner>';
// 	xml += '</gml:BoundingBox>';
// 	xml += '</wcs:DomainSubset>';
// 	xml += '<wcs:Output format="image/tiff">';
// 	xml += '<wcs:GridCRS>';
// 	xml += '<wcs:GridBaseCRS>urn:ogc:def:crs:EPSG::3857</wcs:GridBaseCRS>';
// 	xml += '<wcs:GridType>urn:ogc:def:method:WCS:1.1:2dSimpleGrid</wcs:GridType>';
// 	xml += '<GridOffsets>37.32215444303604 -36.85139119461652</GridOffsets>';
// 	xml += '<wcs:GridCS>urn:ogc:def:cs:OGC:0.0:Grid2dSquareCS</wcs:GridCS>';
// 	xml += '</wcs:GridCRS>';
// 	xml += '</wcs:Output>';
// 	xml += '</wcs:GetCoverage>';
// 	return xml;
// }

// 4326
function bodyInputCoverage(inputCoverage, lowerCorner, upperCorner) {
	var xml = '';
	xml += '<wcs:GetCoverage service="WCS" version="1.1.1">';
	xml += '<ows:Identifier>' + inputCoverage + '</ows:Identifier>';
	xml += '<wcs:DomainSubset>';
	xml += '<gml:BoundingBox crs="urn:ogc:def:crs:EPSG::4326">';
	xml += '<ows:LowerCorner>' + lowerCorner + '</ows:LowerCorner>';
	xml += '<ows:UpperCorner>' + upperCorner + '</ows:UpperCorner>';
	xml += '</gml:BoundingBox>';
	xml += '</wcs:DomainSubset>';
	xml += '<wcs:Output format="image/tiff">';
	xml += '<wcs:GridCRS>';
	xml += '<wcs:GridBaseCRS>urn:ogc:def:crs:EPSG::4326</wcs:GridBaseCRS>';
	xml += '<wcs:GridType>urn:ogc:def:method:WCS:1.1:2dSimpleGrid</wcs:GridType>';
	xml += '<GridOffsets>3.352706177043618E-4 -2.681982533932279E-4</GridOffsets>';
	xml += '<wcs:GridCS>urn:ogc:def:cs:OGC:0.0:Grid2dSquareCS</wcs:GridCS>';
	xml += '</wcs:GridCRS>';
	xml += '</wcs:Output>';
	xml += '</wcs:GetCoverage>';

	return xml;
}

function bodyInputCoverageAll(inputCoverage) {
	var xml = '';
	xml += '<wcs:GetCoverage service="WCS" version="1.1.1">';
	xml += '<ows:Identifier>' + inputCoverage + '</ows:Identifier>';
	xml += '<wcs:DomainSubset>';

	//geoserver 2.12.5 
	//xml += '<ows:BoundingBox crs="urn:ogc:def:crs:EPSG::4326">';
	
	//geoserver 2.16.x 
	xml += '<ows:BoundingBox  crs="http://www.opengis.net/gml/srs/epsg.xml#4326">';
	if ( inputCoverage == 'mago3d:dem') {
		xml += '<ows:LowerCorner>122.99986111111112 32.999861111111116</ows:LowerCorner>';
		xml += '<ows:UpperCorner>132.0001388888889 44.00013888888889</ows:UpperCorner>';
	} else if ( inputCoverage == 'mago3d:dsm') {
		xml += '<ows:LowerCorner>125.57264500000001 38.93901000503942</ows:LowerCorner>';
		xml += '<ows:UpperCorner>125.92047999121296 39.13849500000006</ows:UpperCorner>';
	}

	xml += '</ows:BoundingBox>';
	xml += '</wcs:DomainSubset>';

	//xml += '<wcs:Output format="image/tiff"/>';

	xml += '<wcs:Output format="image/tiff"/>';
	xml += '</wcs:GetCoverage>';

	return xml;
}


function requestBodyReprojection(xml, sourceProjection, targetProjection) {
    var reproject = '';
    reproject += '<?xml version="1.0" encoding="UTF-8"?>';
    reproject += '<wps:Execute version="1.0.0" service="WPS" '
	reproject += '	xsi:schemaLocation="http://www.opengis.net/wps/1.0.0 http://schemas.opengis.net/wps/1.0.0/wpsAll.xsd" ';
	reproject += '	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ';
	reproject += '	xmlns="http://www.opengis.net/wps/1.0.0" ';
	reproject += '	xmlns:wfs="http://www.opengis.net/wfs" ';
	reproject += '	xmlns:wps="http://www.opengis.net/wps/1.0.0" ';
	reproject += '	xmlns:ows="http://www.opengis.net/ows/1.1" ';
	reproject += '	xmlns:gml="http://www.opengis.net/gml" ';
	reproject += '	xmlns:ogc="http://www.opengis.net/ogc" ';
	reproject += '	xmlns:wcs="http://www.opengis.net/wcs/1.1.1" ';
	reproject += '	xmlns:xlink="http://www.w3.org/1999/xlink">';
    reproject += '<ows:Identifier>gs:Reproject</ows:Identifier>'
    reproject += '<wps:DataInputs>';
    reproject += '<wps:Input>';
    reproject += '<ows:Identifier>features</ows:Identifier>';
    reproject += '<wps:Reference mimeType="text/xml" xlink:href="http://geoserver/wps" method="POST">';
    reproject += '<wps:Body>'
    reproject += xml;
    reproject += '</wps:Body>';
    reproject += '</wps:Reference>';
    reproject += '</wps:Input>';
    reproject += '<wps:Input>';
    reproject += '<ows:Identifier>forcedCRS</ows:Identifier>';
    reproject += '<wps:Data>';
    reproject += '<wps:LiteralData>' + sourceProjection + '</wps:LiteralData>'
    reproject += '</wps:Data>';
    reproject += '</wps:Input>';
    reproject += '<wps:Input>';
    reproject += '<ows:Identifier>targetCRS</ows:Identifier>';
    reproject += '<wps:Data>';
    reproject += '<wps:LiteralData>' + targetProjection + '</wps:LiteralData>';
    reproject += '</wps:Data>';
    reproject += '</wps:Input>';
    reproject += '</wps:DataInputs>';
    reproject += '<wps:ResponseForm>';
    reproject += '<wps:RawDataOutput mimeType="application/vnd.geo+json">';
    reproject += '<ows:Identifier>result</ows:Identifier>';
    reproject += '</wps:RawDataOutput>';
    reproject += '</wps:ResponseForm>';
    reproject += '</wps:Execute>';

    return reproject;
}


function requestWPSPostHeader() {
	var header = '';
	header += '<?xml version="1.0" encoding="UTF-8"?>';
	header += '<wps:Execute version="1.0.0" service="WPS" '
	header += '	xsi:schemaLocation="http://www.opengis.net/wps/1.0.0 http://schemas.opengis.net/wps/1.0.0/wpsAll.xsd" ';
	header += '	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ';
	header += '	xmlns:xlink="http://www.w3.org/1999/xlink" ';
	header += '	xmlns="http://www.opengis.net/wps/1.0.0" ';
	header += '	xmlns:wfs="http://www.opengis.net/wfs" ';
	header += '	xmlns:wps="http://www.opengis.net/wps/1.0.0" ';
	header += '	xmlns:ows="http://www.opengis.net/ows/1.1" ';
	header += '	xmlns:gml="http://www.opengis.net/gml" ';
	header += '	xmlns:ogc="http://www.opengis.net/ogc" ';
	header += '	xmlns:wcs="http://www.opengis.net/wcs/1.1.1">';

	return header;
}
