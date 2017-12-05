<!--This page contains the logic for the changing the password. When the admin/faculty forgots the password. There is a flexibility
to change the password.-->
<%@ page import="java.sql.*" %>
<!DOCTYPE HTML>
<html>
<head>
  <title>Home</title>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
  <link rel="stylesheet" type="text/css" href="css/style.css" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
  <script type="text/javascript">
  function validateForm() {
	    var x = document.forms["change_pwd"]["pwd"].value;
	    var x1 = document.forms["change_pwd"]["pwd1"].value;
	   if (x == "") {
	        alert("New password must be filled out");
	        return false;
	    }
	    else if (x1 == "") {
	        alert("Confirm Password must be filled out");
	        return false;
	    }
	    else if (x1 != x2) {
	        alert("Both fields must have same value!");
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
<% String user=session.getAttribute("username").toString() ;
	session.setAttribute("username",user);%>
 <h3> Hi <%=user %> !</h3>
 
    <div id="site_content">
    <ul class="tab">
  <li><a href="#" class="tablinks">Schedule</a></li>
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
           <script type="text/javascript">
			function yesnoCheck() {
			    if (document.getElementById('noCheck').checked) {
			        document.getElementById('ifYes').style.display = 'none';
			    }
			    else {
			    	document.getElementById('ifYes').style.display = 'block';
			    }
			}
		</script>

<h3>&nbsp;&nbsp;&nbsp;&nbsp;Want to change your password :</h3>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" onclick="javascript:yesnoCheck();" name="yesno" id="yesCheck" value="Yes"> Yes</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" onclick="javascript:yesnoCheck();" name="yesno" checked="checked" id="noCheck" value="No"> No</p><br>
<div id="ifYes" style="display:none">
<form name=change_pwd method=post action="UpdatePassword.jsp" onsubmit="return validateForm()">
<input type=hidden name=user value='<%=session.getAttribute("username").toString() %>'>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;New Password : <input type=text name=pwd></p>
	<p>&nbsp;&nbsp;&nbsp;&nbsp;Confirm Password : <input type=text name=pwd1></p>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=submit value="Save Password"><br><br>
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
