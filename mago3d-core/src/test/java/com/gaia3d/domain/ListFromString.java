package com.gaia3d.domain;

import static org.junit.Assert.*;

import org.junit.Test;

public class ListFromString {

	@Test
	public void test() {
		String projects = "{3ds.json,ifc_cultural_assets.json,ifc_mep.json,ifc.json,ifc_japan.json,sea_port.json,collada.json}";
		int deleteStartCharIndex = projects.indexOf("{") + 1;
		int deleteEndCharIndex = projects.indexOf("}");
		System.out.println(projects.substring(deleteStartCharIndex, deleteEndCharIndex));
		String[] projectArray = projects.substring(deleteStartCharIndex, deleteEndCharIndex).split(",");
		for(int i=0; i<projectArray.length; i++) {
			System.out.println(projectArray[i]);
		}
	}

}
