package com.gaia3d.parser;

import java.io.File;
import java.io.FileFilter;

public class ThreeDSFilter implements FileFilter {
	
	private String fileName = ".3ds";
	
	@Override
	public boolean accept(File file) {
		String filename = file.getName().toLowerCase();
		
		if(filename.indexOf(fileName) < 0) return false;
		
//		if(filename.indexOf(objectAttributeFileName) >=0) {
//			// object attribute
//			return false;
//		}
		return true;
	}
}
