<!-- This is a schedular page which queries the database and populates the faculty data in the drop down and fetches the campus 
course and department selected data from schedular3.jsp and on click of show button directed to shechuler5.jsp-->
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Course Scheduling Assistant</title>
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
</div><%
    // session for admin
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
<form name=schedule action="Scheduler5.jsp" method=POST>
<input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
<%
    // getting data from scheduler 1,2 and 3 pages 
	String campus = request.getParameter("campus");
	String dept = request.getParameter("dept");
	String course = request.getParameter("course");
%>
<h3>Campus : <label> <%=campus %></label><input type=hidden name=campus value='<%=campus %>'></h3>
<h3>Department : <label> <%=dept %></label><input type=hidden name=dept value='<%=dept %>'></h3>
<h3>Course : <label> <%=course %></label><input type=hidden name=course value='<%=course %>'></h3>
<p><a  href="ViewAllFaculty.jsp">View All Faculty</a></p>
<h3>Faculty : </h3><p><select name=faculty>
<option>--Select Faculty--</option>
	 <%
	 try
	  {
// connecting to database              
// selecting faculty from database
	  	Statement statement = null;
	    ResultSet rs = null;
	    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
	    Connection connection = null; 
	  	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	  	connection = DriverManager.getConnection(connectionURL, "root", "root");
	  	Statement st = connection.createStatement();
	  	String QueryString = "Select f.FacultyName from faculty f,subject s where s.SubjectId=f.SubjectId and s.Name='"+course+"'";
	  	rs = st.executeQuery(QueryString);
	  	if(rs!=null)
	  	{
	  		while(rs.next())
	  		{
		  %>
		  <option><%=rs.getString(1) %></option>
		  <%
		  	}
	  		%></select></p><%
	  	}
	  	else
	  	{
	  		%>
	  		<h3>No Faculty teaches this Subject!!</h3>
	  		<%
	  	}

	    
	  		connection.close(); // closing database connection
	  		}
	 		catch(Exception e){}
		  %>
  <input type=submit value=Show>
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
