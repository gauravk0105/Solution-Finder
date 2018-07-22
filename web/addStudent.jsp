<%@page import="includes.LoginMaster"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Student</title>
    </head>
    <body>
        <%
            try{
            if(request.getParameter("add")!=null)
                {
                    String name = request.getParameter("sname");
                    String email = request.getParameter("email");
                    String rno = request.getParameter("rno");
                    String branch = request.getParameter("branch");
                    String cno = request.getParameter("cno");
                    String pwd= request.getParameter("pwd");

                    StudentManager row = new StudentManager();
                    row.setBranch(branch);
                    row.setCno(cno);
                    row.setEmail(email);
                    row.setName(name);
                    row.setRno(rno);
                    row.insertRecord();
                    
                    LoginMaster rw = new LoginMaster();
                    rw.setEmail(email);
                    rw.setPwd(pwd);
                    rw.setUsertype("stud");
                    rw.insertRecord();
                    
        %>
                <h3>Success : </h3><h4>Data Saved</h4>
                <a href="adminconsole.jsp">Home</a>
        <%
                }
            }
            catch(Exception ex)
            {
                out.print(ex.toString());
        %>
                <a href="adminconsole.jsp">Home</a>
        <%    
            }
        %>
    </body>
</html>
