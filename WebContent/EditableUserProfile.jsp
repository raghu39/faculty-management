<!--This is a profile page for the faculty who login. It contains personal details of the faculty like emailid 
number and job type-->
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Course Scheduling Edit details</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
    <link rel="shortcut icon" href="favicon.png" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
  <script type="text/javascript">
  function validateForm() {
	    var x = document.forms["FacultyDetails"]["name"].value;
	    var x1 = document.forms["FacultyDetails"]["email"].value;
	    var x2 = document.forms["FacultyDetails"]["phone"].value;
	    var x3 = document.forms["FacultyDetails"]["oadd"].value;
	    var x4 = document.forms["FacultyDetails"]["ohrs"].value;
	    var x5 = document.forms["FacultyDetails"]["chrs"].value;
	   if (x == "") {
	        alert("Name must be filled out");
	        return false;
	    }
	    else if (x2 == "") {
	        alert("Email must be filled out");
	        return false;
	    }
	    else if (x2 == "") {
	        alert("Phone must be filled out!");
	        return false;
	    }
	    else if (x3 == "") {
	        alert("Office address must be filled out");
	        return false;
	    }
	    else if (x4 =="") {
	        alert("Office hours must be filled out!");
	        return false;
	    }
	    else if (x5 == "") {
	        alert("Credit hours must be filled out");
	        return false;
	    }
	}
  </script>
  </head>
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
<%
	String user = session.getAttribute("username").toString();
%>
 <h3> Hi <%=user %> !</h3>
 <%
 session.setAttribute("username",user);
 %>
    <div id="site_content">
    <form name=FacultyDetails method=POST action="EditUserProfile.jsp" onsubmit="return validateForm()">
    
 <input type=hidden name=user value='<%=session.getAttribute("username").toString() %>'>
 <h3>&nbsp;&nbsp;&nbsp;&nbsp;UPDATE YOUR PROFILE!!</h3>
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
  	String QueryString = "Select FacultyName,maild_id,phone,OfficeAddress,OfficeHours,CreditHours,Type from faculty where username='"+session.getAttribute("username").toString()+"'";
  	rs = st.executeQuery(QueryString);
  	//out.println("queried successfully!");
  	while(rs.next())
  	{
	  %>
	  	<h3>&nbsp;&nbsp;&nbsp;&nbsp;Name : <input type=text name=name value='<%=rs.getString(1) %>'></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Email id : <input type=text name=email value='<%=rs.getString(2) %>'></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Phone number : <input type=text name=phone value='<%=rs.getString(3) %>'></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Office Address : <input type=text name=oadd value='<%=rs.getString(4) %>'></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Office Hours : <input type=text name=ohrs value='<%=rs.getString(5) %>'></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Credit Hours : <input type=text name=chrs value='<%=rs.getString(6) %>'></h3>
	    <h3>&nbsp;&nbsp;&nbsp;&nbsp;Job Type : <select name=type>
	    <option>--Select Job Type--</option>
	    <option>full</option>
	    <option>part</option>
	    <option>adjunct</option>
	    </select></h3>
	  <%
  	}
  }
  catch(Exception e)
 {
	  e.printStackTrace();
 }
  %>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value="Save Details"><br><br>
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
