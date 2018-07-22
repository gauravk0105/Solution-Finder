package includes;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;
/**
 *
 * @author Gaurav
 */
public class DataManager 
{
    public static int executeUpdate(String qry) throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/solutionfinder","root","root");
        Statement st = con.createStatement();
        int rs = st.executeUpdate(qry);
        return rs;
    }
    public static ResultSet executeQuery(String qry) throws Exception
    {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/solutionfinder","root","root");
        Statement st = con.createStatement();
        return st.executeQuery(qry);
    }
        public static String getDdmmyyyy(java.util.Date date)
    {
        String str = "";
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(date.getTime());
        str = cal.get(Calendar.DATE)+"/"+(cal.get(Calendar.MONTH)+1)+"/"+cal.get(Calendar.YEAR);
        return str;
    }
    
    public static String getYyyymmdd(java.util.Date dt)
    {
        String str="";
        java.util.Calendar cal=java.util.Calendar.getInstance();
        cal.setTimeInMillis(dt.getTime());
        str=cal.get(Calendar.YEAR)+"-"+(cal.get(Calendar.MONTH)+1)+"-"+cal.get(Calendar.DATE);
        return str;
    }
}
