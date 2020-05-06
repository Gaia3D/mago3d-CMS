package gaia3d.geospatial;

import java.io.ByteArrayInputStream;
import java.io.InputStream;

import org.geotools.factory.CommonFactoryFinder;
import org.geotools.filter.FilterFactoryImpl;
import org.geotools.sld.SLDConfiguration;
import org.geotools.styling.Fill;
import org.geotools.styling.LineSymbolizer;
import org.geotools.styling.Mark;
import org.geotools.styling.NamedLayer;
import org.geotools.styling.PointSymbolizer;
import org.geotools.styling.PolygonSymbolizer;
import org.geotools.styling.Stroke;
import org.geotools.styling.StyleFactory;
import org.geotools.styling.StyledLayerDescriptor;
import org.geotools.xml.styling.SLDTransformer;
import org.geotools.xsd.Parser;
import org.opengis.filter.FilterFactory;

import gaia3d.domain.GeometryType;

/**
 * sld 파일 스타일링 
 * @author PSH
 *
 */
public class LayerStyleParser {

    int count = 0;

    private String geometryType;
    private String fillValue;
    private Float fillOpacityValue;
    private String strokeValue;
    private Float strokeWidthValue;
    private String styleData;
    
    public LayerStyleParser(String geometryType, String fillValue, Float fillOpacityValue, String strokeValue, Float strokeWidthValue, String styleData) {
        this.geometryType = geometryType;
        this.fillValue = fillValue;
        this.fillOpacityValue = fillOpacityValue;
        this.strokeValue = strokeValue;
        this.strokeWidthValue = strokeWidthValue;
        this.styleData = styleData;

//        if("".equals(this.fillOpacityValue) || this.fillOpacityValue == null) {
//            this.fillOpacityValue="1.0";
//        }
//        if("".equals(this.strokeWidthValue) || this.strokeWidthValue == null) {
//            this.strokeWidthValue="1.0";
//        }
    }

    public String getFillValue() {
        return fillValue;
    }

    public Float getFillOpacityValue() {
        return fillOpacityValue;
    }

    public String getStrokeValue() {
        return strokeValue;
    }

    public Float getStrokeWidthValue() {
        return strokeWidthValue;
    }

    public String getStyleData() {
        return styleData;
    }

	public void updateLayerStyle() throws Exception {
        StyleFactory sf = CommonFactoryFinder.getStyleFactory();
        FilterFactory filterFactory = new FilterFactoryImpl();
        SLDTransformer styleTransform = new SLDTransformer();
        StyledLayerDescriptor sld = (StyledLayerDescriptor) parse();
        NamedLayer layer = (NamedLayer) sld.getStyledLayers()[0];
        Fill fill = sf.createFill(filterFactory.literal(this.fillValue),filterFactory.literal(this.fillOpacityValue));
        Stroke stroke = sf.createStroke(filterFactory.literal(this.strokeValue), filterFactory.literal(this.strokeWidthValue));

        if (GeometryType.POINT == GeometryType.valueOf(this.geometryType.toUpperCase())) {
            PointSymbolizer ps = (PointSymbolizer) layer.getStyles()[0]
                                        .featureTypeStyles()
                                        .get(0)
                                        .rules()
                                        .get(0)
                                        .symbolizers().get(0);
//            ps.getGraphic().getMarks()[0].setFill(fill);
//            ps.getGraphic().getMarks()[0].setStroke(stroke);
            Mark mark = sf.getDefaultMark();
            mark.setFill(fill);
            mark.setStroke(stroke);
            ps.getGraphic().graphicalSymbols().clear();
            ps.getGraphic().graphicalSymbols().add(mark);
            

        } else if (GeometryType.LINE == GeometryType.valueOf(geometryType.toUpperCase())) {
            LineSymbolizer ps = (LineSymbolizer) layer.getStyles()[0]
                                    .featureTypeStyles()
                                    .get(0)
                                    .rules()
                                    .get(0)
                                    .symbolizers()
                                    .get(0);
            ps.setStroke(stroke);

        } else if (GeometryType.POLYGON == GeometryType.valueOf(geometryType.toUpperCase())) {
            PolygonSymbolizer ps = (PolygonSymbolizer) layer.getStyles()[0]
                                        .featureTypeStyles()
                                        .get(0)
                                        .rules()
                                        .get(0)
                                        .symbolizers()
                                        .get(0);
            ps.setFill(fill);
            ps.setStroke(stroke);
        }

        this.styleData = styleTransform.transform(sld);
    }

    private Object parse() throws Exception {
        SLDConfiguration sld = new SLDConfiguration();
        InputStream input = new ByteArrayInputStream(this.styleData.getBytes());
        return new Parser(sld).parse(input);
    }
}
