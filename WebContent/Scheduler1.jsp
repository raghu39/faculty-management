<!-- This is a schedular page which queries the database and populates the campus data in the drop down
on click of show button directed to shechuler2.jsp-->
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
%>
 <h3> Hi <%=session.getAttribute("username").toString() %> !</h3>
 <%
 session.setAttribute("username",user);
 %>
 
    <div id="site_content">
    <ul class="tab">
  <li><a href="#" class="tablinks">Schedule</a></li>
  <li><a href=<%= "\"AdminHome.jsp?user=" + user + "\"" %> class="tablinks">Home</a></li>
</ul>

<div id="home" class="tabcontent" style="display:block">
<h3>Schedule</h3>
<form name=schedule action="Scheduler2.jsp" method=POST>
<input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
<h3>Campus :</h3>
 <p><select name=campus id=campus>
 <option>--Select campus--</option>
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
 	String QueryString = "Select LocationName from location";
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
  <input type=submit name=Show value=Show>
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
