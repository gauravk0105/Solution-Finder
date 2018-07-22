/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package includes;
import java.io.*;
import java.util.Iterator;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class FileBean
{

    public FileBean()
    {
    }

    public static void download(ServletContext application, HttpServletRequest request, HttpServletResponse response, String filename, String dirName) throws Exception
    {
        ServletOutputStream op = null;
        DataInputStream in = null;
        String filepath;
        File f;
        int length;
        String mimetype;
        byte bbuf[];
        try
        {
            if(filename == null)
            {
                return;
            }
        }
        catch(Exception ex)
        {
            return;
        }
        filepath = (new StringBuilder()).append(application.getRealPath("/")).append(dirName).append("/").append(filename).toString();
        f = new File(filepath);
        length = 0;
        op = response.getOutputStream();
        mimetype = application.getMimeType(filepath);
        response.setContentType(mimetype == null ? "application/octet-stream" : mimetype);
        response.setContentLength((int)f.length());
        response.setHeader("Content-Disposition", (new StringBuilder()).append("attachment;filename=\"").append(filename).append("\"").toString());
        bbuf = new byte[512];
        for(in = new DataInputStream(new FileInputStream(f)); in != null && (length = in.read(bbuf)) != -1;)
        {
            op.write(bbuf, 0, length);
        }

        in.close();
        op.flush();
        op.close();
    }

    public static void upload(ServletContext application, HttpServletRequest request, HttpServletResponse response, String dirName, String fileNames[], int maxSize, String fileType)
        throws IOException, ServletException
    {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        int maxPacketSize = 0x500000;
        String serverPath = application.getRealPath("");
        String tempPath = serverPath;
        String contentType = request.getContentType();
        if(contentType.indexOf("multipart/form-data") >= 0)
        {
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(maxPacketSize);
            factory.setRepository(new File(tempPath));
            ServletFileUpload upload = new ServletFileUpload(factory);
            upload.setSizeMax(maxSize);
            try
            {
                List fileItems = upload.parseRequest(request);
                Iterator i = fileItems.iterator();
                int num = 0;
                do
                {
                    if(!i.hasNext())
                    {
                        break;
                    }
                    FileItem fi = (FileItem)i.next();
                    if(!fi.isFormField())
                    {
                        String fieldName = fi.getFieldName();
                        String fileName = fi.getName();
                        boolean isInMemory = fi.isInMemory();
                        long sizeInBytes = fi.getSize();
                        String ext = fileName.substring(fileName.lastIndexOf("."));
                        if(fileType != null && !fileType.equals(ext))
                        {
                            out.println("<br><span style=color:red >File format not supported</span>");
                        } else
                        {
                            String path = null;
                            if(dirName != null)
                            {
                                path = (new StringBuilder()).append(serverPath).append("\\").append(dirName).toString();
                            } else
                            {
                                path = serverPath;
                            }
                            if(fileNames == null)
                            {
                                File file = new File((new StringBuilder()).append(path).append("\\").append(fileName).toString());
                                fi.write(file);
                                out.println((new StringBuilder()).append("<br><span style=color:green >Uploaded Filename: ").append(fileName).append("</span>").toString());
                            } else
                            {
                                File file = new File((new StringBuilder()).append(path).append("\\").append(fileNames[num]).toString());
                                fi.write(file);
                               // out.println((new StringBuilder()).append("<br><span style=color:green >Uploaded Filename: ").append(fileNames[num]).append("</span>").toString());
                            }
                            num++;
                        }
                    }
                } while(true);
            }
            catch(Exception ex)
            {
                out.println((new StringBuilder()).append("ERROR:").append(ex.toString()).toString());
            }
        }
    }
}
