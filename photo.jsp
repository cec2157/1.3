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
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Photo</title>
</head>
<body>
	<%
		out.print("<div align=\"right\">");
		out.print("<a href=\"home.jsp\">Home</a></div>");
		ResultSet rset = null;

		try {
			Statement stmt = conn.createStatement();
			rset = stmt
					.executeQuery("SELECT * FROM manage_photo M, photo P WHERE M.pid = P.pid");
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}

		if (rset != null) {
			out.print("<table align='center'>");
			out.print("<th>" + "Photo Name" + "</th>");
			out.print("<th>" + "Date" + "</th>");
			while (rset.next()) {
				int pid = rset.getInt("pid");
				out.print("<tr>");
				out.print("<th>" + "<a href=\"photodetail.jsp?pid=" + pid + "\">" + rset.getString("ptitle") + "</a></th>");
				out.print("<th>" + rset.getString("pdate") + "</th>");
				if (session.getAttribute("type") == null || session.getAttribute("type").equals("USER"))
					out.print("</tr>");
				else
					out.print(" " + "<th><a href=\"deletephoto.jsp?pid=" + pid + "\">" + "delete" + "</a></th></tr>");
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
