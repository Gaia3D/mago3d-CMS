package com.gaia3d.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.junit.Test;

public class JDBCConnectionTest {

	@Test
	public void test() {
		
		try {
			Class.forName("org.postgresql.Driver");
			Connection conn = null;
			conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/mago3d", "postgres", "postgres");
			PreparedStatement psmt = conn.prepareStatement("select count(*) as count from user_info");
			ResultSet rs = null;
			rs = psmt.executeQuery();
			while (rs.next()) {
				System.out.println(rs.getString("count"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
