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
public class StudentManager
{
    private String name,branch,rno,cno,email;
    public StudentManager()
    {
    }

    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the branch
     */
    public String getBranch() {
        return branch;
    }

    /**
     * @param branch the branch to set
     */
    public void setBranch(String branch) {
        this.branch = branch;
    }

    /**
     * @return the rno
     */
    public String getRno() {
        return rno;
    }

    /**
     * @param rno the rno to set
     */
    public void setRno(String rno) {
        this.rno = rno;
    }

    /**
     * @return the cno
     */
    public String getCno() {
        return cno;
    }

    /**
     * @param cno the cno to set
     */
    public void setCno(String cno) {
        this.cno = cno;
    }
    
    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }
    
    public void insertRecord() throws Exception
    {
        DataManager.executeUpdate("insert into studentmaster values ('"+name+"','"+branch+"','"+rno+"','"+cno+"','"+email+"')");
    }
    
    
    public static List<StudentManager> getRecords(String qry) throws Exception
    {
        List<StudentManager> list = new ArrayList<>();
        ResultSet rs = DataManager.executeQuery(qry);
        while(rs.next())
        {
            StudentManager row = new StudentManager();
            row.setName(rs.getString("name"));
            row.setBranch(rs.getString("branch"));
            row.setRno(rs.getString("rno"));
            row.setCno(rs.getString("cno"));
            row.setEmail(rs.getString("email"));
            list.add(row);
        }
        return list;
    }
    
    public static String getName(String e1) throws Exception
    {
        String name="";
        ResultSet rs = DataManager.executeQuery("select * from studentmaster where email='"+e1+"'");
        if(rs.next())
        {
            name = rs.getString("name");
        }  
        return name;
    }
}
