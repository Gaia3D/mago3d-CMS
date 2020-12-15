package gaia3d.utils;

import gaia3d.Mago3dAdminApplication;
import gaia3d.config.PropertiesConfig;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.File;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.Objects;

@Slf4j
@SpringBootTest(classes = {PropertiesConfig.class, Mago3dAdminApplication.class})
public class PropertiesTest {

    @Autowired
    private PropertiesConfig propertiesConfig;

    @Test
    void createDir() {
        Method[] methods = PropertiesConfig.class.getDeclaredMethods();
        Arrays.stream(methods)
                .filter(a -> a.getName().contains("get") && a.getName().contains("Dir"))
                .map(b -> {
                    try {
                        return (String) b.invoke(propertiesConfig);
                    } catch (IllegalAccessException | InvocationTargetException e) {
                        e.printStackTrace();
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
