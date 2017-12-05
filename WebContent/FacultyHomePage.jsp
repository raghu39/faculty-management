<!-- This is faculty home page. It contains home , course and faculty tabs. On click of these tabs, it is directed
to specific pages-->
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Course Scheduling Faculty Home</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="shortcut icon" href="favicon.png" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script></head>
  <script type="text/javascript">
function openCity(evt, cityName) {
    // Declare all variables
    var i, tabcontent, tablinks;

    // Get all elements with class="tabcontent" and hide them
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }

    // Get all elements with class="tablinks" and remove the class "active"
    tablinks = document.getElementsByClassName("tablinks");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" active", "");
    }

    // Show the current tab, and add an "active" class to the link that opened the tab
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}
function SelectCourse(course){
    //var course = document.getElementById("course");
    //if(course.value == "yes"){
       document.getElementById('content').style.display = 'block';
       document.getElementById('content').value=course;
    /*}else{
        document.getElementById("mySelect1").disabled = true;
    }*/
}
</script>
<script>
// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
</script>
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
<% String user=session.getAttribute("username").toString() ;
	session.setAttribute("username",user);%>
 <h3> Hi <%=user %> !</h3>
 
    <div id="site_content">
      <ul class="tab">
  <li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'home')" id="defaultOpen">Home</a></li>
  <li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'course')">Course</a></li>
  <li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'faculty')">Faculty</a></li>
</ul>

<div id="home" class="tabcontent" style="display:block">
  <h3>Home</h3>
  <p>Welcome!!</p>
</div>
<div id="course" class="tabcontent">
<form method=POST name=selectCourse action="Faculty_SubjectCalendar.jsp">
<input type=hidden name=user value=<%=user %>>
  <h3>Course : <select id=course name=course>
  <option>-Select Course-</option>
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
  	String QueryString = "Select Name from subject";
  	rs = st.executeQuery(QueryString);
  	out.println("queried successfully!");
  	while(rs.next())
  	{
	  %>
	  <option> <%=rs.getString(1)%></option>
	  <%
  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  %>
  </select></h3><br>
  <input type=submit value="Show Calendar" name=submit>
  </form>
  </div>


<div id="faculty" class="tabcontent">
  <form method=POST name=selectFaculty action="Faculty_FacultyCalendar.jsp">
  <input type=hidden name=user value=<%=user %>>
  <h3>Faculty : <select id=faculty name=faculty>
  <option>-Select Faculty-</option>
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
  	String QueryString = "Select distinct(FacultyName) from faculty";
  	rs = st.executeQuery(QueryString);
  	out.println("queried successfully!");
  	while(rs.next())
  	{
	  %>
	  <option> <%=rs.getString(1)%></option>
	  <%
  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  %>
  </select></h3>
  <input type=submit value="Show Calendar" name=submit>
  </form>
</div>
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
