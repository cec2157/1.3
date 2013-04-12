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
	String title = request.getParameter("title");
	String text = request.getParameter("body");
	String tags = request.getParameter("tags");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog</title>
</head>
<body>
	<%
		if (session.getAttribute("type").equals("ADMIN")) {
			ResultSet rset = null;
			int newbid = 0;
			Calendar now = Calendar.getInstance();

			Statement stmt1 = conn.createStatement();
			rset = stmt1.executeQuery("SELECT MAX(bid) FROM blogpost");
			if (rset != null) {
				if (rset.next()) {
					newbid = rset.getInt("MAX(bid)") + 1;
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
			title = title.replaceAll("\'", "\'\'");
			stmt1.executeUpdate("INSERT INTO blogpost(bid, title, bdate, text) VALUES(" +
								newbid + ", \'" + title + "\', " + date + ", \'" + text +"\')");
			stmt1.executeBatch();

			Statement stmt2 = conn.createStatement();
			StringTokenizer strtok = new StringTokenizer(tags, ",");
			while (strtok.hasMoreElements())
				stmt2.executeUpdate("INSERT INTO blog_has_tag(name, bid) VALUES(\'" + strtok.nextElement() + "\', " + newbid + ")");
			stmt2.executeBatch();
			response.sendRedirect("index.jsp");
		}
	%>
</body>
</html>
