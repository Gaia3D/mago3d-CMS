package gaia3d.config;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Objects;

import org.junit.jupiter.api.Disabled;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import gaia3d.Mago3dTilerApplication;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@SpringBootTest(classes = Mago3dTilerApplication.class)
class PropertiesConfigTest {

    @Autowired
    private PropertiesConfig propertiesConfig;

    @Disabled
    void createDir() {
        Method[] methods = PropertiesConfig.class.getDeclaredMethods();
        Arrays.stream(methods)
                .filter(a -> a.getName().contains("get") && a.getName().contains("Dir"))
                .map(b -> {
                    try {
                        return (String) b.invoke(propertiesConfig);
                    } catch (IllegalAccessException | InvocationTargetException e) {
                        log.info("-------- createDir. message = {}", e.getMessage());
                    }
                    return null;
                })
                .filter(Objects::nonNull)
                .forEach(c -> {
                    var file = new File(c);
                    log.info("directory ====================== {} ", file);
                    if (!file.isDirectory()) {
                        file.mkdirs();
                    }
                });
    }
}