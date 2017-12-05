<!-- This page contains the login based on the credintials given it is directed to admin or faculty home page -->
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Home</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script></head>
 
<body>
  <div id="main">
 <div class="dropdown" style="float:right;">
  <button class="user dropbtn" onclick="UserProfile.jsp"></button>
  <div class="dropdown-content">
    <a href="UserProfile.jsp">Profile</a>
    <a href="ChangePassword.jsp">Change Password</a>
    <a href="LoginPage.html">Logout</a>
  </div>
</div>
<% String user=session.getAttribute("username").toString() ;
	session.setAttribute("username",user);%>
 <h3> Hi <%=user %> !</h3>
 
    <div id="site_content">
    <ul class="tab">
  <li><a href="#" class="tablinks">UserProfile</a></li>
  <%
  if(user.equals("admin"))
  {
  %>
  <li><a href=<%= "\"AdminHome.jsp?user=" + user + "\"" %> class="tablinks">Home</a></li>
  <%
  }
  else
  {
  %>
  <li><a href=<%= "\"FacultyHomePage.jsp?user=" + user + "\"" %> class="tablinks">Home</a></li>
  <%
  }  
  %>
</ul>
    &nbsp;&nbsp;&nbsp;&nbsp;<form name=FacultyDetails method=POST action="EditableUserProfile.jsp">
    <input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
    <h3>&nbsp;&nbsp;&nbsp;&nbsp; YOUR PROFILE !</h3>
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
  	String QueryString = "Select FacultyName,maild_id,phone,OfficeAddress,OfficeHours,CreditHours,Type from faculty where Username='"+user+"'";
  	rs = st.executeQuery(QueryString);
  	if(rs.next())
  	{
	  %>
	  	<h3>&nbsp;&nbsp;&nbsp;&nbsp;Name : <%=rs.getString(1) %></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Email id : <%=rs.getString(2) %></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Phone number : <%=rs.getString(3) %></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Office Address : <%=rs.getString(4) %></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Office Hours : <%=rs.getString(5) %></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Credit Hours : <%=rs.getString(6) %></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Job Type : <%=rs.getString(7) %></h3>
	 <%
  	}
  }
  catch(Exception e)
 {
	  e.printStackTrace();
 }
  %>
	<br> &nbsp;&nbsp;&nbsp;&nbsp;
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value="Edit Details"><br><br>
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
</body>
</html>
