<%
    String e1=(String)session.getAttribute("ses_email");
    if(e1==null)
    {
        response.sendRedirect("AuthError.jsp");
        return;
    }
    session.removeAttribute("ses_email");
    session.removeAttribute("ses_type");
    response.sendRedirect("index.jsp");
    return;
%>