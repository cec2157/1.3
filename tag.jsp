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
	String tag = request.getParameter("tag");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Blog</title>
</head>
<body>
	<h3><%= tag %></h3>
	<%
		ResultSet rset = null;

		try {
			Statement stmt = conn.createStatement();
			rset = stmt
					.executeQuery("SELECT * FROM blog_has_tag T, blogpost B WHERE T.bid = B.bid AND T.name = \'" + tag + "\'");
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}

		if (rset != null) {
			while (rset.next()) {
				out.print("<a href=\"blogpost.jsp?bid=" + rset.getString("bid") + "\">" + rset.getString("title") + "</a><br />");
			}
		} else {
			out.print(error_msg);
		}
		if (conn != null) {
			conn.close();
		}
	%>
</body>
</html>
