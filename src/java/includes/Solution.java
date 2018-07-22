/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package includes;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Dell
 */
public class Solution
{
    private int sid,qid;
    private String solvedate,solveby,soln;
    
    public Solution(){}

    /**
     * @return the sid
     */
    public int getSid() {
        return sid;
    }

    /**
     * @param sid the sid to set
     */
    public void setSid(int sid) {
        this.sid = sid;
    }

    /**
     * @return the qid
     */
    public int getQid() {
        return qid;
    }

    /**
     * @param qid the qid to set
     */
    public void setQid(int qid) {
        this.qid = qid;
    }

    /**
     * @return the solvedate
     */
    public String getSolvedate() {
        return solvedate;
    }

    /**
     * @param solvedate the solvedate to set
     */
    public void setSolvedate(String solvedate) {
        this.solvedate = solvedate;
    }

    /**
     * @return the solveby
     */
    public String getSolveby() {
        return solveby;
    }

    /**
     * @param solveby the solveby to set
     */
    public void setSolveby(String solveby) {
        this.solveby = solveby;
    }

    /**
     * @return the soln
     */
    public String getSoln() {
        return soln;
    }

    /**
     * @param soln the soln to set
     */
    public void setSoln(String soln) {
        this.soln = soln;
    }
    
    public void insertRecord() throws Exception
    {
        DataManager.executeUpdate("insert into solutions values("+sid+","+qid+",'"+solvedate+"','"+solveby+"','"+soln+"')");
    }
    
    public static List<Solution> getRecords(String qry) throws Exception
    {
        List<Solution> list= new ArrayList<>();
        ResultSet rs =  DataManager.executeQuery(qry);
        while(rs.next())
        {
            Solution row = new Solution();
            row.setSid(rs.getShort("sid"));
            row.setQid(rs.getShort("qid"));
            row.setSolvedate(rs.getString("solvedate"));
            row.setSolveby(rs.getString("solveby"));
            row.setSoln(rs.getString("soln"));
            list.add(row);
        }
        return list;
    }
    
    
    
    public static int getNextSID() throws Exception
    {
        List<Solution> list = getRecords("select * from solutions");
        if(list.size()==0 || list==null)
        {
            return 1;
        }
        else
        {
            return list.size() + 1;
        }
    }
    
}
