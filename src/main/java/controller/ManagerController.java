package controller;

import entity.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import service.AdminService;

import javax.servlet.http.HttpSession;

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
    @RequestMapping(value = "/sumbitSearch")
    public String sumbitSearch(String  num ,String mName ,String  phone,Integer page,Integer limit){
        return adminService.sumbitSearch(num,mName,phone,page,limit);
    }

    @RequestMapping(value ="/transaction")
    public String transaction(ModelMap modelMap,Integer id){
        modelMap.put("item",adminService.getMemberByID(id));
        return "manager/transactionRecord";
    }

    @ResponseBody
    @RequestMapping(value = "/getTransactionDetail")
    public String getTransactionDetail(Integer id,Integer page,Integer limit){
        return adminService.transactionDetail(id,page,limit);
    }

    @RequestMapping(value = "/toTransaction")
    public String toTransaction(ModelMap modelMap,Integer memberId){
        modelMap.put("mId",memberId);
        return "manager/transaction";
    }

    @ResponseBody
    @RequestMapping(value = "/submitRecord",produces={"text/html;charset=UTF-8;","application/json;"})
    public String submitRecord(String open,Integer price,String remarks,Integer mId){
        return adminService.submitRecord(open,price,remarks,mId);
    }


}

