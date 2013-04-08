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
	int bid = Integer.parseInt(request.getParameter("bid"));
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Blog</title>
</head>
<body>
	<%
		ResultSet rset1 = null;
		ResultSet rset2 = null;

		try {
			Statement stmt1 = conn.createStatement();
			rset1 = stmt1
					.executeQuery("SELECT text FROM blogpost WHERE bid = "
							+ bid);
			Statement stmt2 = conn.createStatement();
			rset2 = stmt2
					.executeQuery("SELECT * FROM blog_comment B, comments C, write_comment W "
							+ "WHERE B.cid = C.cid AND C.cid = W.cid AND B.bid = " + bid);
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}

		if (rset1 != null && rset2 != null) {
			while (rset1.next()) {
				out.print("<p>" + rset1.getString("text") + "</p>");
			}
		%>
		<h4>Comments</h4>
		<%
			while (rset2.next()) {
				out.print("<p>" + rset2.getString("username") + ": " + rset2.getString("text") + "</p>");
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