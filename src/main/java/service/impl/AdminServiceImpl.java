package service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.sun.tracing.dtrace.Attributes;
import entity.Admin;
import entity.Member;
import entity.Record;
import mapper.AdminMapper;
import mapper.MemberMapper;
import mapper.RecordMapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import service.AdminService;

import javax.servlet.http.HttpSession;
import java.awt.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.DEFAULT, timeout = 5)
@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    AdminMapper adminMapper;
    @Autowired
    MemberMapper memberMapper;
    @Autowired
    RecordMapper recordMapper;

    public String charckLogin(String name, String passWord, HttpSession session) {
        Admin admin;
        try {
            admin = adminMapper.selectByName(name);
        } catch (Exception e) {
            System.out.println(e);
            return "登陆异常";
        }
        if (admin == null) {
            return "用户名不存在";
        } else {
            if (passWord.equals(admin.getPassword())) {
                session.setAttribute("adminName", name);
                return "登录成功";
            } else {
                return "密码错误";
            }
        }
    }

    public String submitMember(String memberNum, String userName, String phoneNum, String sex, String balance, String birthday, String remarks) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Member member;
        Integer blan;
        try {
            member = memberMapper.selectByNumber(memberNum);
            if (member == null) {
                member = new Member();
            } else {
                return "卡号已存在！";
            }
            try {
                blan = Integer.parseInt(balance);
                member.setMembernumber(memberNum);
                member.setPhonenumber(phoneNum);
                member.setSex(sex);
                member.setBalance(blan);
                member.setMembername(userName);
                member.setRegistdate(new Date());
            } catch (Exception e) {
                System.out.println(e);
                return "输入的首充格式不正确";
            }
            try {
                Date birth = format.parse(birthday);
                member.setBirthdate(birth);
            } catch (Exception e) {
                e.printStackTrace();
                return "输入的生日不合法";
            }
            member.setRemarks(remarks);
            try {
                memberMapper.insert(member);
                Record record = new Record();
                record.setMemberid(memberMapper.selectByNumber(memberNum).getId());
                record.setPay(blan);
                record.setBalance(blan);
                record.setRemarks(remarks);
                recordMapper.insert(record);
            } catch (Exception e) {
                System.out.println(e);
                return "保存异常";
            }
        } catch (Exception e) {
            System.out.println("终极错误" + e);
        }

        return "添加成功";
    }

    public String sumbitSearch(String num, String mName, String phone) {
        Member member = new Member();
        if (num!=null){
            member.setMembernumber(num);
        }if(mName!=null){
            member.setMembername(mName);
        }if(member!=null){
            member.setPhonenumber(phone);
        }
        try{
            List<Member> list = memberMapper.selectBy(member);
            return JSONArray.parseArray(JSON.toJSONString(list)).toString();
        }catch (Exception e){
            System.out.println(e);
        }
        return "查找异常";
    }
}
