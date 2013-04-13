<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="oracle.jdbc.pool.OracleDataSource"%>
<%@ page import="java.util.Calendar"%>

<%
	Connection conn = null;
	String error_msg = "";
	OracleDataSource ods = new OracleDataSource();
	ods.setURL("jdbc:oracle:thin:pq2117/zhaozhong@//w4111b.cs.columbia.edu:1521/ADB");
	conn = ods.getConnection();
	String title = request.getParameter("title");
	String url = request.getParameter("url");
	String username = (String) session.getAttribute("username");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog</title>
</head>
<body>
	<%
		if (!url.endsWith(".jpg")) {
			out.print("Unsuported file type!");
			out.print("<br />");
			out.print("<a href='newphoto.html'" + ">" + "Go back to new photo page" + "</a>");
			if (conn != null)
				conn.close();
		} else {
		if (session.getAttribute("type").equals("ADMIN")) {
			ResultSet rset = null;
			int newpid = 0;
			Calendar now = Calendar.getInstance();
			
			Statement stmt1 = conn.createStatement();
			rset = stmt1.executeQuery("SELECT MAX(pid) FROM photo");
			if (rset != null) {
				if (rset.next()) {
					newpid = rset.getInt("MAX(pid)") + 1;
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

			url = url.replaceAll("\'", "\'\'");
			title = title.replaceAll("\'", "\'\'");
			Statement stmt2 = conn.createStatement();
			stmt2.executeUpdate("INSERT INTO photo(pid, ptitle, pdate, psize, purl) VALUES(" +
								newpid + ", \'" + title + "\', " + date + ", 1, \'" + url +"\')");
			stmt2.executeBatch();
			
			Statement stmt3 = conn.createStatement();
			stmt3.executeUpdate("INSERT INTO manage_photo(pid, username) VALUES(" +
					newpid + ", \'" + username + "\')");
			stmt3.executeBatch();
			
			if (conn != null)
				conn.close();
			response.sendRedirect("photo.jsp");
		}
		}
	%>
</body>
</html>
