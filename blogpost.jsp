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
	String bid = request.getParameter("bid");
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
		ResultSet rset3 = null;

		try {
			Statement stmt1 = conn.createStatement();
			rset1 = stmt1
					.executeQuery("SELECT * FROM blogpost WHERE bid = "
							+ bid);
			Statement stmt2 = conn.createStatement();
			rset2 = stmt2
					.executeQuery("SELECT * FROM blog_comment B, comments C, write_comment W "
							+ "WHERE B.cid = C.cid AND C.cid = W.cid AND B.bid = " + bid);
			Statement stmt3 = conn.createStatement();
			rset3 = stmt3
					.executeQuery("SELECT * FROM blog_has_tag H, tag T WHERE H.name = T.name AND H.bid = " + bid);
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}

		if (rset1 != null && rset2 != null && rset3 != null) {
			while (rset1.next()) {
				out.print("<h3>" + rset1.getString("title") + "</h3>");
				out.print("<p>" + rset1.getString("text") + "</p>");
			}
		%>
		<br />
		<h4>Tags:</h4>		
		<%
			while (rset3.next()) {
				String tagName = rset3.getString("name");
				out.print("<a href=\"tag.jsp?tag=" + tagName +"\">" + tagName + "</a>" + " ");
			}
		%>
		<br />
		<br />
		<h4>Comments</h4>
		<%  out.print("<table>");
			while (rset2.next()) {
				out.print("<tr>");
				out.print("<td>" + rset2.getString("cdate") + "</td>");
				out.print("<td>" + rset2.getString("username") + ":" + "</td>");
				out.print("<td>" + rset2.getString("text") + "</td>");
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
