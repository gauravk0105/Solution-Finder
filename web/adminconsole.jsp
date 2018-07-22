<%@page import="java.util.List"%>
<%@page import="includes.StudentManager"%>
<%@page import="includes.LoginMaster"%>
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
        <title>Admin Console</title>
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
               $('#logout').tooltip(); 
               
            });
        </script>
                
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
                <li class="active">Home</li>
            </ul>
            <ul class="nav nav-pills nav-justified">
                <li class="active"><a href="#" data-target="#home" data-toggle="pill">Home</a></li>
                <li><a href="#" data-target="#addS" data-toggle="pill">Add Student</a></li>
                <li><a href="#" data-target="#showS" data-toggle="pill">Show Student</a></li>
                <li><a href="Logout.jsp" id="logout" data-toggle="tooltip" title="Are U Want To Logout?">Logout</a></li>
            </ul>
            
            <br/>
            <div class="tab-content">
                
                
                <div id="home" class="tab-pane fade in active">
                    <h2>Welcome To Admin Console</h2>
                </div>
                
                
                <div id="addS" class="tab-pane">
                    <h2 class="page-header text-uppercase text-warning">Add Student</h2>
                    <form class="form-horizontal" method="post" action="addStudent.jsp">
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="name">Name:</label>
                          <div class="col-sm-8">
                            <input type="text" name="sname" class="form-control" id="name" placeholder="Enter Name">
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="email">Email:</label>
                          <div class="col-sm-8">
                            <input type="email" name="email" class="form-control" id="email" placeholder="Enter email">
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="rno">Roll Number:</label>
                          <div class="col-sm-8">
                            <input type="text" name="rno" class="form-control" id="rno" placeholder="Enter Roll Number">
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="branch">Branch:</label>
                             <div class="col-sm-8">
                                <select class="form-control" name="branch" id="branch">
                                    <option value="CSE">Computer Science And Engineering</option>
                                    <option value="ECE">Electronic And Communication Engineering</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="cno">Contact Number:</label>
                          <div class="col-sm-8">
                            <input type="text" name="cno" class="form-control" id="cno" placeholder="Enter Contact Number">
                          </div>
                        </div>
                        <div class="form-group">
                          <label class=" text-info control-label col-sm-2" for="pwd">Password:</label>
                          <div class="col-sm-8"> 
                            <input type="password" name="pwd" class="form-control" id="pwd" placeholder="Enter password">
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="text-info control-label col-sm-2" for="con_pwd">Confirm Password:</label>
                          <div class="col-sm-8"> 
                            <input type="password" class="form-control" id="con_pwd" placeholder="Enter Confirm password">
                          </div>
                        </div>
                        <div class="form-group"> 
                          <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" name='add' class="btn btn-info btn-lg">Submit</button>
                          </div>
                        </div>
                     </form>
                </div>
                <div id="showS" class="tab-pane">
                    <h2 class="page-header text-uppercase text-warning">Show Students</h2>
                    <div class="row">
                        <div class="col-sm-3 pull-right">
                            <input class="form-control" id="myInput" type="text" placeholder="Search Student">
                        </div>
                    </div>
                    <br/>
                    <% 
                        List<StudentManager> list = StudentManager.getRecords("select * from studentmaster");
                        if(list.size()==0 || list==null)
                        {
                            // empty
                    %>
                    <h3>No Student Yet</h3>
                    <%
                        }
                        else
                        {
                    %>
                    <div class="table-responsive">
                        <table  class="table table-bordered  table-hover">
                            <thead>
                                <tr>
                                    <th class="text-uppercase text-center text-primary">
                                        Name
                                    </th>
                                    <th class="text-uppercase text-center text-primary">
                                        Branch
                                    </th>
                                    <th class="text-uppercase text-center text-primary">
                                        Roll Number
                                    </th>
                                    <th class="text-uppercase text-center text-primary">
                                        Contact Number
                                    </th>
                                    <th class="text-uppercase text-center text-primary">
                                        Email
                                    </th>
                                    <th class="text-uppercase text-center text-primary">
                                        Edit Option
                                    </th>
                                    <th class="text-uppercase text-center text-primary">
                                        Delete Option
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="myTable">
                    <%
                          for(int i=0;i<list.size();i++)
                            {
                    %>
                    <tr>
                        <td class="text-center text-info info"><% out.print(list.get(i).getName()); %></td>
                        <td class="text-center text-info danger"><% out.print(list.get(i).getBranch()); %></td>
                        <td class="text-center text-info info"><% out.print(list.get(i).getRno()); %></td>
                        <td class="text-center text-info danger"><% out.print(list.get(i).getCno()); %></td>
                        <td class="text-center text-info info"><% out.print(list.get(i).getEmail()); %></td>
                        <td class="text-center text-info warning"><a href="editStudent.jsp?email=<% out.print(list.get(i).getEmail()); %>" class="btn btn-default btn-warning"><span class="glyphicon glyphicon-edit">&nbsp;Edit</span></a></td>
                        <td class="text-center text-info success"><a href="deleteStudent.jsp?email=<% out.print(list.get(i).getEmail()); %>" class="btn btn-default btn-success"><span class="glyphicon glyphicon-remove">&nbsp;Delete</span></a></td>
                    </tr>
                    <%
                            }
                    %>
                            </tbody>
                        </table>
                    </div> 
                    <%
                        }
                    %>
                </div>
            </div>
            
        </div>
                <script>
$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });
});
</script>
    </body>
</html>
