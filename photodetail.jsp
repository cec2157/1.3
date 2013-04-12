<%@ page language="java" contentType="text/html; charset2=ISO-8859-1"
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
	String pid = request.getParameter("pid");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset2=ISO-8859-1">
	<title>Photo</title>
</head>
<body>
	<%
		ResultSet rset1 = null;
		ResultSet rset2 = null;

		try {
			Statement stmt1 = conn.createStatement();
			rset1 = stmt1
					.executeQuery("SELECT * FROM photo WHERE pid =" + pid);
			Statement stmt2 = conn.createStatement();
			rset2 = stmt2
					.executeQuery("SELECT * FROM photo P, photo_comment O, comments C, write_comment W " + 
								"WHERE P.pid = O.pid AND O.cid = W.cid AND O.cid = C.cid AND P.pid = " + pid);
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}

		if (rset1 != null && rset2 != null) {
			while (rset1.next()) {
				out.print("<img src=" + "\"" + rset1.getString("purl") + "\"" + ">");
			}
			%>
		<br />
		<br />
		<h4>Comments</h4>
			<%
			out.print("<table>");
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