<!-- This page gets the details from removefaculty.jsp and removes the faculty from the database-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%
System.out.println("deletefaculty");
String faculty = request.getParameter("faculty");
System.out.println("delete : "+faculty);
try 
{
	Statement st = null;
  	ResultSet rs = null;
  	String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
	Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	st = connection.createStatement();
    String query = "Delete from faculty where FacultyName='"+faculty+"'";
    st.execute(query);
    query = "Delete from timetable where FacultyId=(select FacultyId from faculty where FacultyName='"+faculty+"')";
    out.println("<script type=\"text/javascript\">");
	out.println("alert('Faculty Removed!! ');");
	 out.println("location='AdminHome.jsp';");
	 out.println("</script>");
}catch(Exception e)
{
	e.printStackTrace();
        	 out.println("location='RemoveFaculty.jsp';");
	System.out.println("Could not delete!");
}
%>
