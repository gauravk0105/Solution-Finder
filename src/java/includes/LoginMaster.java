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
public class LoginMaster 
{
    private String email,pwd,usertype;

    public LoginMaster() {
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

    /**
     * @return the pwd
     */
    public String getPwd() {
        return pwd;
    }

    /**
     * @param pwd the pwd to set
     */
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    /**
     * @return the usertype
     */
    public String getUsertype() {
        return usertype;
    }

    /**
     * @param usertype the usertype to set
     */
    public void setUsertype(String usertype) {
        this.usertype = usertype;
    }
    
    public void insertRecord() throws Exception
    {
        DataManager.executeUpdate("insert into loginmaster values('"+email+"','"+pwd+"','"+usertype+"')");
    }
    
    public static List<LoginMaster> getRecords(String qry) throws Exception
    {
        List<LoginMaster> list = new ArrayList<>();
        ResultSet rs = DataManager.executeQuery(qry);
        while(rs.next())
        {
            LoginMaster row = new LoginMaster();
            row.setEmail(rs.getString("email"));
            row.setPwd(rs.getString("pwd"));
            row.setUsertype(rs.getString("usertype"));
            list.add(row);
        }
        return list;
    }
}
