<%@ page import="java.sql.*" %>

<!DOCTYPE html>
 <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Faculty</title>
        <link rel="stylesheet" type="text/css" href="css/style.css" />
          <link rel="shortcut icon" href="favicon.png" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
        </head>
<script type="text/javascript">
    //validations for adding faculty
                function validateForm() {
	    var x = document.forms["add"]["fname"].value;
	    var x1 = document.forms["add"]["lname"].value;
	    var x2 = document.forms["add"]["email"].value;
	    if (x == "") {
	        alert("FirstName must be filled out");
	        return false;
	    }
	    else if (x1 == "") {
	        alert("LastName must be filled out");
	        return false;
	    }
	    else if (x2 == "") {
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
        tablinks[i].className = tablinks[i].className.replace("active", "");
    }

    // Show the current tab, and add an "active" class to the link that opened the tab
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
}
                </script>
                
                
                <script>
// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
</script>
    
    <body>
        <div>
        <h3>Add Faculty!</h3>
<form name=add action="AddFac.jsp" method="POST" onsubmit="return validateForm()">
<p>Firstname : <input type=text name=fname></p>
<p>Lastname : <input type=text name=lname></p>
<p>Email ID : <input type=text name=email></p>
<p>Username : <input type="text" name="username"></p>
<p>Password : <input type="password" name="pswd"></p>
<p>Department : <select id=dept name=dept onchange="change()">
<option>-Select Department-</option>
  <%
  try
  {
      // connecting to database to retrieve department data
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
  <%=request.getParameter("dept")%>
  <script>
      alert(document.getElementById("dept").value);
      alert("hello");
  </script>
  <p>Subject : <select id=sub name=sub>
  <option>-Select Subject-</option>
  <%  
  try
  {
      
      // conencting database for subject
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
      // connecting to datbase for location like campus A, campus B
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
  	// connecting to database for selecting job-type 
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
  <p>CreditHours : <input type=text name=chrs  min="9" max="12"></p>
  <br><input type=submit name=add value=" Add "><br><br> 
</form>
</div>
         
    </body>
 </html> 
