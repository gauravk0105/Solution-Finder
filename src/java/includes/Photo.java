/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package includes;

import java.sql.ResultSet;

/**
 *
 * @author Dell
 */
public class Photo 
{
    private String email,photo;
    public Photo(){}

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
     * @return the photo
     */
    public String getPhoto() {
        return photo;
    }

    /**
     * @param photo the photo to set
     */
    public void setPhoto(String photo) {
        this.photo = photo;
    }
    
    public void insertRecord() throws Exception
    {
        DataManager.executeUpdate("insert into photos values('"+email+"','"+photo+"')");
    }
    
    public static String getPhotoId(String e1) throws Exception
    {
        String photoID="no photo";
        ResultSet rs = DataManager.executeQuery("select * from photos where email='"+e1+"'");
        if(rs.next())
        {
            photoID = rs.getString("photoid");
        }
        return photoID;
    }
}
