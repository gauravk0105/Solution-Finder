<%@page import="includes.DataManager"%>
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
        <title>JSP Page</title>
    </head>
    <body>
        <%
            try{
                if(request.getParameter("Save")!=null)
                {
                    String old_email=request.getParameter("old_email");

                    String new_name=request.getParameter("new_name");
                    String new_email=request.getParameter("new_email");
                    String new_rno=request.getParameter("new_rno");
                    String new_branch=request.getParameter("new_branch");
                    String new_cno=request.getParameter("new_cno");

                    int n1=DataManager.executeUpdate("update studentmaster set name='"+new_name+"', branch='"+new_branch+"',rno='"+new_rno+"',cno='"+new_cno+"',email='"+new_email+"' where email='"+old_email+"'");
                    int n2=DataManager.executeUpdate("update loginmaster set email='"+new_email+"' where email='"+old_email+"'");
                    if(n1==0)
                    {
        %>
                        <h3>You not Updated Anything</h3>
                        <a href="adminconsole.jsp">Home</a>
        <%
                    }
                    else
                    {
                        if(n1==1)
                            {
        %>
                                <h3>Updated Successfully</h3>
                        <a href="adminconsole.jsp">Home</a>
        <%
                            }

                    }
                }
            }   
            catch(Exception ex)
            {
                out.print(ex.toString());
            }
        %>
    </body>
</html>
