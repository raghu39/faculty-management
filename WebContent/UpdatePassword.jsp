<!-- This page updates the password changes to the database -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
String uname = request.getParameter("user");
%>
<h3>user<%=uname %></h3>
<%
String pwd = request.getParameter("pwd");
String pwd1 = request.getParameter("pwd1");
if(pwd.equals(pwd1))
{
	try
	{
		Statement statement = null;
	    ResultSet rs = null;
	    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
	    Connection connection = null; 
		Class.forName("com.mysql.jdbc.Driver").newInstance(); 
		connection = DriverManager.getConnection(connectionURL, "root", "root");
		statement = connection.createStatement();
		String query = "UPDATE accountant SET Password='"+pwd+"' WHERE Username='"+uname+"'";
		//PreparedStatement preparedStmt = connection.prepareStatement(query);
		statement.executeUpdate(query);
		if(uname.equals("admin"))
			response.sendRedirect("AdminHome.jsp");
		else
			response.sendRedirect("FacultyHomePage.jsp");
	}
	catch(Exception e)
	{
		System.out.println("Could not Update faculty details!!");
		e.printStackTrace();
	}
}
else
{
	response.sendRedirect("ChangePassword.jsp");
}

%>
