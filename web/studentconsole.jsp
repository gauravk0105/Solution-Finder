<%@page import="includes.Photo"%>
<%@page import="includes.Qbank"%>
<%@page import="includes.Solution"%>
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
        <title>Student Console</title>
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
        <script>
            $(document).ready(function(){
               $('#tool').tooltip();
                $('#log').tooltip();
            });
        
    function upload(str1,str2,str3)
        {
	var xmlhttp;
        
        var soln = document.getElementById(str1).value;
        var hide = document.getElementById(str2).value;
        if (soln.length==0 || hide.length==0)
  	{ 
  		document.getElementById(str3).innerHTML="";
  		return;
  	}
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
    				document.getElementById(str3).innerHTML=xmlhttp.responseText;
                                document.getElementById(str1).value="";
    		}
  	};
	xmlhttp.open("GET","uploadSoln.jsp?soln="+soln+"&hide="+hide,true);
	xmlhttp.send();
        }
        
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
    </head>
    <body>
        <%
            List<StudentManager> list= StudentManager.getRecords("select * from studentmaster where email='"+e1+"'");
        %>
        <div class="container-fluid">
            <nav class="navbar navbar-default navbar-fixed-top">
                <div class="container-fluid">
                    <div class="navbar-header navbar-left">
                        <button class="navbar-toggle" data-target="#mynavbar" data-toggle="collapse">
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a href="#" class="navbar-brand">Solution Finder</a>
                    </div>
                    <div class="collapse navbar-collapse" id="mynavbar">
                        <ul class="nav navbar-nav">
                        <li><a href="askQuestion.jsp">Ask Question</a></li>
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" >
                                My Account<span class="caret"></span></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li role="presentation"><a href="editProfile.jsp" tabindex="-1" role="menuitem"><span class="glyphicon glyphicon-edit"></span>&nbsp;Edit Profile</a></li>
                                    <li role="presentation"><a href="chngPic.jsp" tabindex="-1" role="menuitem"><span class="glyphicon glyphicon-user"></span>&nbsp;Change Profile Pic</a></li>
                                    <li role="presentation"><a href="chngPwd.jsp" tabindex="-1" role="menuitem"><span class="glyphicon glyphicon-lock"></span>&nbsp;Change Password</a></li>
                                </ul>   
                        </li>
                        <li><a href="myQuestion.jsp">My Questions</a></li>
                    </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a href="#" id="tool" data-placement="bottom" data-toggle="tooltip" title="<% out.print(list.get(0).getName());%>" >
                                <%
                           String photoid1 = Photo.getPhotoId(e1);
                           if(photoid1.equals("no photo"))
                           {
                         %>
                            <img class="img-circle img-responsive" src="images/img_avatar.png" width="22" alt=""/>
                         <%
                           }
                            else    
                         {
                          %>     
                             <img class="img-circle img-responsive" src="photos/<%= photoid1 %>" width="20" alt=""/>   
                         <%
                             }
                        %>    
