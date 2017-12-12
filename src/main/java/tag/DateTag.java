package tag;
import javax.servlet.jsp.tagext.*;
import javax.servlet.jsp.*;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;

public class DateTag extends SimpleTagSupport   {
    private String date;
    public void setDate(String date) {
        this.date = date;
    }
    @Override
    public void doTag() throws JspException, IOException {
        SimpleDateFormat sdf1= new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
        SimpleDateFormat sdf2= new SimpleDateFormat("yyyy-MM-dd");
        String result = "";
        try {
            result =sdf2.format(sdf1.parse(date));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        getJspContext().getOut().write(result);
    }
}
