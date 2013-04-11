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
		ResultSet rset = null;

		try {
			Statement stmt = conn.createStatement();
			rset = stmt
					.executeQuery("SELECT * FROM bloguser WHERE username = "
							+ "'" + username + "'");
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}
		if (rset != null) {
			if (rset.next() != false) {
				if ((rset.getString("password")).equals(password)) {
					out.print("Welcome!");
					session.setAttribute("username", username);
					response.sendRedirect("index.jsp");
				}
				else {
					out.print("Your password is incorrect!");
					out.print("<br />");
					out.print("<a href='login.html'" + ">" + "go back to login" + "</a>");
				}
			} else {
				out.print("Your username does not exist!");
				out.print("<br />");
				out.print("<a href='login.html'" + ">" + "go back to login" + "</a>");
			}
		}
		if (conn != null) {
			conn.close();
		}
	%>
</body>
</html>
