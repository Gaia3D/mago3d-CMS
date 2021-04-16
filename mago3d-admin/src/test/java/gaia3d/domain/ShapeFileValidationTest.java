package gaia3d.domain;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import org.geotools.data.shapefile.dbf.DbaseFileHeader;
import org.geotools.data.shapefile.dbf.DbaseFileReader;
import org.geotools.data.shapefile.files.ShpFiles;
import org.junit.jupiter.api.Disabled;

import gaia3d.domain.layer.LayerFileInfo;


public class ShapeFileValidationTest {
	
	@Disabled
	public void test() {
		DbaseFileReader r = null;
        try {
            ShpFiles shpFile = new ShpFiles("D:\\data\\boundary\\sk_emd\\sk_emd_20200115100910_230251955674700.shp");
            r = new DbaseFileReader(shpFile, false, Charset.forName("CP949"));
            DbaseFileHeader header = r.getHeader();
            
            // 필드수
            int filedValidCount = 0;
            int numFields = header.getNumFields();
            for(int iField=0; iField < numFields; iField++) {
                String fieldName = header.getFieldName(iField);
                System.out.println(fieldName);
                if(ShapeFileField.findBy(fieldName) != null) filedValidCount++;
            }
            System.out.println("fieldValidCount ================== " + filedValidCount);
            System.out.println("enum length" + ShapeFileField.values().length);
//            while (r.hasNext()) {
//                Object[] values = r.readEntry();
//                for(int iField=0; iField < numFields; ++iField) {
//                    System.out.println(values[iField].toString());
//                }
//                System.out.println("---------------");
//            }
 
            r.close();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } 
	}
	
	@Disabled
	public void count() {
		LayerFileInfo file0 = new LayerFileInfo();
		file0.setFileExt("shp");
		LayerFileInfo file1 = new LayerFileInfo();
		file1.setFileExt("dbf");
		LayerFileInfo file2 = new LayerFileInfo();
		file2.setFileExt("shx");
		LayerFileInfo file3 = new LayerFileInfo();
		file3.setFileExt("prj");
		List<LayerFileInfo> layerFileInfoList = new ArrayList<>();
		layerFileInfoList.add(file0);
		layerFileInfoList.add(file1);
//		layerFileInfoList.add(file2);
//		layerFileInfoList.add(file3);
		long validCount = layerFileInfoList.stream()
				.filter(layerFileInfo -> {
					String fileExt = layerFileInfo.getFileExt().toLowerCase();
					return fileExt.equals(ShapeFileExt.SHP.getValue()) || fileExt.equals(ShapeFileExt.DBF.getValue()) || fileExt.equals(ShapeFileExt.SHX.getValue());
				})
				.count();
		
		System.out.println("validCount ======================== " + validCount);
		System.out.println("ShapeFileExt enum size ======= " + ShapeFileExt.values().length);
	}
}
