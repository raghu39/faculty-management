<!--This is a schedular page which contains the logic on the time slot selected to be pushed into the database -->
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Home</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
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
<form name=schedule action="Scheduler8.jsp" method=POST>
<input type="hidden" name=user value=<%=session.getAttribute("username").toString() %>>
<%
	String campus = request.getParameter("campus");
	String dept = request.getParameter("dept");
	String course = request.getParameter("course");
	String faculty = request.getParameter("faculty");
	int noOfdays = Integer.parseInt(request.getParameter("noOfdays"));
        String[] time, time1,time2,time3,time4,time5,time6,time7,time8,time9;
        if(noOfdays == 2)
        {
             time = request.getParameterValues("8-9.15");
              time1 = request.getParameterValues("9.30-10.45");
           time2 = request.getParameterValues("11-12.15");
           time3 = request.getParameterValues("12.30-13.45");
            time4 = request.getParameterValues("14-15.15");
            time5 = request.getParameterValues("15.30-16.45");
           time6 = request.getParameterValues("17.00-18.15");
           time7 = null;
           time8 = null;
           time9=null;
        }
        else
        {
            time = request.getParameterValues("8-8.50");
	time1 = request.getParameterValues("9-9.50");
	time2 = request.getParameterValues("10-10.50");
	time3 = request.getParameterValues("11-11.50");
	time4 = request.getParameterValues("12-12.50");
	 time5 = request.getParameterValues("14-14.50");
	time6 = request.getParameterValues("15-15.50");
	time7 = request.getParameterValues("16-16.50");
	time8 = request.getParameterValues("17-17.50");
	time9 = request.getParameterValues("18-18.50");
            
        }
	
	String[] alltime = new String[5];
        //out.println(time1);
	int count = 0;
	   if (time != null) 
	   {
	      for (int i = 0; i < time.length; i++) 
	      {
	    	  if(count<5)
	    	  {
	    		  alltime[count]=time[i];
	 	         //out.println ("<b>"+time[i]+"<b>");
	 	         count+=1;
	    	  }
	      }
	   }
	  // else out.println ("<b>none<b>");
	   
	   if (time1 != null) 
	   {
	      for (int i = 0; i < time1.length; i++) 
	      {
	    	  if(count<5)
	    	  {alltime[count]=time1[i];
	       //  out.println ("<b>"+time1[i]+"<b>");
	         count+=1;}
	      }
	   }
	  // else out.println ("<b>none<b>");
	   if (time2 != null) 
	   {
	      for (int i = 0; i < time2.length; i++) 
	      {
	    	  if(count<5)
	    	  {alltime[count]=time2[i];
	       //  out.println ("<b>"+time2[i]+"<b>");
	         count+=1;}
	      }
	   }
	   //else out.println ("<b>none<b>");
	   if (time3 != null) 
	   {
	      for (int i = 0; i < time3.length; i++) 
	      {
	    	  if(count<5)
	    	  {alltime[count]=time3[i];
	        // out.println ("<b>"+time3[i]+"<b>");
	         count+=1;}
	      }
	   }
	   //else out.println ("<b>none<b>");
	   if (time4 != null) 
	   {
	      for (int i = 0; i < time4.length; i++) 
	      {
	    	  if(count<5)
	    	  {alltime[count]=time4[i];
	        // out.println ("<b>"+time4[i]+"<b>");
	         count+=1;}
	    	  else
	   	   {
	   	      out.println("<script type=\"text/javascript\">");
	   	      out.println("alert('Number of credit hours selected is greater than number of credit hours alloted to the faculty!! ');");
	   	      out.println("location='Scheduler1.jsp';");
	   	      out.println("</script>");
	   	   }
	      }
	   }
	   //else out.println ("<b>none<b>");
	   if (time5 != null) 
	   {
	      for (int i = 0; i < time5.length; i++) 
	      {
	    	  if(count<5)
	    	  {alltime[count]=time5[i];
	       //  out.println ("<b>"+time5[i]+"<b>");
	         count+=1;}
	    	  else
	   	   {
	   	      out.println("<script type=\"text/javascript\">");
	   	      out.println("alert('Number of credit hours selected is greater than number of credit hours alloted to the faculty!! ');");
	   	      out.println("location='Scheduler1.jsp';");
	   	      out.println("</script>");
	   	   }
	      }
	   }
	   //else out.println ("<b>none<b>");
	   if (time6 != null) 
	   {
	      for (int i = 0; i < time6.length; i++) 
	      {
	    	  if(count<5)
	    	  {alltime[count]=time6[i];
	        // out.println ("<b>"+time6[i]+"<b>");
	         count+=1;}
	    	  else
	   	   {
	   	      out.println("<script type=\"text/javascript\">");
	   	      out.println("alert('Number of credit hours selected is greater than number of credit hours alloted to the faculty!! ');");
	   	      out.println("location='Scheduler1.jsp';");
	   	      out.println("</script>");
	   	   }
	      }
	   }
	   //else out.println ("<b>none<b>");
	   if (time7 != null) 
	   {
	      for (int i = 0; i < time7.length; i++) 
	      {
	    	  if(count<5)
	    	  { alltime[count]=time7[i];
	       //  out.println ("<b>"+time7[i]+"<b>");
	         count+=1;}
	    	  else
	   	   {
	   	      out.println("<script type=\"text/javascript\">");
	   	      out.println("alert('Number of credit hours selected is greater than number of credit hours alloted to the faculty!! ');");
	   	      out.println("location='Scheduler1.jsp';");
	   	      out.println("</script>");
	   	   }
	      }
	   }
	  // else out.println ("<b>none<b>");
	   if (time8 != null) 
	   {
	      for (int i = 0; i < time8.length; i++) 
	      {
	    	  if(count<5)
	    	  {alltime[count]=time8[i];
	         //out.println ("<b>"+time8[i]+"<b>");
	         count+=1;}
	    	  else
	   	   {
	   	      out.println("<script type=\"text/javascript\">");
	   	      out.println("alert('Number of credit hours selected is greater than number of credit hours alloted to the faculty!! ');");
	   	      out.println("location='Scheduler1.jsp';");
	   	      out.println("</script>");
	   	   }
	      }
	   }
	 //  else out.println ("<b>none<b>");
	   if (time9 != null) 
	   {
	      for (int i = 0; i < time9.length; i++) 
	      {
	    	  if(count<5)
	    	  { alltime[count]=time9[i];
	        // out.println ("<b>"+time9[i]+"<b>");
	         count+=1;}
	    	  else
	   	   {
	   	      out.println("<script type=\"text/javascript\">");
	   	      out.println("alert('Number of credit hours selected is greater than number of credit hours alloted to the faculty!! ');");
	   	      out.println("location='Scheduler1.jsp';");
	   	      out.println("</script>");
	   	   }
	      }
	   }
	   //else out.println ("<b>none<b>");
           
           if(count<=noOfdays)
	   {
		   while(count>=1)
		   {
                       out.println(count);
                       out.println(alltime[count-1]);
			   %>  
                           <input type=hidden name=alltime value='<%=alltime[count-1]%>'>	 
			   <%
			   count-=1;
		   }
%>
<h3>Campus : <label> <%=campus %></label><input type=hidden name=campus value='<%=campus %>'></h3>
<h3>Department : <label> <%=dept %></label><input type=hidden name=dept value='<%=dept %>'></h3>
<h3>Course : <label> <%=course %></label><input type=hidden name=course value='<%=course %>'></h3>
<h3>Faculty : <label> <%=faculty %></label><input type=hidden name=faculty value='<%=faculty %>'></h3>
<h3>Number of Days :  <label> <%=noOfdays %></label><input type=hidden name=noOfdays value='<%=noOfdays %>' ></h3>
	 
<h3>Room : </h3><p><select name=room>
<option>--Select Room--</option>
	 <%
	//String time_data="(";
	 try
	  {
	  	Statement statement = null;
	    ResultSet rs = null;
	    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
	    Connection connection = null; 
	  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	  	connection = DriverManager.getConnection(connectionURL, "root", "root");
	  	Statement st = connection.createStatement();
	  	String[] data = alltime[0].split(":");
                String QueryString = "(select distinct r.RoomNumber from room r, location l, building b where r.RoomNumber not in (select RoomNumber from timetable where TimeDuration in ('"+data[0]+"')) and l.LocationName= '"+campus+"' and b.LocationId=l.LocationId)"; 
	  	rs = st.executeQuery(QueryString);
                out.println(rs);
	  	while(rs.next())
	  	{
                   // System.out.println(rs.getString(1));
		  %>
		  <option><%=rs.getString(1)%></option>
		  <%
		  	}
	  		connection.close();
	  	%>
	  	
	  	<%	  		}
	 		catch(Exception e1){}
		  %>
  </select></p>
<input type=submit name=Show value="Show">
<%
}
	   else
	   {
	      out.println("<script type=\"text/javascript\">");
	      out.println("alert('Number of credit hours selected is greater than number of credit hours alloted to the faculty!! ');");
	      out.println("location='Scheduler1.jsp';");
	      out.println("</script>");
	   }
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
