 <%@page import="includes.Qbank"%>
<%@page import="includes.Solution"%>
<%@page import="includes.StudentManager"%>
<%@page import="java.util.List"%>
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
                                            String q1=request.getParameter("qid");
                                            int q = Integer.parseInt(q1);
                                            List<Solution> lt = Solution.getRecords("select * from solutions where qid="+q+" order by solvedate desc");
                                            if(lt==null || lt.size()==0)
                                            {
                                        %>
                                        <h4>No Solution Yet.....</h4>
                                        <%        
                                            }
                                            else{
                                               for(int k=0;k<lt.size();k++)
                                                {
                                                    
                                        %>
                          <div class="media">
                            <div class="media-left">
                                <img src="images/img_avatar.png" class="media-object" alt="Avatar" style="width:60px"/>
                            </div>
                            <div class="media-body">
                                <h4 class="media-heading"><%out.print(StudentManager.getName(lt.get(k).getSolveby()));%>&nbsp;&nbsp;&nbsp;<small><i>Posted on <%out.print(lt.get(k).getSolvedate());%></i></small></h4>
                    <p><%out.print(lt.get(k).getSoln());%></p>
                            </div>
                            <hr/>
            </div>

                                        <%     
                                                }
                                            }        
                                        %>