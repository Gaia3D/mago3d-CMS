package gaia3d.utils;

import lombok.extern.slf4j.Slf4j;

import java.io.File;

@Slf4j
public class FileUtils {

    private FileUtils() {
        throw new AssertionError();
    }

    public static boolean makeDirectory(String targetDirectory) {
        File directory = new File(targetDirectory);
        if(directory.exists()) {
            return true;
        } else {
            return directory.mkdir();
        }
    }

}
