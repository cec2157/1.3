<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<%
	Connection conn = null;
	String error_msg = "";
	OracleDataSource ods = new OracleDataSource();
	ods.setURL("jdbc:oracle:thin:pq2117/zhaozhong@//w4111b.cs.columbia.edu:1521/ADB");
	conn = ods.getConnection();
	String username = request.getParameter("username");
	String password = request.getParameter("password");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog</title>
</head>
<body>
	<%
		ResultSet rs = null;
		
		try {
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT username FROM bloguser");
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}
		
		boolean open = true;
		if (rs != null)
			while (rs.next())
				if (rs.getString("username").equals(username)) {
					open = false;
					break;
				}
		
		if (open) {
			try {
				Statement stmt = conn.createStatement();
				stmt.executeUpdate("INSERT INTO bloguser(username, password, type) VALUES(\'" + username
														+ "\', \'" + password + "\', \'USER\')");
				stmt.executeBatch();
			} catch (SQLException e) {
				error_msg = e.getMessage();
				if (conn != null) {
					conn.close();
				}
			}
			out.print("Registration successful!");
			out.print("<br />");
			out.print("<a href='login.html'" + ">" + "Log in" + "</a>");
			if (conn != null) {
				conn.close();
			}
		} else {
			out.print("Your username is taken!");
			out.print("<br />");
			out.print("<a href='register.html'" + ">" + "Go back to registration" + "</a>");
			if (conn != null) {
				conn.close();
			}
		}
	%>
</body>
</html>
