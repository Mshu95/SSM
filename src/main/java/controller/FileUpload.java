package controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUpload {
	@RequestMapping("/fileupload")
	public String upload(){
		return "fileupload";
	}
	
	
	
@RequestMapping("/uploadfile")
public String fileupload(@RequestParam MultipartFile uploadfile,HttpServletRequest request){
	try{
		String filename=uploadfile.getOriginalFilename();
		String targetDir=request.getSession().getServletContext().getRealPath("uploadfiles");
		File targetfile=new File(targetDir,filename);
		uploadfile.transferTo(targetfile);
//		InputStream is=file.getInputStream();
//		if(!file.getContentType().equals("application/pdf"))
//			return "typeror";
//		FileOutputStream os=new FileOutputStream(targetfile);
//		IOUtils.copy(is, os);
//		is.close();
//		os.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	return "succ";
}

@RequestMapping("/uploadfile2")
public String fileuploads(@RequestParam MultipartFile[] uploadfile,HttpServletRequest request){
	try{
		if(uploadfile!=null&&uploadfile.length>0){  
            //循环获取file数组中得文件  
            for(int i = 0;i<uploadfile.length;i++){  
                MultipartFile file = uploadfile[i];  
                if(file.getSize()==0){
                	continue;
                }
                //保存文件  
                String filename=file.getOriginalFilename();
        		String targetDir=request.getSession().getServletContext().getRealPath("uploadfiles");
        		File targetfile=new File(targetDir,filename);
        		file.transferTo(targetfile);
            }  
        }  
		
	}catch(Exception e){
		e.printStackTrace();
	}
	return "succ";
}

}
