<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>

<%
	String username = request.getParameter("username");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Homepage</title>
</head>
<body>
	<%
	out.print("<a href=\"photo.jsp?username=" + username + "\">" + "My Photos" + "</a>");
	out.print("<br />");
	out.print("<a href=\"message.jsp?username=" + username + "\">" + "My Messages" + "</a>");
	%>
</body>
</html>
