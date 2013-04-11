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
	String username = (String) session.getAttribute("username");
%>

<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Message</title>
</head>
<body>
	<%
		ResultSet rset = null;

		try {
			Statement stmt = conn.createStatement();
			rset = stmt
					.executeQuery("SELECT * FROM message M, write_msg W WHERE " + 
								  "M.mid = W.mid AND sender_username = " + "'"+ username + 
								  "'" + "UNION SELECT * FROM message M2, write_msg W2 WHERE " + 
								  "M2.mid = W2.mid AND receiver_username = " + "'" + username + "'");
		
			
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}

		if (rset != null) {
			out.print("<table>");
			out.print("<th>" + "Sender" + "</th>");
			out.print("<th>" + "Receiver" + "</th>");
			out.print("<th>" + "Subject" + "</th>");
			out.print("<th>" + "Date" + "</th>");
			out.print("<th>" + "Message" + "</th>");
			while (rset.next()) {
				out.print("<tr>");
				out.print("<td>" + rset.getString("sender_username") + "</td>");
				out.print("<td>" + rset.getString("receiver_username") + "</td>");
				out.print("<td>" + rset.getString("subject") + "</td>");
				out.print("<td>" + rset.getString("mdate") + "</td>");
				out.print("<td>" + rset.getString("text") + "</td>");
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
