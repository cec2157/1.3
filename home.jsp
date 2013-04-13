<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Blog</title>
</head>
<body>

	<% 
		if (session.getAttribute("username") == null) {
			out.print("<div align=\"right\">");
			out.print("<a href=\"login.html\">Log in</a><br />");
			out.print("<a href=\"register.html\">Register</a></div>");
		} else {
			out.print("<div align=\"right\">");
			out.print("<a href=\"message.jsp\">My messages</a><br />");
			if (session.getAttribute("type").equals("ADMIN")) {
				out.print("<a href=\"writeblog.html\">Write blogpost</a><br />");
				out.print("<a href=\"newphoto.html\">Post photo</a><br />");
			}
			out.print("<a href=\"logout.jsp\">Log out</a></div>");
		}
	%>
	
	<center><h1>Welcome to my blog</h1></center>
	<center><h3><a href="index.jsp">My Blog</a></h3></center>
	<center><h3><a href="photo.jsp">My Photos</a></h3></center>
</body>
</html>