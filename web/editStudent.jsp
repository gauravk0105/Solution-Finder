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
    if(!utype.equals("admin"))
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
        <link href="SourcePackage/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>    
        <script src="SourcePackage/bootstrap.min.js" type="text/javascript"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="SourcePackage/jquery.min.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>Edit Student</title>
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
        <div class="container-fluid">
            <!-- HEADING -->
            <div class="container well">
               <h1 class="text-center text-uppercase text-primary">
                   Admin Console
               </h1>
            </div>
            <ul class="breadcrumb">
                <li><a href="adminconsole.jsp">Home</a></li>
                <li class="active">Edit Student</li>
            </ul>
            <h2 class='page-header text-muted'>Edit Student Form</h2>
            <%
                try{
                    if(request.getParameter("email")!=null)
                    {
                       String email = request.getParameter("email");
                       List<StudentManager> list=StudentManager.getRecords("select * from studentmaster where email='"+email+"'");
                       if(list.size()==0 || list==null)
                       {
            %>
                <h3>Sorry Something went Wrong</h3>
            <%
                       }
                       else
                       {
            %>
                    <form class="form-horizontal" method="post" action="editStudent_DB.jsp">
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="name">Name:</label>
                          <div class="col-sm-8">
                              <input type="text" name="new_name" value="<% out.print(list.get(0).getName()); %>" class="form-control" id="name" placeholder="Enter Name">
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="email">Email:</label>
                          <div class="col-sm-8">
                              <input type="email" name="new_email" class="form-control" value="<% out.print(list.get(0).getEmail()); %>" id="email" placeholder="Enter email">
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="rno">Roll Number:</label>
                          <div class="col-sm-8">
                              <input type="text" name="new_rno" class="form-control" value="<% out.print(list.get(0).getRno()); %>" id="rno" placeholder="Enter Roll Number">
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="branch">Branch:</label>
                             <div class="col-sm-8">
                                <select class="form-control" name="new_branch" id="branch">
                    <%
                            if(list.get(0).getBranch().equals("CSE"))
                            {
                    %>
                                    <option value="CSE" selected="true">Computer Science And Engineering</option>
                                    <option value="ECE">Electronic And Communication Engineering</option>
                                </select>
                    <%
                            }
                            else
                            {
                    %>
                                    <option value="CSE" >Computer Science And Engineering</option>
                                    <option value="ECE" selected="true">Electronic And Communication Engineering</option>
                                </select>
                    <%
                            }
                    %>                
                                    
                            </div>
                        </div>
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="cno">Contact Number:</label>
                          <div class="col-sm-8">
                              <input type="text" name="new_cno" class="form-control" value="<% out.print(list.get(0).getCno()); %>" id="cno" placeholder="Enter Contact Number">
                          </div>
                        </div>
                        <div class="form-group"> 
                          <div class="col-sm-offset-2 col-sm-10">
                            <input type="hidden" name="old_email" class="form-control" value="<% out.print(list.get(0).getEmail()); %>">  
                            <button type="submit" name="Save" class="btn btn-info btn-lg">Save Changes</button>
                          </div>
                        </div>
                     </form>
            <%
                       }
                    }
                }
                catch(Exception ex)
                {
                    out.print(ex.toString());
                }
            %>    
        </div>    
    </body>
</html>
