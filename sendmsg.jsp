<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ page import="java.util.Calendar"%>

<%
	Connection conn = null;
	String error_msg = "";
	OracleDataSource ods = new OracleDataSource();
	ods.setURL("jdbc:oracle:thin:pq2117/zhaozhong@//w4111b.cs.columbia.edu:1521/ADB");
	conn = ods.getConnection();
	String from = (String) session.getAttribute("username");
	String to = request.getParameter("to");
	String subject = request.getParameter("subject");
	String text = request.getParameter("body");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog</title>
</head>
<body>
	<%
		ResultSet rset = null;
		
		try {
			Statement stmt = conn.createStatement();
			rset = stmt.executeQuery("SELECT username FROM bloguser");
		} catch (SQLException e) {
			error_msg = e.getMessage();
			if (conn != null) {
				conn.close();
			}
		}
		
		boolean exists = false;
		if (rset != null)
			while (rset.next())
				if (rset.getString("username").equals(to)) {
					exists = true;
					break;
				}
		
		if (exists) {
			ResultSet rset1 = null;
			int newmid = 0;
			Calendar now = Calendar.getInstance();
	
			Statement stmt1 = conn.createStatement();
			rset1 = stmt1.executeQuery("SELECT MAX(mid) FROM message");
			if (rset1 != null) {
				if (rset1.next()) {
					newmid = rset1.getInt("MAX(mid)") + 1;
				}
			}
	
			int year = now.get(Calendar.YEAR);
			int month = now.get(Calendar.MONTH) + 1;
			int day = now.get(Calendar.DATE);
			int hour = now.get(Calendar.HOUR);
			int min = now.get(Calendar.MINUTE);
			int sec = now.get(Calendar.SECOND);
			String date = "to_date('" + day + "-" + month + "-" + year + " " + hour + ":" + min + ":" + sec + "', ";
			date = date + "'DD-MM-YYYY HH24:MI:SS')"; 
			
			text = text.replaceAll("\'", "\'\'");
			subject = subject.replaceAll("\'", "\'\'");
	
			stmt1.executeUpdate("INSERT INTO message(mid, subject, mdate, text) VALUES(" +
								newmid + ", \'" + subject + "\', " + date + ", \'" + text +"\')");
			stmt1.executeBatch();
	
			Statement stmt2 = conn.createStatement();
			stmt2.executeUpdate("INSERT INTO write_msg(mid, sender_username, receiver_username) VALUES(" + newmid + ", \'" + 
			from + "\', \'" + to + "\')");
			stmt2.executeBatch();
			
			if (conn != null)
				conn.close();
			response.sendRedirect("message.jsp");
		} else {
			out.print("That user does not exist!");
			out.print("<br />");
			out.print("<a href='writemsg.html'" + ">" + "Go back to write message page" + "</a>");
			if (conn != null)
				conn.close();
		}
	%>
</body>
</html>
