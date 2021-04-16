package gaia3d.geospatial;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import lombok.extern.slf4j.Slf4j;
import gaia3d.support.ProcessBuilderSupport;

@Slf4j
public class Ogr2OgrExecute {

    // os 종류(WINDOW, LINUX)
    //private String osType;
    private String gdalCommandPath;
    private String driver;
    private String shapeFile;
    private String shapeEncoding;
    private String tableName;
    // 새로 생성할건지, update 할건지, append 인지..... update가 upsert를 지원하는지 모르겠다.
    private String updateOption;
    private String layerSourceCoordinate;
    private String layerTargetCoordinate;
    private String exportPath;
    private String sql;
    //private String environmentPath;

    public Ogr2OgrExecute(String gdalCommandPath, String driver, String shapeFile, String shapeEncoding, String tableName, String updateOption, String layerSourceCoordinate, String layerTargetCoordinate) {
        this.gdalCommandPath = gdalCommandPath;
        this.driver = driver;
        this.shapeFile = shapeFile;
        this.shapeEncoding = shapeEncoding;
        this.tableName = tableName;
        this.updateOption = updateOption;
        this.layerSourceCoordinate = layerSourceCoordinate;
        this.layerTargetCoordinate = layerTargetCoordinate;
    }

    public Ogr2OgrExecute(String gdalCommandPath, String driver, String shapeEncoding, String exportPath, String sql, String layerSourceCoordinate, String layerTargetCoordinate) {
        this.gdalCommandPath = gdalCommandPath;
        this.driver = driver;
        this.shapeEncoding = shapeEncoding;
        this.layerSourceCoordinate = layerSourceCoordinate;
        this.layerTargetCoordinate = layerTargetCoordinate;
        this.exportPath = exportPath;
        this.sql = sql;
    }

    public void insert() throws Exception {

        Path commandPath = Paths.get(gdalCommandPath, "ogr2ogr");

        List<String> command = new ArrayList<>();
        command.add(commandPath.toString());
        command.add("-s_srs");
        command.add(layerSourceCoordinate);
        command.add("-t_srs");
        command.add(layerTargetCoordinate);
        command.add("--config");

        command.add("SHAPE_ENCODING");
        if(shapeEncoding == null || "".equals(shapeEncoding)) {
            command.add("CP949");
        } else {
            command.add(shapeEncoding);
        }

        if("update".equals(this.updateOption)) {
            command.add("-append");
        }

        command.add("-f");
        command.add("PostgreSQL");
        command.add(this.driver);
        
        // shape file full path 파일 확장자 까지
        command.add(this.shapeFile);
        command.add("-nlt");
        command.add("PROMOTE_TO_MULTI");
        // schema 옵션이라서.... 현재는 빼고
//		command.add("-lco");
//		command.add("schema=");
        command.add("-nln");
        command.add(this.tableName);

        log.info(" >>>>>> insert command = {}", String.join(" ", command));
        ProcessBuilderSupport.execute(command, null);
    }

    public void export() throws Exception {

        Path commandPath = Paths.get(gdalCommandPath, "ogr2ogr");

        List<String> command = new ArrayList<>();
        command.add(commandPath.toString());
        command.add("-s_srs");
        command.add(layerSourceCoordinate);
        command.add("-t_srs");
        command.add(layerTargetCoordinate);
        command.add("--config");

        command.add("SHAPE_ENCODING");
        if(shapeEncoding == null || "".equals(shapeEncoding)) {
            command.add("CP949");
        } else {
            command.add(shapeEncoding);
        }
        command.add(exportPath);
        command.add("-f");
        command.add("ESRI Shapefile");
        command.add(this.driver);
        command.add("-sql");
        command.add(sql);

        log.info(" >>>>>> export command = {}", String.join(" ", command));
        ProcessBuilderSupport.execute(command, null);
    }

}