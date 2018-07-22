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
                if(request.getParameter("email")!=null)
                {
                    String email = request.getParameter("email");
                    DataManager.executeUpdate("delete from studentmaster where email='"+email+"'");
                    DataManager.executeUpdate("delete from loginmaster where email='"+email+"'");
        %>
        <h3>Delete Successfully</h3>
        <a href="adminconsole.jsp">Home</a>
        <%
                }
                
            }
            catch(Exception ex)
            {
                out.print(ex.toString());
            }
        %>
    </body>
</html>
