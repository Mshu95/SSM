package controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import service.AdminService;

import java.io.IOException;

@Controller
@RequestMapping("login")
public class Login {


	@Autowired
	AdminService adminService;

	@RequestMapping("/index")
	public String login(){
		return "login/index";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession httpSession){
		httpSession.removeAttribute("adminName");
		return "login";
	}

	@ResponseBody
	@RequestMapping(value = "/checkLogin",produces={"text/html;charset=UTF-8;","application/json;"})
	public String checklogin(String userName, String passWord, HttpSession session, HttpServletResponse response){
		String result = adminService.charckLogin(userName,passWord,session);
		return result;
	}
  }
