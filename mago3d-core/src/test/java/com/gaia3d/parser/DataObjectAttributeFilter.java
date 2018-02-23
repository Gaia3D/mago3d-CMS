package com.gaia3d.parser;

import java.io.File;
import java.io.FileFilter;

public class DataObjectAttributeFilter implements FileFilter {
	
	// data object attribute 가 아닌것이 data attribute가 됨
	private String objectAttributeFileName = "_object_";

	@Override
	public boolean accept(File file) {
		String filename = file.getName().toLowerCase();
		if(filename.indexOf(objectAttributeFileName) >=0) {
			// object attribute
			return true;
		}
		return false;
	}
}
