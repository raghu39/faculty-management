<!--This is AdminHome page. It contains home,faculty,course,AddFaculty and RemoveFaculty tabs. 
On click of those tabs it is directed to specific pages.-->
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Home</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="shortcut icon" href="favicon.png" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script></head>
  <script type="text/javascript">
  // function for validating Add faculty text fields
    function validateForm() {
	    var x = document.forms["add"]["fname"].value;
	    var x1 = document.forms["add"]["lname"].value;
	    var x2 = document.forms["add"]["email"].value;
	    if (x == "") {
	        alert("FirstName must be filled out");
	        return false;
	    }
	    else if (x1 === "") {
	        alert("LastName must be filled out");
	        return false;
	    }
	    else if (x2 === "") {
	        alert("Email must be filled out");
	        return false;
	    }
	}
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
       document.getElementById('content').style.display = 'block';
       document.getElementById('content').value=course;
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
<%
	String user = session.getAttribute("username").toString();
       /* try{
        if(session.getAttribute("message").equals("added")){
       out.println("<script type=\"text/javascript\">");
	      out.println("alert('Faculty added successfully!! ');");
	    //out.println("location='AdminHome.jsp';");
	    out.println("</script>");
        }
        }catch(NullPointerException e){}*/
%>
 <h3> Hi <%=user %> !</h3>
 <%
     // session for user
 session.setAttribute("username",user);
 %>
    <div id="site_content">
      <ul class="tab">
  <li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'home')" id="defaultOpen">Home</a></li>
  <li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'course')">Course</a></li>
  <li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'faculty')">Faculty</a></li>  
  <li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'add')">Add Faculty</a></li>  
  <li><a href="javascript:void(0)" class="tablinks" onclick="openCity(event, 'remove')">Remove Faculty</a></li>
</ul>

<div id="home" class="tabcontent" style="display:block">
  <h3>Home</h3>
  <p>Welcome!!</p>
  <p>To schedule timetable, <a href="Scheduler1.jsp">Click here !!</a></p>
</div>
<div id="course" class="tabcontent">
<form method=POST name=selectCourse action="SubjectCalendar.jsp">
<input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
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
	  <option value="<%= rs.getString(1) %>"> <%=rs.getString(1)%></option>
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

<div id="faculty" class="tabcontent">
  <h3>Faculty</h3>
  <form method=POST name=selectFaculty action="FacultyCalendar.jsp">
  <input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
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
  	while(rs.next())
  	{
	  %>
	  <option value="<%= rs.getString(1) %>"> <%=rs.getString(1)%></option>
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
<div id="add" class="tabcontent">
<h3>Add Faculty!</h3>
<form name=add action="AddFac.jsp" method=POST onsubmit="return validateForm()">
<input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
<p>Firstname : <input type=text name=fname></p>
<p>Lastname : <input type=text name=lname></p>
<p>Email ID : <input type=text name=email></p>
<p>Username : <input type="text" name="username"></p>
<p>Password : <input type="password" name="pswd"></p>
<p>Department : <select id=dept name=dept>
<option>-Select Department-</option>
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
  	String QueryString = "Select Name from department";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  %>
	  <option value="<%= rs.getString(1) %>"> <%=rs.getString(1)%></option>
	  <%
  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  %>  
  </select></p>
  <p>Subject : <select id=sub name=sub>
  <option>-Select Subject-</option>
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
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  %>
	  <option value='<%= rs.getString(1) %>'> <%=rs.getString(1)%></option>
	  <%
  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  %>  
  </select></p>
  <p>Location : <select id=loc name=loc>
  <option>-Select Location-</option>
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
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  %>
	  <option value="<%= rs.getString(1) %>"> <%=rs.getString(1)%></option>
	  <%
  	}
  }
  catch(Exception e)
  {       
	  out.println("Unable to connect to database!");
  }
  %>  
  </select></p> 
  <p>Job Type : <select id=jtype name=jtype>
  <option>-Select Job Type-</option>
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
  	String QueryString = "Select DISTINCT Type from faculty";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  %>
	  <option value="<%= rs.getString(1) %>"> <%=rs.getString(1)%></option>
	  <%
  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  %>  
  </select></p>
  <p>Credit Hours : <input type=text name=chrs  min="1" max="12"></p>
  <br><input type=submit name=add value=" Add Faculty "><br><br>
</form>
</div>
<div id="remove" class="tabcontent">
<h3>Remove Faculty!</h3>
<form name=add action="RemoveFac.jsp" method=POST>
<input type=hidden name=user value=<%=session.getAttribute("username").toString() %>>
<p>Faculty : <select id=faculty name=faculty>
<option>--Select Faculty--</option>
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
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  %>
	  <option value="<%= rs.getString(1) %>"> <%=rs.getString(1)%></option>
	  <%
  	}
  }
  catch(Exception e)
  {
	  out.println("Unable to connect to database!");
  }
  %>  
  </select></p>
<input type=submit value="Remove">
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
