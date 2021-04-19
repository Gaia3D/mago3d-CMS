package gaia3d.geospatial;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.charset.Charset;

import org.geotools.data.shapefile.dbf.DbaseFileHeader;
import org.geotools.data.shapefile.dbf.DbaseFileReader;
import org.geotools.data.shapefile.files.ShpFileType;
import org.geotools.data.shapefile.files.ShpFiles;

import lombok.extern.slf4j.Slf4j;
import gaia3d.domain.ShapeFileExt;
import gaia3d.domain.ShapeFileField;

/**
 * Shape file 관련 유틸 
 *
 */
@Slf4j
public class ShapeFileParser {
	
	// shapefile 경로 
	private String filePath; 
	
	public ShapeFileParser(String filePath) {
		this.filePath = filePath;
	}
	
	/**
	 * shape file의 필수 칼럼 검사 
	 * @return
	 */
	public Boolean fieldValidate() {
		DbaseFileReader reader = null;
		Boolean fieldValid = false; 
        try {
            ShpFiles shpFile = new ShpFiles(filePath);
            if(!shpFile.exists(ShpFileType.SHP)) {
            	return true;
            }
            // field만 검사할 것이기 때문에 따로 인코딩은 설정하지 않음 
            reader = new DbaseFileReader(shpFile, false, Charset.defaultCharset());
            DbaseFileHeader header = reader.getHeader();
            int filedValidCount = 0;
            // 필드 카운트
            int numFields = header.getNumFields();
            for(int iField=0; iField < numFields; ++iField) {
                String fieldName = header.getFieldName(iField);
                if(ShapeFileField.findBy(fieldName) != null) filedValidCount++;
            }
            // 필수 칼럼이 모두 있는지 확인한 결과 리턴 
            fieldValid = (filedValidCount == ShapeFileField.values().length) ? true : false;
            
            reader.close();
        } catch (MalformedURLException e) {
            log.info("MalformedURLException ============ {}", e.getMessage());
        } catch (IOException e) {
            log.info("IOException ============== {} ", e.getMessage());
        }
        
        return fieldValid;
	}
	/**
	 * shape 파일 파싱
	 * @param fileName
	 */
	public void parse(String fileName) {
//		try {
//			File file = new File(fileName);
//			FileDataStore myData = FileDataStoreFinder.getDataStore(file);
//			SimpleFeatureSource source = myData.getFeatureSource();
//			SimpleFeatureType schema = source.getSchema();
//	
//			Query query = new Query(schema.getTypeName());
//			// query.setMaxFeatures(1);
//	
//			FeatureCollection<SimpleFeatureType, SimpleFeature> collection = source.getFeatures(query);
//			try (FeatureIterator<SimpleFeature> features = collection.features()) {
//				while (features.hasNext()) {
//					SimpleFeature feature = features.next();
//					log.info(feature.getID() + ": ");
//					for (Property attribute : feature.getProperties()) {
//						if (attribute.getType() instanceof GeometryTypeImpl) {
//							log.info("\t\t" + attribute.getName() + ":" + attribute.getValue());
//						} else {
//							log.info("\t" + attribute.getName() + ":" + attribute.getValue());
//						}
//					}
//				}
//			}
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
	}
}
