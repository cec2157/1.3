<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog</title>
<%!
	public boolean verify(String username, String password) {
		Connection conn = null;
		String error_msg = "";
		
		try {
			OracleDataSource ods = new OracleDataSource();
			ods.setURL("jdbc:oracle:thin:pq2117/zhaozhong@//w4111b.cs.columbia.edu:1521/ADB");
			conn = ods.getConnection();
		} catch (SQLException e) {
			error_msg = e.getMessage();
		}
		
		ResultSet rset = null;
		try {
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery("SELECT * FROM bloguser WHERE username = " + username + "AND password = " + password);
		} catch (SQLException e) {
			error_msg += e.getMessage();
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e1) {
					error_msg += e1.getMessage();
				}
			}
		}
		
		return rset != null;
	}
%>
</head>
<body>

</body>
</html>