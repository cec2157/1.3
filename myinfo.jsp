<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<%
	String username = (String) session.getAttribute("username");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Info</title>
</head>
<body>
	<p align="center">
	<%
	out.print("<a href=\"photo.jsp\">" + "My Photos" + "</a>");
	out.print("<br />");
	out.print("<br />");
	out.print("<a href=\"message.jsp\">" + "My Messages" + "</a>");
	%>
	</p>
</body>
</html>
