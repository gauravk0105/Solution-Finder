<%@page import="includes.Qbank"%>
<%@page import="includes.DataManager"%>
<%@page import="java.util.List"%>
<%@page import="includes.StudentManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String e1=(String)session.getAttribute("ses_email");
    if(e1==null)
    {
        response.sendRedirect("AuthError.jsp");
        return;
    }
    String utype=(String)session.getAttribute("ses_type");
    if(!utype.equals("stud"))
    {
        response.sendRedirect("AuthError.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link href="SourcePackage/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <meta charset="UTF-8">
        <script src="SourcePackage/jquery.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>    
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Questions</title>
        <script>
            $(document).ready(function(){
               $('#tool').tooltip();
                $('#log').tooltip();
            });
            
            function showSoln(str1,qid)
        {
	var xmlhttp;
        
//        var soln = document.getElementById(str1).value;
//        if (soln.length==0 || hide.length==0)
//  	{ 
//  		document.getElementById(str3).innerHTML="";
//  		return;
//  	}
	if (window.XMLHttpRequest)
  	{// code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}
	else
  	{// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	
	xmlhttp.onreadystatechange=function()
  	{
  		if (xmlhttp.readyState==4 && xmlhttp.status==200)
    		{
    				document.getElementById(str1).innerHTML=xmlhttp.responseText;
    		}
  	};
	xmlhttp.open("GET","showSoln.jsp?qid="+qid,true);
	xmlhttp.send();
        }
        </script>
        <style>
ul.breadcrumb {
    padding: 10px 16px;
    list-style: none;
    background-color: #eee;
}
ul.breadcrumb li {
    display: inline;
    font-size: 18px;
}
ul.breadcrumb li+li:before {
    padding: 8px;
    color: black;
    content: ">>\00a0";
}
ul.breadcrumb li a {
    color: #0275d8;
    text-decoration: none;
}
ul.breadcrumb li a:hover {
    color: #01447e;
    text-decoration: underline;
}
</style>
    </head>
    <body>
         <%
            List<StudentManager> list= StudentManager.getRecords("select * from studentmaster where email='"+e1+"'");
        %>
        <div class="container-fluid">
            <nav class="navbar navbar-default ">
                <div class="container-fluid">
                    <div class="navbar-header navbar-left">
                        <button class="navbar-toggle" data-target="#mynavbar" data-toggle="collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a href="studentconsole.jsp" class="navbar-brand">Solution Finder</a>
                    </div>
                    <div class="collapse navbar-collapse" id="mynavbar">
                        <ul class="nav navbar-nav">
                        <li><a href="askQuestion.jsp">Ask Question</a></li>
                        <li class="active" class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" >
                                My Account<span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li class="active" role="presentation"><a href="editProfile.jsp" tabindex="-1" role="menuitem"><span class="glyphicon glyphicon-edit"></span>&nbsp;Edit Profile</a></li>
                                    <li role="presentation"><a href="chngPic.jsp" tabindex="-1" role="menuitem"><span class="glyphicon glyphicon-user"></span>&nbsp;Change Profile Pic</a></li>
                                    <li role="presentation"><a href="chngPassword" tabindex="-1" role="menuitem"><span class="glyphicon glyphicon-lock"></span>&nbsp;Change Password</a></li>
                                </ul>   
                        </li>
                        <li><a href="#">My Questions</a></li>
                    </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#" id="tool" data-placement="bottom" data-toggle="tooltip" title="<% out.print(list.get(0).getName());%>" >
                                <img class="img-circle img-responsive" alt="User" width="22" src="images/img_avatar.png"/>
                             </a></li>
                              <li><a href="Logout.jsp" id="log" data-placement="bottom" data-toggle="tooltip" title="Are u want to Logout?" ><span class="glyphicon glyphicon-log-out">Logout</span></a></li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
        
        <div class="container-fluid">
            <!-- HEADING -->
            <ul class="breadcrumb">
                <li><a href="studentconsole.jsp">Home</a></li>
                <li class="active">My Questions</li>
            </ul>
            <h2 class='page-header text-muted'>My Questions Section</h2>
            <%
                List<Qbank> lt = Qbank.getRecords("select * from qbank where qby='"+e1+"'");
                if(lt==null || lt.size()==0)
                {
            %>
            <h3>On Question Ask Yet</h3>
            <%
                }
                else
{
    for(int k=0;k<lt.size();k++)
    {
%>
    <div class="panel panel-primary" id="accordion">
        <div class="panel-heading">
            <H4>Question <% out.print(k+1); %> : <% out.print(lt.get(k).getQues()); %></h4>
                <h5>Subject : <% out.print(lt.get(k).getQsub());%></h5>
                    <p><small><i>Posted On : <% out.print(lt.get(k).getQdate());%> &nbsp;&nbsp; 
                        </i></small></p>
            <a href="#" class="btn btn-info btn-xs" data-parent="#accordion" data-toggle="collapse" data-target="#col<%out.print(lt.get(k).getQid());%>" onclick="showSoln('col<% out.print(lt.get(k).getQid()); %>',<%out.print(lt.get(k).getQid());%>)" >See Solutions</a>
        </div>
        <div class="panel-body collapse" id="col<% out.print(lt.get(k).getQid()); %>" >
            
        </div>  
    </div>
    <br/>
<%
    }
}
                
            %>
        </div>
    </body>
</html>