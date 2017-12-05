<!-- This page allows us to edit the user profile page -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
String uname = request.getParameter("user");
String name = request.getParameter("name");
String mail = request.getParameter("email");
String phone = request.getParameter("phone");
String oadd = request.getParameter("oadd");
String ohrs = request.getParameter("ohrs");
String chrs = request.getParameter("chrs");
String type = request.getParameter("type");
try
{
	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	statement = connection.createStatement();
	String query = "update faculty set FacultyName='"+name+"',maild_id='"+mail+"',phone='"+phone+"',OfficeAddress='"+oadd+"',OfficeHours='"+ohrs+"',CreditHours='"+chrs+"',Type='"+type+"' where username='"+uname+"'";
	statement.executeUpdate(query);
	session.setAttribute("username", name);
	response.sendRedirect("UserProfile.jsp");
}
catch(Exception e)
{
	System.out.println("Could not Update faculty details!!");
	e.printStackTrace();
}
%>
