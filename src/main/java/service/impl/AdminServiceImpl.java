package service.impl;

import entity.Admin;
import entity.Member;
import javafx.application.Application;
import mapper.AdminMapper;
import mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import service.AdminService;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, timeout = 5)
@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    public AdminMapper adminMapper;
    @Autowired
    public MemberMapper memberMapper;

    public String charckLogin(String name, String passWord , HttpSession session) {
        Admin admin;
        try{
            admin  = adminMapper.selectByName(name);
        }catch (Exception e){
            System.out.println(e);
            return "登陆异常";
        }
        if(admin == null) {
            return "用户名不存在";
        }else{
            if (passWord.equals(admin.getPassword())) {
                session.setAttribute("adminName",name);
                return "登录成功";
            } else {
                return "密码错误";
            }
        }
    }
    public String submitMember(String  memberNum ,String userName ,String phoneNum,String sex,String balance,String birthday,String remarks) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Member member =  new Member();
        try{
            int phone = Integer.parseInt("123456");
            System.out.println("phone++++"+phone);
            int blan = Integer.parseInt(balance);
            member.setMembernumber(memberNum);
            member.setPhonenumber(phone);
            member.setSex(sex);
            member.setBalance(blan);
        }catch (Exception e){
            System.out.println(e);
           return "输入的数字格式不正确";
        }
        try {
            Date birth = format.parse(birthday);
            member.setBirthdate(birth);
        } catch (ParseException e) {
            e.printStackTrace();
            return "输入的生日不合法";
        }
        member.setRemarks(remarks);
        try {
            memberMapper.insert(member);
        }catch (Exception e){
            System.out.println(e);
            return "保存异常";
        }
        return  "添加成功";
    }
}
