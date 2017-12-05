<!-- This is schedular page which displays the rooms based on the time slot selected -->
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Home</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
  <script type="text/javascript">
  funciton cancel()
  {
	  alert('You have cancelled the schedule!! ');
	  location='Scheduler1.jsp';
  }
  </script>
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
<form name=schedule action="Scheduler9.jsp" method=POST>
<input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
<%
	String campus = request.getParameter("campus");
	String dept = request.getParameter("dept");
	String course = request.getParameter("course");
	String faculty = request.getParameter("faculty");
	int noOfdays = Integer.parseInt(request.getParameter("noOfdays"));
	int room = Integer.parseInt(request.getParameter("room"));
	String[] time9 = request.getParameterValues("alltime");
        out.println(time9.length);
	if (time9 != null) 
	{
	   for (int i = 0; i < time9.length; i++) 
	   {
               out.println(time9[i]);
		   %>
		 <input type=hidden name=alltime value='<%=time9[i]%>'>
	 	 <%
	 	 //out.println("\n"+time9[i]+"\n");
	   }
	}
%>
<h3>Campus : <label> <%=campus %></label><input type=hidden name=campus value='<%=campus %>'></h3>
<h3>Department : <label> <%=dept %></label><input type=hidden name=dept value='<%=dept %>'></h3>
<h3>Course : <label> <%=course %></label><input type=hidden name=course value='<%=course %>'></h3>
<h3>Faculty : <label> <%=faculty %></label><input type=hidden name=faculty value='<%=faculty %>'></h3>
<h3>Number of Days :  <label> <%=noOfdays %></label><input type=hidden name=noOfdays value='<%=noOfdays %>' ></h3>

<h3>Room : <label> <%=room %></label><input type=hidden name=room value='<%=room %>' ></h3>
<input type=submit name=Show value="Schedule">
<input type=button name=cancel value="Cancel" onclick="cancel()">
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
