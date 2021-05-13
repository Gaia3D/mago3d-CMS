package gaia3d.domain.search;

import lombok.Getter;
import lombok.Setter;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;
import org.springframework.web.util.UriUtils;

import java.util.Arrays;
import java.util.stream.Collectors;

@Getter
@Setter
public class SearchParam {

    private String service = "search";
    private String request = "search";
    private float version = 2.0f;
    private String crs = "EPSG:4326";
    private double[] bbox = new double[]{126, 34, 128, 38};
    private int size = 10;
    private int page = 1;
    private String query;
    private String type = "place";
    private String format = "json";
    private String errorFormat = "json";
    private String key = "C4D60206-F878-3F41-B7B3-2EF176C54142";

    public String getSearchRequestURI(String url) {
        return UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("service", this.service)
                .queryParam("request", this.request)
                .queryParam("version", this.version)
                .queryParam("crs", this.crs)
                .queryParam("bbox", Arrays.stream(this.bbox).mapToObj(String::valueOf).collect(Collectors.joining(",")))
                .queryParam("size", this.size)
                .queryParam("page", this.page)
                .queryParam("query", UriUtils.encode(this.query, "UTF-8"))
                .queryParam("type", this.type)
                .queryParam("format", this.format)
                .queryParam("errorformat", this.errorFormat)
                .queryParam("key", UriUtils.encode(this.key, "UTF-8"))
                .build(false).toString();
    }

}