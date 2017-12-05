<!--This page contains the logic of displaying the details of faculties based on course selected  -->
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Arrays" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Faculty Course</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="shortcut icon" href="favicon.png" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
  </head>
<body>
  <div id="main">
 <div class="dropdown" style="float:right;">
  <button class="user dropbtn"></button>
  <div class="dropdown-content">
    <a href="UserProfile.jsp">Profile</a>
    <a href="ChangePassword.jsp">Change Password</a>
    <a href="LoginPage.html">Logout</a>
  </div>
</div><% String user=request.getParameter("user");
	session.setAttribute("username",user);%>
 <h3> Hi <%=user %> !</h3>
 <div>
 <%
 	String course = request.getParameter("course");
 %>
 </div>
 
    <div id="site_content">
    <ul class="tab">
  <li><a href="#" class="tablinks">Calendar</a></li>
  <li><a href=<%= "\"FacultyHomePage.jsp?user=" + user + "\"" %> class="tablinks">Home</a></li>
</ul>
    <div>
    <select>
    <option>-Faculties who teach this subject-</option>
    <%
 try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	String QueryString = "Select FacultyName from faculty where SubjectTaught='"+course+"'";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
  		%>
  		<option><%=rs.getString(1) %></option>
  		<%
  	}
  }
    catch(Exception e)
    {
    	e.printStackTrace();
    }
    %>
    </select>
    <h2>&nbsp;&nbsp;&nbsp;&nbsp;<b>Timetable for course : <%=course %></b></h2></div>
   &nbsp;&nbsp;&nbsp;&nbsp;
   
  <%
  String[][] timetable={{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""}}; 
  //new String[11][5];
  
  try
  {
  	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
  	connection = DriverManager.getConnection(connectionURL, "root", "root");
  	Statement st = connection.createStatement();
  	//Subject:facultyname:room:time
  	String QueryString = "Select t.Course,f.FacultyName,t.RoomNumber,t.TimeDuration,t.Day from timetable t, faculty f where t.FacultyId=f.FacultyId and t.Course='"+course+"'";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	if(rs!=null)
  	{
  		while(rs.next())
  	  	{
//	  		if(rs.getString(5).equals("Monday"))
//	  		{
//	  			if(rs.getString(4).equals("8-9"))
//	  				timetable[0][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("9-10"))
//	  				timetable[1][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("10-11"))
//	  				timetable[2][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("11-12"))
//	  				timetable[3][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("12-1"))
//	  				timetable[4][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("1-2"))
//	  				timetable[5][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("2-3"))
//	  				timetable[6][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("3-4"))
//	  				timetable[7][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("4-5"))
//	  				timetable[8][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
//	  			else if(rs.getString(4).equals("5-6"))
//	  				timetable[9][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("6-7"))
//	  				timetable[10][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  		}
//	  		else if(rs.getString(5).equals("Tuesday"))
//	  		{
//	  			if(rs.getString(4).equals("8-9"))
//	  				timetable[0][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("9-10"))
//	  				timetable[1][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("10-11"))
//	  				timetable[2][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("11-12"))
//	  				timetable[3][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("12-1"))
//	  				timetable[4][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("1-2"))
//	  				timetable[5][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("2-3"))
//	  				timetable[6][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("3-4"))
//	  				timetable[7][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("4-5"))
//	  				timetable[8][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
//	  			else if(rs.getString(4).equals("5-6"))
//	  				timetable[9][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("6-7"))
//	  				timetable[10][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  		}
//	  		else if(rs.getString(5).equals("Wednesday"))
//	  		{
//	  			if(rs.getString(4).equals("8-9"))
//	  				timetable[0][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("9-10"))
//	  				timetable[1][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("10-11"))
//	  				timetable[2][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("11-12"))
//	  				timetable[3][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("12-1"))
//	  				timetable[4][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("1-2"))
//	  				timetable[5][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("2-3"))
//	  				timetable[6][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("3-4"))
//	  				timetable[7][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("4-5"))
//	  				timetable[8][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
//	  			else if(rs.getString(4).equals("5-6"))
//	  				timetable[9][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("6-7"))
//	  				timetable[10][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  		}
//	  		else if(rs.getString(5).equals("Thursday"))
//	  		{
//	  			if(rs.getString(4).equals("8-9"))
//	  				timetable[0][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("9-10"))
//	  				timetable[1][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("10-11"))
//	  				timetable[2][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("11-12"))
//	  				timetable[3][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("12-1"))
//	  				timetable[4][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("1-2"))
//	  				timetable[5][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("2-3"))
//	  				timetable[6][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("3-4"))
//	  				timetable[7][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("4-5"))
//	  				timetable[8][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
//	  			else if(rs.getString(4).equals("5-6"))
//	  				timetable[9][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("6-7"))
//	  				timetable[10][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  		}
//	  		else if(rs.getString(5).equals("Friday"))
//	  		{
//	  			if(rs.getString(4).equals("8-9"))
//	  				timetable[0][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("9-10"))
//	  				timetable[1][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("10-11"))
//	  				timetable[2][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("11-12"))
//	  				timetable[3][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("12-1"))
//	  				timetable[4][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("1-2"))
//	  				timetable[5][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("2-3"))
//	  				timetable[6][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("3-4"))
//	  				timetable[7][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("4-5"))
//	  				timetable[8][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
//	  			else if(rs.getString(4).equals("5-6"))
//	  				timetable[9][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  			else if(rs.getString(4).equals("6-7"))
//	  				timetable[10][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
//	  		}
                    if(rs.getString(5).equals("Monday"))
	  		{
                                if(rs.getString(4).equals("8-9") || rs.getString(4).equals("8-8.50"))
	  			timetable[0][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10") || rs.getString(4).equals("9-9.50") )
	  				timetable[1][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11")|| rs.getString(4).equals("10-10.50") )
	  				timetable[2][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11-11.50") || rs.getString(4).equals("12.30-13.45"))
	  				timetable[3][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12-12.50") || rs.getString(4).equals("14-15.15"))
	  				timetable[4][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14-14.50") || rs.getString(4).equals("15.30-16.45"))
	  				timetable[6][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15-15.50") || rs.getString(4).equals("17-18.15"))
	  				timetable[7][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5")|| rs.getString(4).equals("16-16.50"))
	  				timetable[8][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17-17.50"))
	  				timetable[9][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("6-7")|| rs.getString(4).equals("18-18.50"))
	  				timetable[10][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  		}
	  		else if(rs.getString(5).equals("Tuesday"))
	  		{
	  			if(rs.getString(4).equals("8-9")||rs.getString(4).equals("8-9.15"))
	  				timetable[0][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10")|| rs.getString(4).equals("9.30-10.45"))
	  				timetable[1][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11"))
	  				timetable[2][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11-12.15"))
	  				timetable[3][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12.30-13.45"))
	  				timetable[4][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14-15.15"))
	  				timetable[6][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15.30-16.45"))
	  				timetable[7][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5"))
	  				timetable[8][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17-18.15"))
	  				timetable[9][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("6-7"))
	  				timetable[10][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  		}
	  		else if(rs.getString(5).equals("Wednesday"))
	  		{
	  			if(rs.getString(4).equals("8-9") || rs.getString(4).equals("8-8.50"))
	  			timetable[0][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10") || rs.getString(4).equals("9-9.50") )
	  				timetable[1][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11")|| rs.getString(4).equals("10-10.50") )
	  				timetable[2][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11-11.50") || rs.getString(4).equals("12.30-13.45"))
	  				timetable[3][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12-12.50") || rs.getString(4).equals("14-15.15"))
	  				timetable[4][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14-14.50") || rs.getString(4).equals("15.30-16.45"))
	  				timetable[6][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15-15.50") || rs.getString(4).equals("17-18.15"))
	  				timetable[7][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5")|| rs.getString(4).equals("16-16.50"))
	  				timetable[8][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17-17.50"))
	  				timetable[9][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("6-7")|| rs.getString(4).equals("18-18.50"))
	  				timetable[10][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";  
	  		}
	  		else if(rs.getString(5).equals("Thursday"))
	  		{
	  			if(rs.getString(4).equals("8-9")||rs.getString(4).equals("8-9.15"))
	  				timetable[0][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10")|| rs.getString(4).equals("9.30-10.45"))
	  				timetable[1][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11"))
	  				timetable[2][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11-12.15"))
	  				timetable[3][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12.30-13.45"))
	  				timetable[4][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14-15.15"))
	  				timetable[6][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15.30-16.45"))
	  				timetable[7][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5"))
	  				timetable[8][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17-18.15"))
	  				timetable[9][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("6-7"))
	  				timetable[10][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  		}
	  		else if(rs.getString(5).equals("Friday"))
	  		{
	  			if(rs.getString(4).equals("8-9") || rs.getString(4).equals("8-8.50"))
	  			timetable[0][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10") || rs.getString(4).equals("9-9.50") )
	  				timetable[1][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11")|| rs.getString(4).equals("10-10.50") )
	  				timetable[2][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11-11.50") || rs.getString(4).equals("12.30-13.45"))
	  				timetable[3][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12-12.50") || rs.getString(4).equals("14-15.15"))
	  				timetable[4][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14-14.50") || rs.getString(4).equals("15.30-16.45"))
	  				timetable[6][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15-15.50") || rs.getString(4).equals("17-18.15"))
	  				timetable[7][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5")|| rs.getString(4).equals("16-16.50"))
	  				timetable[8][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17-17.50"))
	  				timetable[9][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("6-7")|| rs.getString(4).equals("18-18.50"))
	  				timetable[10][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";  
	  		}
  	  	}
	  		%>
	  		<table class="table1">
	  	   <thead>
	  	        <tr>
	  	            <th></th>
	  	            <th scope="col" abbr="Monday" >Monday</th>
	  	            <th scope="col" abbr="Tuesday" >Tuesday</th>
	  	            <th scope="col" abbr="Wednesday" >Wednesday</th>
	  	            <th scope="col" abbr="Thursday" >Thursday</th>
	  	            <th scope="col" abbr="Friday" >Friday</th>
	  	        </tr>
	  	    </thead>
	  		<tfoot>
	        <tr>
	            <th scope="row"></th>
	            <td></td>
	            <td></td>
	            <td></td>
	            <td></td>
	        </tr>
	    </tfoot>
	    <tbody>
	        <tr>
	            <th scope="row">8 am to 9 am</th>
	            <td>
	            <%	
		            String[] data = timetable[0][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
	            <%	
		            data = timetable[0][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
	            <td>
	            <%	
		            data = timetable[0][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
	            <td>
	            <%	
		            data = timetable[0][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
	            <td>
	           	<%	
		            data = timetable[0][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
		        </td>
	        </tr>
	        <tr>
	            <th scope="row">9 am to 10 am</th>
	            <td>
				<%	
		            data = timetable[1][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[1][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[1][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[1][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[1][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	        </tr>
	        <tr>
	            <th scope="row">10 am to 11 am</th>
	            <td>
				<%	
		            data = timetable[2][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[2][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	           	<td>
				<%	
		            data = timetable[2][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[2][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[2][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	        </tr>
	        <tr>
	            <th scope="row">11 am to 12 pm</th>
	            <td>
				<%	
		            data = timetable[3][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[3][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[3][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[3][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	            <td>
				<%	
		            data = timetable[3][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	        </tr>
	        <tr>
	            <th scope="row">12 pm to 1 pm</th>
	            <td>
				<%	
		            data = timetable[4][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[4][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[4][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[4][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[4][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
	        </tr>
	        <tr>
	            <th scope="row">1 pm to 2 pm</th>
	            <td>
				<%	
		            data = timetable[5][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[5][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[5][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[5][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[5][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				</tr>
	        <tr>
	            <th scope="row">2 pm to 3 pm</th>
	            <td>
				<%	
		            data = timetable[6][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[6][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[6][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[6][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[6][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				</tr>
	         <tr>
	            <th scope="row">3 pm to 4 pm</th>
	            <td>
				<%	
		            data = timetable[7][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[7][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[7][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[7][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[7][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				</tr>
	        <tr>
	            <th scope="row">4 pm to 5 pm</th>
	           <td>
				<%	
		            data = timetable[8][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[8][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[8][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[8][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[8][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				</tr>
	        <tr>
	            <th scope="row">5 pm to 6 pm</th>
	           	<td>
				<%	
		            data = timetable[9][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[9][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[9][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[9][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[9][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				 </tr>
	        <tr>
	            <th scope="row">6 pm to 7 pm</th>
	            <td>
				<%	
		            data = timetable[10][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[10][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[10][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[10][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %>
				</td>
				<td>
				<%	
		            data = timetable[10][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		           <%
		           }
		            }
		        %>
				</td>
				 </tr>
	    </tbody>
	</table>
  	  <%	
  	}
  	else
  	{
  		%>
  		<h3>This subject is not scheduled!!</h3>
  		<%
  	}
  }catch(Exception e)
  	{
  		e.printStackTrace();
  	}
  for(int i=0;i<11;i++)
  {  for(int j=0;j<5;j++)
	  {
		System.out.println(timetable[i][j]+"\t");	  
	  }
  out.println("\n");
  }
  %>
 
    
</div>
</div>
    
  <!-- javascript at the bottom for fast page loading -->
  <script type="text/javascript" src="js/jquery.min.js"></script>
  <script type="text/javascript" src="js/jquery.easing.min.js"></script>
  <script type="text/javascript" src="js/jquery.lavalamp.min.js"></script>
  <script type="text/javascript" src="js/image_fade.js"></script>
  <script type="text/javascript">
    $(function() {
      $("#lava_menu").lavaLamp({
        fx: "backout",
        speed: 700
      });
    });
  </script>
</body>
</html>
