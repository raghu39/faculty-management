<!-- This page validates the username and password entered in the loginpage.html page-->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %> 
<%
//out.println("hello");

String username = request.getParameter("uname");
String password = request.getParameter("pwd");
//out.println("username:"+username);
//out.println("password:"+password);
try 
{
    /* database connectivity*/
	Statement statement = null;
  	ResultSet rs = null;
  	String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
	Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	Statement st = connection.createStatement();
	String QueryString = "Select Role from accountant where Username='"+username+"' and Password='"+password+"'";
	
        rs = st.executeQuery(QueryString);
	if(rs.next())
	{
		session.setAttribute("username", username);
		if(rs.getString(1).equals("admin"))
		{
			response.sendRedirect("AdminHome.jsp");
		}
		else if(rs.getString(1).equals("faculty"))
		{
			response.sendRedirect("FacultyHomePage.jsp");
		}
	}
	else
	{
            
            out.println("<script type=\"text/javascript\">");
            //out.println("<h3>Sorry, you are INVALID</h3>"); 
	    out.println("alert('Wrong Username or Password! please Enter Correct Credentials');");
	    out.println("location='LoginPage.html';");
            out.println("alert('Wrong Username or Password!');");
	    out.println("</script>");
	}
}
catch(Exception ex){
out.println("Unable to connect to database.");
}
%>
