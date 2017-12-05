<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Faculty</title>
        <link rel="stylesheet" type="text/css" href="css/style.css" />
          <link rel="shortcut icon" href="favicon.png" />
  <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
</head>
<%
String fname = request.getParameter("fname");
String lname = request.getParameter("lname");
String email = request.getParameter("email");
String username= request.getParameter("username");
String password = request.getParameter("pswd");
String dept = request.getParameter("dept");
String sub = request.getParameter("sub");
String loc = request.getParameter("loc");
int subid=0;
int fid = 0;
try
	  			{
	  				Statement statement1 = null;
	  		    	ResultSet rs1 = null;
	  		        String connectionURL1 = "jdbc:mysql://localhost:3306/facultywebsite";
	  		    	Connection connection1 = null; 
		  			Class.forName("com.mysql.jdbc.Driver").newInstance(); 
		  			connection1 = DriverManager.getConnection(connectionURL1, "root", "root");
		  			Statement st1 = connection1.createStatement();		
		  			//facultyID-noOfdays-day-section-room-course-time//
                                       // insert into accountant values('"+username+"','"+"faculty"+"','"+password++ "')
                                  			//int i = st1.executeUpdate("insert into accountant values('+username+')");
           int i = st1.executeUpdate("insert into accountant values('"+ username +"','"+ "faculty"  +"','"+ password+"')");
 

                                }
catch(Exception e)
{}
try 
{
	Statement statement = null;
  	ResultSet rs = null;
  	String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
	Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	Statement st = connection.createStatement();
	String QueryString = "Select SubjectId from subject where Name='"+sub+"'";
    rs = st.executeQuery(QueryString);
	if(rs.next())
	{
		subid = Integer.parseInt(rs.getString(1));
		%>
		<h3><%=subid %></h3>
		<h3><%=fname %></h3>
		<h3><%=lname %></h3>
		<h3><%=email %></h3>
		<h3><%=dept %></h3>
		<h3><%=sub %></h3>
		<%
	}
}catch(Exception e)
{}
try 
{
	Statement statement = null;
  	ResultSet rs = null;
  	String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
	Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	Statement st = connection.createStatement();
	String QueryString = "Select MAX(FacultyId) from faculty";
    rs = st.executeQuery(QueryString);
	if(rs.next())
	{
		fid = Integer.parseInt(rs.getString(1));
		fid+=1;
	}
}catch(Exception e)
{}
String jtype = request.getParameter("jtype");
int chrs = Integer.parseInt(request.getParameter("chrs"));
try
{
	Statement statement = null;
    ResultSet rs = null;
    String connectionURL = "jdbc:mysql://localhost:3306/facultywebsite";
    Connection connection = null; 
	Class.forName("com.mysql.jdbc.Driver").newInstance(); 
	connection = DriverManager.getConnection(connectionURL, "root", "root");
	Statement st = connection.createStatement();
String qury = "insert into faculty values('"+fname+" "+lname+"','"+fid+"','" + subid + "','" + dept + "','" + loc + "','" + sub + "','" + chrs + "',null,null,'" + jtype + "','" + email + "',null,'"+username+"')";
	int i = st.executeUpdate(qury);
System.out.println("i : "+i);
	if(i>0)
	{
            System.out.println("inside if!");
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "587");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.starttls.enable", "true");
        String course = sub;
        Session sess = Session.getInstance(props, new javax.mail.Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication("rraghunath074@gmail.com", "Raghunath93");//change accordingly  
        }
        });
String to = email;
        try {
        MimeMessage message = new MimeMessage(sess);
        message.setFrom(new InternetAddress("rraghunath074@gmail.com"));//change accordingly  
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("A new Faculty was Added");
        message.setText("Hello,\n A new faculty member was added:\n\n Name : "+fname+"\n\n Departmenet : "+dept+"\n\n Username: "+username+"\n\n password "+password+"+\n\n Subject : "+sub+".\n Thank You\n");
        Transport.send(message);
        } catch (MessagingException e) {
        e.printStackTrace();
        throw new RuntimeException(e);
        }
            out.println("<script type=\"text/javascript\">");
	    out.println("alert('Faculty added successfully!! ');");
            out.println("location='AdminHome.jsp';");
            out.println("</script>");
	}
	else
	{
            out.println("<script type=\"text/javascript\">");
 	    out.println("alert('Could not add faculty!! ');");
 	    out.println("location='AddFaculty.jsp';");
 	    out.println("</script>");
	}
}
catch(Exception e)
{
	System.out.println("Could not Update faculty details!!");
	e.printStackTrace();
}
%>
