<%@page import="includes.DataManager"%>
<%@page import="includes.Photo"%>
<%@page import="includes.FileBean"%>
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
    
    DataManager.executeUpdate("delete from photos where email='"+e1+"'");
    String filename=e1+".jpg";
    FileBean.upload(application, request, response, "./photos/", new String[]{filename}, 1024*1024*5, null);
    Photo row = new Photo();
    row.setEmail(e1);
    row.setPhoto(filename);
    row.insertRecord();
    response.sendRedirect("studentconsole.jsp");
    return;
%>