<!--                                <img class="img-circle img-responsive" alt="User" width="22" src="images/img_avatar.png"/>-->
                             </a></li>
                              <li><a href="Logout.jsp" id="log" data-placement="bottom" data-toggle="tooltip" title="Are u want to Logout?" ><span class="glyphicon glyphicon-log-out">Logout</span></a></li>
                        </ul>
                    </div>
                </div>
            </nav>
                                
            <br/> <br/> <br/> <br/>                    
            <ul class="breadcrumb">
                <li class="active">Home</li>
            </ul>
            <ul class="nav nav-pills">
                <li class="active"><a href="#" data-target="#profile" data-toggle="pill">Profile</a></li>
                <li><a href="#" data-target="#subject" data-toggle="pill">Discussion Portal</a></li>
            </ul>
            <br/>
            <div class="tab-content">
                
                <div id="profile" class="tab-pane fade in active">
                    <div class="row">
                        <div style="margin-left: 40px;margin-top: 25px" class="col-sm-3">
                        <%
                           String photoid = Photo.getPhotoId(e1);
                           if(photoid.equals("no photo"))
                           {
                         %>
                            <img class="img-rounded img-responsive" src="images/img_avatar.png" width="180" height="160" alt=""/>
                         <%
                           }
                            else    
                         {
                          %>     
                             <img class="img-rounded img-responsive" src="photos/<%= photoid %>" width="180" height="160" alt=""/>   
                         <%
                             }
                        %>
                        <br/>
                        <a href="chngPic.jsp" style="margin-left: 20px">Change Profile Pic</a>
                        </div>
                        <div class="col-sm-7">
                            <CODE><h1 class="text-capitalize text-primary"><MARK><%out.print(list.get(0).getName());%></mark></h1>
                            <h2 class="text-success"><%out.print(list.get(0).getBranch());%></h2>
                            <h3 class="text-danger"><%out.print(list.get(0).getRno());%></h3>
                            <h3 class="text-muted"><%out.print(list.get(0).getCno());%></h3></code>
                        </div>
                    </div>
                </div>
                
                <div id="subject" class="tab-pane">
                    <div class="row">
                        <div class="col-sm-3 pre-scrollable">
                  <%
                      List<Qbank> lst = Qbank.getRecordsQsub("select distinct qsub from qbank where qby<>'"+e1+"'");
                      if(lst.size()==0 || lst==null)
                      {
                  %>
                  <h1>Sorry....</h1>
                  <%
                      }
                      else
                        {
                        
                   %>
                   <h4>Pick a Subject</h4>
                        <ul class="nav nav-pills nav-stacked">
                   <%
                            for(int i=0;i<lst.size();i++)
                            { 
                  %>
                  <li><a href="#" class="text-uppercase" data-target="#<%out.print(lst.get(i).getQsub());%>" data-toggle="pill">
                      <%
                          out.print(lst.get(i).getQsub());
                      %>
                      </a></li>
                  <%     
                            }
                  %>
                        </ul> 
                  <%      
                        }
                  %>         
                            
                        </div> 
                        
                  <div class="col-sm-1"></div>
                        <div class="col-sm-8 ">
                            <div class="tab-content">
                                
                     <%
                         List<Qbank> lst2 = Qbank.getRecordsQsub("select distinct qsub from qbank where qby<>'"+e1+"'");
                         if(lst2.size()==0||lst2==null)
                         {
                         }
                         else
                         {
                             for(int i=0;i<lst2.size();i++)
                             {
                     %>
                                <div id="<%out.print(lst2.get(i).getQsub());%>" class="tab-pane">
                                    <%
                                        String sub = lst2.get(i).getQsub();
                                        List<Qbank> lst3 = Qbank.getRecords("select * from qbank where qby<>'"+e1+"' AND qsub='"+sub+"' order by qdate desc");
                                        if(lst3.size()>0)
                                        {
                                            for(int j=0;j<lst3.size();j++)
                                            {
                               %>                 
                                    <div class="panel panel-primary" id="accordion">
                                      <div class="panel-heading">
                                        <H4>Question <% out.print(j+1); %> : <% out.print(lst3.get(j).getQues()); %></h4>
                                        <h5>Subject : <% out.print(lst3.get(j).getQsub());%></h5>
                                        <p><small><i>Posted On : <% out.print(lst3.get(j).getQdate());%> &nbsp;&nbsp; 
                                                </i></small>&nbsp;&nbsp;&nbsp;<small><i>Posted By : <% out.print(StudentManager.getName(lst3.get(j).getQby()));%> &nbsp;&nbsp; 
                                        </i></small></p>
                                        <a href="#" class="btn btn-info btn-xs" data-parent="#accordion" data-toggle="collapse" data-target="#col<%out.print(lst3.get(j).getQid());%>" onclick="showSoln('col<% out.print(lst3.get(j).getQid()); %>',<%out.print(lst3.get(j).getQid());%>)" >See Solutions</a>        
                                        <a href="#" class="btn btn-info btn-xs" data-parent="#accordion" data-toggle="collapse" data-target="#solve<%out.print(lst3.get(j).getQid());%>" >Upload Solution</a>        
                                     </div>
                                     <div class="panel-body collapse" id="col<% out.print(lst3.get(j).getQid()); %>" >
                                      
                                         
                                     </div>
                                     <div class="panel-footer collapse" id="solve<% out.print(lst3.get(j).getQid()); %>" >
                                         <h3>Upload Solution</h3>
                                         <div id="s1<%out.print(lst3.get(j).getQid());%>"></div>
                                         <form class="form-horizontal">
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="ques">Question:</label>
                          <div class="col-sm-8">
                              <textarea id="soln1<%out.print(lst3.get(j).getQid());%>" class="form-control" id="ques" name="ques" cols="60" rows="5" placeholder="Type Your Solution....."></textarea>
                          </div>
                        </div>                               
                        <div class="form-group"> 
                          <div class="col-sm-offset-2 col-sm-10">
                              <input id="hide1<%out.print(lst3.get(j).getQid());%>" type="hidden" name="qid_hid" value="<%out.print(lst3.get(j).getQid());%>"/>
                              <button type="button" onclick="upload('soln1<%out.print(lst3.get(j).getQid());%>','hide1<%out.print(lst3.get(j).getQid());%>','s1<%out.print(lst3.get(j).getQid());%>')" name="askQuestion" class="btn btn-info btn-lg">Upload Question</button>
                          </div>
                        </div>
             </form>
                                             
                                     </div>
                                    </div>
                        <br/>   
                        <%
                                            }
                                        }
                                    %>
                                </div>     
                     <%
                             }
                         }
                         
                     %>           
                            </div>  
                        </div>
                </div>    
                </div>
        </div>
    </body>
</html>
