<%@page import="java.util.List"%>
<%@page import="includes.LoginMaster"%>
<%
    try{
        if(request.getParameter("login")!=null)
        {
            String email = request.getParameter("email");
            String pwd = request.getParameter("pwd");
                
            List<LoginMaster> list = LoginMaster.getRecords("select * from loginmaster where email='"+email+"' and pwd='"+pwd+"'");
            if(list.size()==0 || list==null)
            {
                response.sendRedirect("LoginError.jsp");
                return;
            }
            else
            {
                session.setAttribute("ses_email",list.get(0).getEmail());
                session.setAttribute("ses_type", list.get(0).getUsertype());
                session.setMaxInactiveInterval(150000);
                if(list.get(0).getUsertype().equals("stud"))
                {
                    response.sendRedirect("studentconsole.jsp");
                    return;
                }
                else
                {
                    if(list.get(0).getUsertype().equals("admin"))
                    {
                        response.sendRedirect("adminconsole.jsp");
                        return;
                    }
                }
            }
        }
    }
    catch(Exception ex)
    {
        out.print(ex.toString());
    }
%>