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
	String user = (String) session.getAttribute("username");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Photo</title>
</head>
<body>
	<%
		ResultSet rset = null;

		try {
			Statement stmt = conn.createStatement();
			rset = stmt
					.executeQuery("SELECT * FROM manage_photo M, photo P WHERE M.pid = P.pid AND M.username =" + "'" + user + "'");
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}

		if (rset != null) {
			out.print("<table>");
			out.print("<th>" + "Photo Name" + "</th>");
			out.print("<th>" + "Date" + "</th>");
			out.print("<th>" + "Size(KB)" + "</th>");
			while (rset.next()) {
				out.print("<tr>");
				out.print("<th>" + "<a href=\"photodetail.jsp?pid=" + rset.getString("pid") + "\">" + rset.getString("ptitle") + "</a></th>");
				
				//out.print("<a href=\"photo.jsp?username=" + username + "\">" + "My Photos" + "</a>");
	
				out.print("<th>" + rset.getString("pdate") + "</th>");
				out.print("<th>" + rset.getString("psize") + "</th>");
				out.print("</tr>");
			}
			out.print("</table>");
		} else {
			out.print(error_msg);
		}
		if (conn != null) {
			conn.close();
		}
	%>
</body>
</html>