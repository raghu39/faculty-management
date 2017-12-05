<!-- This is a schedular page which queries the database and populates the course data in the drop down and fetches the campus 
and department selected data from schedular2.jsp and on click of show button directed to shechuler4.jsp-->
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
<form name=schedule action="Scheduler4.jsp" method=POST>
<input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
<%
	String campus = request.getParameter("campus");
	String dept = request.getParameter("dept");
%>
<h3>Campus : <label> <%=campus %></label><input type=hidden name=campus value='<%=campus %>'></h3>
<h3>Department : <label> <%=dept %></label><input type=hidden name=dept value='<%=dept %>'></h3>
<p><a href=<%= "\"ViewAllFaculty.jsp?Id=" + dept + "&amp;user="+user+"\"" %> >View All Faculty</a></p>
<h3>Course : </h3><p><select name=course>
<option>--Select Course--</option>
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
	  	String QueryString = "Select s.Name from subject s,department d where s.DeptId=d.DeptId and d.Name='"+dept+"'";
	  	rs = st.executeQuery(QueryString);
	  	while(rs.next())
	  	{
		  %>
		  <option><%=rs.getString(1) %></option>
		  <%
		}
		connection.close();
		}
		catch(Exception e){}%>
	 </select></p>
	 <input type=submit name=Show>
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
