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
public class Qbank 
{
    private int qid;
    private String ques,qsub,qdate,qby;
    public Qbank(){}

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
     * @return the ques
     */
    public String getQues() {
        return ques;
    }

    /**
     * @param ques the ques to set
     */
    public void setQues(String ques) {
        this.ques = ques;
    }

    /**
     * @return the qsub
     */
    public String getQsub() {
        return qsub;
    }

    /**
     * @param qsub the qsub to set
     */
    public void setQsub(String qsub) {
        this.qsub = qsub;
    }

    /**
     * @return the qdate
     */
    public String getQdate() {
        return qdate;
    }

    /**
     * @param qdate the qdate to set
     */
    public void setQdate(String qdate) {
        this.qdate = qdate;
    }

    /**
     * @return the qby
     */
    public String getQby() {
        return qby;
    }

    /**
     * @param qby the qby to set
     */
    public void setQby(String qby) {
        this.qby = qby;
    }
    
    public void insertRecord() throws Exception
    {
        DataManager.executeUpdate("insert into qbank values ("+qid+",'"+ques+"','"+qsub+"','"+qdate+"','"+qby+"')");
    }
    
    public static List<Qbank> getRecords(String qry) throws Exception
    {
        List<Qbank> list = new ArrayList<>();
        ResultSet rs= DataManager.executeQuery(qry);
        while(rs.next())
        {
            Qbank row = new Qbank();
            row.setQid(rs.getShort("qid"));
            row.setQues(rs.getString("ques"));
            row.setQsub(rs.getString("qsub"));
            row.setQdate(rs.getString("qdate"));
            row.setQby(rs.getString("qby"));
            list.add(row);
        }
        return list;
    }
    
    public static List<Qbank> getRecordsQsub(String qry) throws Exception
    {
        List<Qbank> list = new ArrayList<>();
        ResultSet rs= DataManager.executeQuery(qry);
        while(rs.next())
        {
            Qbank row = new Qbank();
            row.setQsub(rs.getString("qsub"));
            list.add(row);
        }
        return list;
    }
    
    
    
    public static int getNextQID() throws Exception
    {
        List<Qbank> list = getRecords("select * from qbank");
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
