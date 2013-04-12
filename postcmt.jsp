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
	String username = (String) session.getAttribute("username");
	String text = request.getParameter("body");
	int bid = Integer.parseInt(request.getParameter("bid"));
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog</title>
</head>
<body>
	<%
		ResultSet rset = null;
		int newcid = 0;
		String[] months = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
		Calendar now = Calendar.getInstance();
		
		Statement stmt1 = conn.createStatement();
		rset = stmt1.executeQuery("SELECT MAX(cid) FROM comments");
		if (rset != null) {
			if (rset.next()) {
				newcid = rset.getInt("MAX(cid)") + 1;
			}
		}
		
		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH);
		int day = now.get(Calendar.DATE);
		String date = day + "-" + months[month] + "-" + year;
		
		text = text.replaceAll("\'", "\'\'");
		stmt1.executeUpdate("INSERT INTO comments(cid, cdate, text) VALUES(" + newcid + ", \'" + date + "\', \'" + text +"\')");
		stmt1.executeBatch();
	
		Statement stmt2 = conn.createStatement();
		stmt2.executeUpdate("INSERT INTO write_comment(cid, username) VALUES(" + newcid + ", \'" + username + "\')");
		stmt2.executeBatch();
		
		Statement stmt3 = conn.createStatement();
		stmt3.executeUpdate("INSERT INTO blog_comment(cid, bid) VALUES(" + newcid + ", " + bid + ")");
		stmt3.executeBatch();
		if (conn != null)
			conn.close();
		
		response.sendRedirect("blogpost.jsp?bid=" + bid);
	%>
</body>
</html>