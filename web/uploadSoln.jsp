<%@page import="includes.DataManager"%>
<%@page import="includes.Solution"%>
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
    String soln = request.getParameter("soln");
    String hide =  request.getParameter("hide");
    
    Solution row = new Solution();
    row.setSid(Solution.getNextSID());
    row.setSolvedate(DataManager.getDdmmyyyy(new java.util.Date()));
    row.setQid(Integer.parseInt(hide));
    row.setSoln(soln);
    row.setSolveby(e1);
    row.insertRecord();
    
%>
<div class="alert alert-success alert-dismissible">
  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
  <strong>Success!</strong> Your Solution Uploaded Successfully..
</div>
<%
    
%>