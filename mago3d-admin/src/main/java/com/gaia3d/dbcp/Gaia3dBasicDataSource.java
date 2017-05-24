//package com.gaia3d.dbcp;
//
//import 
//
//public class Gaia3dBasicDataSource extends BasicDataSource {
//	@Override
//	public void setPassword(String password) {
//		super.setPassword(Crypt.decrypt(password));
//	}
//
//	@Override
//	public synchronized void setUrl(String url) {
//		super.setUrl(Crypt.decrypt(url));
//	}
//
//	@Override
//	public void setUsername(String username) {
//		super.setUsername(Crypt.decrypt(username));
//	}
//}