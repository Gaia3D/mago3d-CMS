package com.gaia3d.domain;

import java.io.File;
import java.io.FileFilter;

public class DataObjectAttributeFilter implements FileFilter {
	
	// data object attribute 가 아닌것이 data attribute가 됨
	private String includeName = "_object";
	private String objectAttributeFileName = "_object_";

	@Override
	public boolean accept(File file) {
		String filename = file.getName().toLowerCase();
		
		if(filename.indexOf(includeName) < 0) return false;
		
//		if(filename.indexOf(objectAttributeFileName) >=0) {
//			// object attribute
//			return true;
//		}
		return true;
	}
}
