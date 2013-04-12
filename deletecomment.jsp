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
	String cid = request.getParameter("cid");
	//String bid = request.getParameter("bid");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
		Statement stmt = conn.createStatement();
		stmt.executeUpdate("DELETE FROM comments WHERE cid=" + "'" + cid + "'");
		stmt.executeBatch();
		response.sendRedirect("index.jsp");
		
	%>
</body>
</html>
