package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.AdminService;

@Controller
@RequestMapping("admin")
public class ManagerController {

    @Autowired
    AdminService adminService;

    @RequestMapping("/index")
    public String managerIndex(){
        return "manager/index";
    }

    @RequestMapping("/addMember")
    public String addMember(){
        return "manager/addMember";
    }

    @ResponseBody
    @RequestMapping(value = "/submitMember",produces={"text/html;charset=UTF-8;","application/json;"})
    public String submitMember(String  memberNum ,String userName ,String  phoneNum,String sex,String balance,String birthday,String remarks){
        return adminService.submitMember(memberNum , userName ,  phoneNum, sex, balance, birthday, remarks);
    }

    @ResponseBody
    @RequestMapping(value = "/motifyMember",produces={"text/html;charset=UTF-8;","application/json;"})
    public String motifyMember(String  memberNum ,String userName ,String  phoneNum,String sex,String balance,String birthday,String remarks){
        return adminService.submitMember(memberNum , userName ,  phoneNum, sex, balance, birthday, remarks);
    }

    @RequestMapping(value = "/seeMember",produces={"text/html;charset=UTF-8;","application/json;"})
    public String seeMember(){
        return "manager/seeMember";
    }
    @ResponseBody
    @RequestMapping(value = "/sumbitSearch",produces={"text/html;charset=UTF-8;","application/json;"})
    public String sumbitSearch(String  num ,String mName ,String  phone){
        return adminService.sumbitSearch(num,mName,phone);
    }

}

