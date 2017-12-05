<!-- This contains logic to display the table grid in calendar format based on the number of days entered -->
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Home</title>
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
</div>
<%
    // session for logined user
	String user = session.getAttribute("username").toString();
 session.setAttribute("username",user);
 %>
 <h3> Hi <%=session.getAttribute("username").toString() %> !</h3>
    <div id="site_content">
     <ul class="tab">
  <li><a href="#" class="tablinks">Schedule</a></li>
  <li><a href=<%= "\"AdminHome.jsp?user=" + user + "\"" %> class="tablinks">Home</a></li>
</ul>

<div id="home" class="tabcontent" style="display:block">
<h3>Schedule</h3>
<form name=schedule action="Scheduler7.jsp" method=POST>
 <input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
<%
// getting data from scheduler pages	
    String campus = request.getParameter("campus");
	String dept = request.getParameter("dept");
	String course = request.getParameter("course");
	String faculty = request.getParameter("faculty");
	int noOfdays = Integer.parseInt(request.getParameter("noOfdays"));
%>
<h3>Campus : <label> <%=campus %></label><input type=hidden name=campus value='<%=campus %>'></h3>
<h3>Department : <label> <%=dept %></label><input type=hidden name=dept value='<%=dept %>'></h3>
<h3>Course : <label> <%=course %></label><input type=hidden name=course value='<%=course %>'></h3>
<h3>Faculty : <label> <%=faculty %></label><input type=hidden name=faculty value='<%=faculty %>'></h3>
<h3>Number of Days :  <label> <%=noOfdays %></label><input type=hidden name=noOfdays value='<%=noOfdays %>' ></h3>
<%
int chrs = 0;
 try
 {
 	// by entering number of days calendar will be displayed to shcedule timetable for faculty
     // connecting to database and selecting credithours from database
     Statement statement = null;
   ResultSet rs = null;
   String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
   Connection connection = null; 
 	Class.forName(	"com.mysql.jdbc.Driver").newInstance(); 
 	connection = DriverManager.getConnection(connectionURL, "root", "root");
 	Statement st = connection.createStatement();
 	String QueryString = "Select CreditHours from faculty where FacultyName='"+faculty+"'";
 	rs = st.executeQuery(QueryString);
 	if(rs.next())
 	{
 		chrs = Integer.parseInt(rs.getString(1));
}
 	connection.close();
 	}
 catch(Exception e){}
 //int hrsToteach = 0;
 //hrsToteach=(chrs)/noOfdays;
 // creating a 2-dimmensional array for storing timetable data 
  String[][] timetable={{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""},{"","","","",""}}; 

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
  	String QueryString1 = "Select t.Course,f.FacultyName,t.RoomNumber,t.TimeDuration,t.Day from faculty f,timetable t where f.FacultyId=t.FacultyId and f.FacultyName='"+faculty+"'";
  	rs = st.executeQuery(QueryString1);
  	//out.println("queried successfully!")
  	if(rs!=null)
  	{
            // loop for storing timetable by clicking on the slots
  		while(rs.next())
  	  	{
  			 if(rs.getString(5).equals("Monday"))
	  		{
                                if(rs.getString(4).equals("8-9") || rs.getString(4).equals("8-8.50"))
                                        timetable[0][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10") || rs.getString(4).equals("9-9.50") )
	  				timetable[1][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11")|| rs.getString(4).equals("10-10.50") )
	  				timetable[2][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11-11.50") || rs.getString(4).equals("12:30-13.45"))
	  				timetable[3][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12-12.50") || rs.getString(4).equals("14:00-15.15"))
	  				timetable[4][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14-14.50") || rs.getString(4).equals("15:30-16.45"))
	  				timetable[6][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15-15.50") || rs.getString(4).equals("17:00-18.15"))
	  				timetable[7][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5")|| rs.getString(4).equals("16-16.50"))
	  				timetable[8][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17-17.50"))
	  				timetable[9][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("6-7")|| rs.getString(4).equals("18-18.50"))
	  				timetable[10][0]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  		}
	  		else if(rs.getString(5).equals("Tueday"))
	  		{
	  			if(rs.getString(4).equals("8-9")||rs.getString(4).equals("8-9.15"))
	  				timetable[0][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10")|| rs.getString(4).equals("9:30-10.45"))
	  				timetable[1][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11"))
	  				timetable[2][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11:00-12:15"))
	  				timetable[3][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12:30-13:45"))
	  				timetable[4][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14:00-15:15"))
	  				timetable[6][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15:30-16:45"))
	  				timetable[7][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5"))
	  				timetable[8][1]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17:00-18:15"))
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
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11-11.50") || rs.getString(4).equals("12:30-13.45"))
	  				timetable[3][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12-12.50") || rs.getString(4).equals("14:00-15.15"))
	  				timetable[4][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14-14.50") || rs.getString(4).equals("15:30-16.45"))
	  				timetable[6][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15-15.50") || rs.getString(4).equals("17:00-18.15"))
	  				timetable[7][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5")|| rs.getString(4).equals("16-16.50"))
	  				timetable[8][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17-17.50"))
	  				timetable[9][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("6-7")|| rs.getString(4).equals("18-18.50"))
	  				timetable[10][2]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";  
	  		}
	  		else if(rs.getString(5).equals("Thrusday"))
	  		{
	  			if(rs.getString(4).equals("8-9")||rs.getString(4).equals("8-9.15"))
	  				timetable[0][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("9-10")|| rs.getString(4).equals("9:30-10.45"))
	  				timetable[1][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("10-11"))
	  				timetable[2][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11:00-12:15"))
	  				timetable[3][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12:30-13:45"))
	  				timetable[4][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14:00-15:15"))
	  				timetable[6][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15:30-16:45"))
	  				timetable[7][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5"))
	  				timetable[8][3]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17:00-18:15"))
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
	  			else if(rs.getString(4).equals("11-12")|| rs.getString(4).equals("11-11.50") || rs.getString(4).equals("12:30-13.45"))
	  				timetable[3][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("12-1")|| rs.getString(4).equals("12-12.50") || rs.getString(4).equals("14:00-15.15"))
	  				timetable[4][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("1-2"))
	  				timetable[5][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("2-3")|| rs.getString(4).equals("14-14.50") || rs.getString(4).equals("15:30-16.45"))
	  				timetable[6][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("3-4")|| rs.getString(4).equals("15-15.50") || rs.getString(4).equals("17:00-18.15"))
	  				timetable[7][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("4-5")|| rs.getString(4).equals("16-16.50"))
	  				timetable[8][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";
	  			else if(rs.getString(4).equals("5-6")|| rs.getString(4).equals("17-17.50"))
	  				timetable[9][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";"; 
	  			else if(rs.getString(4).equals("6-7")|| rs.getString(4).equals("18-18.50"))
	  				timetable[10][4]+=rs.getString(1)+"<br>"+"Prof. "+rs.getString(2)+"<br>"+"ClassRoom#: "+rs.getString(3)+";";  
	  		}
  	  	}//while
%>
<table class="table1">
 <thead>
      <tr>
          <th></th>
          <th scope="col" abbr="Monday">Monday</th>
          <th scope="col" abbr="Tuesday">Tuesday</th>
          <th scope="col" abbr="Wednesday">Wednesday</th>
          <th scope="col" abbr="Thursday">Thursday</th>
          <th scope="col" abbr="Friday">Friday</th>
      </tr>
  </thead>
  <%
      // if user enters number of days as 3, dividing time slots into 50 min classes
  if(noOfdays==3)
  {
  %>
  <tbody>
      <tr>
          <th scope="row">08:00-08:50</th>
          <td>
	            <%	
                        // timetable is 2d array with day and time??
		            String[] data = timetable[0][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            boolean fac = false;
                            if(timetable[0][0].contains(faculty) || timetable[0][1].contains(faculty) || timetable[0][2].contains(faculty) || timetable[0][3].contains(faculty) || timetable[0][4].contains(faculty))
                                fac = true;
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                                ////if(data[i].contains(faculty))
                                  //  fac = true;
                                %>
                         
                            </span>
		            <%
		            	}
		            }
		        %>
				<div id="8-8.50" >
                                    <%
                                        if(!fac)
                                    {
                                    %>
				<input type=checkbox class="checkbox" name="8-8.50" value="8-8.50:M">
                                <%
                                }
                                %>
                                </div></td>
		 			            <td>
	            <%	
		            data = timetable[0][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);          
                              %></span>
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
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                               // //if(data[i].contains(faculty))
                                 //   fac = true;
                                %></span>
		            <%
		            	}
		            }
		        %><div id="8-8.50" >
                            <%
                            if(!fac)
                            {
                            %><input type=checkbox class="checkbox" name="8-8.50" value="8-8.50:W">
                        <%
                        }
                        %></div></td>
		 			            <td>
	            <%	
		            data = timetable[0][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td>
	            <%	
		            data = timetable[0][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                               // //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="8-8.50" >
                            <%if(!fac){%><input type=checkbox class="checkbox" name="8-8.50" value="8-8.50:F"><%}%></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">09:00-09:50 </th>
		 						<td>
	            <%	
		            data = timetable[1][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             fac = false;
                            if(timetable[1][0].contains(faculty) || timetable[1][1].contains(faculty) || timetable[1][2].contains(faculty) || timetable[1][3].contains(faculty) || timetable[1][4].contains(faculty))
                                fac = true;
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                                //if(data[i].contains(faculty))
                                //    fac = true;
           %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-9.50" >
                            <%
                            if(!fac){%><input type=checkbox name="9-9.50" value="9-9.50:M" ><%}%></div></td>
		 			            <td><%	
		            data = timetable[1][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
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
		 			            <td><%	
		            data = timetable[1][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                              //  //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-9.50" >
                            <%if(!fac){%><input type=checkbox name="9-9.50" value="9-9.50:W" ><%}%></div></td>
		 			            <td><%	
		            data = timetable[1][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
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
		 			            <td><%	
		            data = timetable[1][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                  if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                               // //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9-9.50" >
                            <%if(!fac){%><input type=checkbox name="9-9.50" value="9-9.50:F" ><%}%></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">10:00-10:50 </th>
		 			            <td><%	
		            data = timetable[2][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                              fac = false;
                                if(timetable[2][0].contains(faculty) || timetable[2][1].contains(faculty) || timetable[2][2].contains(faculty) || timetable[2][3].contains(faculty) || timetable[2][4].contains(faculty))
                                fac = true;                            
//  
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                             //   //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %>
		        <div id="10-10.50" >
                            <%if(!fac){%> <input type =checkbox name="10-10.50" value="10-10.50:M" ><%}%>  </div></td>
		 			            <td><%	
		            data = timetable[2][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
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
		 			            <td><%	
		            data = timetable[2][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                               // //if(data[i].contains(faculty))	
       // fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="10-10.50" >
                            <%if(!fac){%>  <input type=checkbox name="10-10.50" value="10-10.50:W" ><%}%> </div></td>
		 			            <td><%	
		            data = timetable[2][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
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
		 			            <td><%	
		            data = timetable[2][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                               // //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="10-10.50" >
                            <%if(!fac){%>     <input type=checkbox name="10-10.50" value="10-10.50:F" >
<%}%> 
</div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">11:00-11:50</th>
		 			            <td><%	
		            data = timetable[3][0].split(";");
	            	%>
	            		
                        <span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                              fac = false;
		            if(timetable[3][0].contains(faculty) || timetable[3][1].contains(faculty) || timetable[3][2].contains(faculty) || timetable[3][3].contains(faculty) || timetable[3][4].contains(faculty))
                                fac = true;
                            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                             //   //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="11-11.50" ><%if(!fac){%>  <input type=checkbox name="11-11.50" value="11-11.50:M" >   
<%}%>  </div></td>
		 			            <td><%	
		            data = timetable[3][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
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
		 			            <td><%	
		            data = timetable[3][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                              //  //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="11-11.50" >
                            <%if(!fac){%>     <input type=checkbox name="11-11.50" value="11-11.50:W" ><%}%> </div></td>
		 			            <td><%	
		            data = timetable[3][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
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
		 			            <td><%	
		            data = timetable[3][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                              //  //if(data[i].contains(faculty))	fac = true; %></span>
		            <%
		            	}
		            }
		        %><div id="11-11.50" >
                            <%if(!fac){%> 
                            <input type=checkbox name="11-11.50" value="11-11.50:F" >    
<%}%>   </div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">13:00-13:50 </th>
		 			            <td><%	
		            data = timetable[4][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            fac = false; 
                           if(timetable[4][0].contains(faculty) || timetable[4][1].contains(faculty) || timetable[4][2].contains(faculty) || timetable[4][3].contains(faculty) || timetable[4][4].contains(faculty))
                                fac = true;
		            if(data.length>=1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                             //   //if(data[i].contains(faculty))	fac = true;
                                %></span>
		            <%
		            	}
		            }
		        %><div id="12-12.50" >
                            <%if(!fac){%> <input type=checkbox name="12-12.50" value="12-12.50:M"><%}%> </div></td>
		 			            <td><%	
		            data = timetable[4][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
		            if(data.length>=1)
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
		 			            <td><%	
		            data = timetable[4][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                          //      //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="12-12.50" >
                            <%if(!fac){%><input type=checkbox name="12-12.50" value="12-12.50:W"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[4][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                            //    //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="12-12.50" ><%if(!fac){%><input type=checkbox name="12-12.50" value="12-12.50:F"><%}%></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">14:00-14:50 </th>
		 			            <td><%	
		            data = timetable[5][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
                            fac = false;
                            if(timetable[5][0].contains(faculty) || timetable[5][1].contains(faculty) || timetable[5][2].contains(faculty) || timetable[5][3].contains(faculty) || timetable[5][4].contains(faculty))
                                fac = true;
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                            //    //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="14-14.50" >
                            <%if(!fac){%><input type=checkbox name="14-14.50" value="14-14.50:M"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[5][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                            //    //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="14-14.50" >
                            <%if(!fac){%><input type=checkbox name="14-14.50" value="14-14.50:W"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[5][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                               // //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="14-14.50" >
                            <%if(!fac){%><input type=checkbox name="14-14.50" value="14-14.50:F"><%}%></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">15:00-15:50</th>
		 			            <td><%	
		            data = timetable[6][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             fac = false;
                            if(timetable[6][0].contains(faculty) || timetable[6][1].contains(faculty) || timetable[6][2].contains(faculty) || timetable[6][3].contains(faculty) || timetable[6][4].contains(faculty))
                                fac = true;
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                               // //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="15-15.50" >
                            <%if(!fac){%><input type=checkbox name="15-15.50" value="15-15.50:M"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[6][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                             //   //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="15-15.50" >
                            <%if(!fac){%><input type=checkbox name="15-15.50" value="15-15.50:W"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[6][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                             //   //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="15-15.50" >
                            <%if(!fac){%><input type=checkbox name="15-15.50" value="15-15.50:F"><%}%></div></td>
		 			        </tr>
		 			         <tr>
		 			            <th scope="row">16:00-16:50 </th>
		 			            <td><%	
		            data = timetable[7][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                              fac = false;
                            if(timetable[7][0].contains(faculty) || timetable[7][1].contains(faculty) || timetable[7][2].contains(faculty) || timetable[7][3].contains(faculty) || timetable[7][4].contains(faculty))
                                fac = true;
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                              //  //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="16-16.50" >
                            <%if(!fac){%><input type=checkbox name="16-16.50" value="16-16.50:M"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[7][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                              //  //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="16-16.50" >
                            <%if(!fac){%><input type=checkbox name="16-16.50" value="16-16.50:W"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[7][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%   
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                              //  //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="16-16.50" >
                            <%if(!fac){%><input type=checkbox name="16-16.50" value="16-16.50:F"><%}%></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">17:00-17:50 </th>
		 			            <td><%	
		            data = timetable[8][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                              fac = false;
                            if(timetable[8][0].contains(faculty) || timetable[8][1].contains(faculty) || timetable[8][2].contains(faculty) || timetable[8][3].contains(faculty) || timetable[8][4].contains(faculty))
                                fac = true;
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                             //   //if(data[i].contains(faculty))	fac = true; %></span>
		            <%
		            	}
		            }
		        %><div id="17-17.50" >
                            <%if(!fac){%><input type=checkbox name="17-17.50" value="17-17.50:M"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[8][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                             //   //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="17-17.50" >
                            <%if(!fac){%><input type=checkbox name="17-17.50" value="17-17.50:W"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[8][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                              //  //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="17-17.50" >
                            <%if(!fac){%><input type=checkbox name="17-17.50" value="17-17.50:F"><%}%></div></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">18:00-18:50 </th>
		 			            <td><%	
		            data = timetable[9][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                              fac = false;
                            if(timetable[9][0].contains(faculty) || timetable[9][1].contains(faculty) || timetable[9][2].contains(faculty) || timetable[9][3].contains(faculty) || timetable[9][4].contains(faculty))
                                fac = true;
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                             //   //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="18-18.50" >
                            <%if(!fac){%>
                            <input type=checkbox name="18-18.50" value="18-18.50:M"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[9][2].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                              //  //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="18-18.50" >
                            <%if(!fac){%><input type=checkbox name="18-18.50" value="18-18.50:W"><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[9][4].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                               // //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            }
		            }
		        %><div id="18-18.50" >
                            <%if(!fac){%><input type=checkbox name="18-18.50" value="18-18.50:F"><%}%></div></td>
		 			        </tr>
		 			    </tbody>
 <%
  }
// if user enters number of days as 2 then dividing classes into 75min classes
  else if(noOfdays==2)
  {
  %>
  <tbody>
      <tr>
          <th scope="row" >8:00-09:15</th>
          <td>
	            <%	
		            String[] data = timetable[0][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            boolean fac = false;
                            if(timetable[0][0].contains(faculty) || timetable[0][1].contains(faculty) || timetable[0][2].contains(faculty) || timetable[0][3].contains(faculty) || timetable[0][4].contains(faculty))
                                fac = true;
		            
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
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                              //  if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %>
				<div id="8-9.15" >
                                    <%if(!fac){%><input type=checkbox class="checkbox" name="8-9.15" value="8-9.15:T"><%}%></div></td>
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
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                              //  //if(data[i].contains(faculty))	//fac = true; %></span>
		            <%
		            	}
		            }
		        %><div id="8-9.15">
                            <%if(!fac){%><input type=checkbox class="checkbox" name="8-9.15" value="8-9.15:TR"><%}%></div></td>
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
		        %></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">09:30-10:45 </th>
		 						<td>
	            <%	
		            data = timetable[1][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            fac = false;
                            if(timetable[1][0].contains(faculty) || timetable[1][1].contains(faculty) || timetable[1][2].contains(faculty) || timetable[1][3].contains(faculty) || timetable[1][4].contains(faculty))
                                fac = true;
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
		 			            <td><%	
		            data = timetable[1][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                                //if(data[i].contains(faculty))	fac = true; %></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9.30-10.45" >
                            <%if(!fac){%><input type=checkbox name="9.30-10.45" value="9.30-10.45:T" ><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[1][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %>
		        <div id="9.30-10.45" >
                            <%if(!fac){%><input type=checkbox name="9.30-10.45" value="9.30-10.45:TR" ><%}%></div></td>
		 			            <td><%	
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
		 			            <th scope="row">11:00-12:15 </th>
		 			            <td><%	
		            data = timetable[2][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            fac = false;
		            if(timetable[2][0].contains(faculty) || timetable[2][1].contains(faculty) || timetable[2][2].contains(faculty) || timetable[2][3].contains(faculty) || timetable[2][4].contains(faculty))
                                fac = true;
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
		 			            <td><%	
		            data = timetable[2][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="11-12.15" >
                            <%if(!fac){%><input type=checkbox name="11-12.15" value="11-12.15:T" ><%}%></div></td>
		 			            <td><%	
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
		 			            <td><%	
		            data = timetable[2][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="11-12.15" >
                            <%if(!fac){%><input type=checkbox name="11-12.15" value="11-12.15:TR" ><%}%></div></td>
		 			            <td><%	
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
		 			            <th scope="row">12:30-13:45</th>
		 			            <td><%	
		            data = timetable[3][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            fac = false;
                            if(timetable[3][0].contains(faculty) || timetable[3][1].contains(faculty) || timetable[3][2].contains(faculty) || timetable[3][3].contains(faculty) || timetable[3][4].contains(faculty))
                                fac = true;
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[3][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="12.30-13.45" >
                            <%if(!fac){%><input type=checkbox name="12.30-13.45" value="12.30-13.45:T" ><%}%></div></td>
		 			            <td><%	
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
		        %></td>
		 			            <td><%	
		            data = timetable[3][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="12.30-13.45" >
                            <%if(!fac){%><input type=checkbox name="12.30-13.45" value="12.30-13.45:TR"><%}%></div></td>
		 			            <td><%	
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
		        %></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">14:00-15:15 </th>
		 			            <td><%	
		            data = timetable[4][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            fac = false;
                            if(timetable[4][0].contains(faculty) || timetable[4][1].contains(faculty) || timetable[4][2].contains(faculty) || timetable[4][3].contains(faculty) || timetable[4][4].contains(faculty))
                                fac = true;
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[4][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]);
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="14-15.15" >
                            <%if(!fac){%><input type=checkbox name="14-15.15" value="14-15.15:T"><%}%></div></td>
		 			            <td><%	
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
		        %></td>
		 			            <td><%	
		            data = timetable[4][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                                //if(data[i].contains(faculty))	fac = true;
                                %></span>
		            <%
		            	}
		            }
		        %><div id="14-15.15" >
                            <%if(!fac){%><input type=checkbox name="14-15.15" value="14-15.15:TR"><%}%></div></td>
		 			            <td><%	
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
		        %></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">15:30-16:45 </th>
		 			            <td><%	
		            data = timetable[5][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            fac = false;
                            if(timetable[5][0].contains(faculty) || timetable[5][1].contains(faculty) || timetable[5][2].contains(faculty) || timetable[5][3].contains(faculty) || timetable[5][4].contains(faculty))
                                fac = true;
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[5][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="15.30-16.45" >
                            <%if(!fac){%><input type=checkbox name="15.30-16.45" value="15.30-16.45:T"><%}%></div></td>
		 			            <td><%	
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
		        %></td>
		 			            <td><%	
		            data = timetable[5][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="15.30-16.45" >
                            <%if(!fac){%><input type=checkbox name="15.30-16.45" value="15.30-16.45:TR"><%}%></div></td>
		 			            <td><%	
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
		        %></td>
		 			        </tr>
		 			        <tr>
		 			            <th scope="row">17:00-18:15</th>
		 			            <td><%	
		            data = timetable[6][0].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                            fac = false;
		            if(timetable[6][0].contains(faculty) || timetable[6][1].contains(faculty) || timetable[6][2].contains(faculty) || timetable[6][3].contains(faculty) || timetable[6][4].contains(faculty))
                                fac = true;
                            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom"><%out.println(data[i]); %></span>
		            <%
		            	}
		            }
		        %></td>
		 			            <td><%	
		            data = timetable[6][1].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                <%out.println(data[i]); 
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="17:00-18:15" >
                            <%if(!fac){%><input type=checkbox name="17:00-18:15" value="17:00-18:15:T"><%}%></div></td>
		 			            <td><%	
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
		        %></td>
		 			            <td><%	
		            data = timetable[6][3].split(";");
	            	%>
	            		<span style="background-color: #FFA07A; display:inline-block; vertical-align:bottom"><%out.println(data[0]); %></span>
	            	<%
                             
		            if(data.length>1)
		            {
		            	for(int i = 1;i<data.length;i++)
		            	{
		            %>
		            <span style="background-color: #FFDAB9; display:inline-block; vertical-align:bottom">
                                
                                <%out.println(data[i]); 
                                //if(data[i].contains(faculty))	fac = true;%></span>
		            <%
		            	}
		            }
		        %><div id="17:00-18:15" >
                            <%if(!fac){%><input type=checkbox name="17:00-18:15" value="17:00-18:15:TR"><%}%></div></td>
		 			            <td><%	
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
		        %></td>
		 			        </tr>		 			        
		 			    </tbody>
  <%
    }  
else
{
    out.println("<script type=\"text/javascript\">");
		  			   	    out.println("alert('Credit should be 2 or 3! ');");
		  			   	    out.println("location='Scheduler1.jsp';");
		  			   	    out.println("</script>");
}
   %>
          </table>
          
<input type=submit name=Show value="Show">
<%}
	}
	catch(Exception e){}
%>
  </form>
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
  </div>
</body>
</html>
