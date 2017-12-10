package service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.sun.org.apache.regexp.internal.RE;
import com.sun.tracing.dtrace.Attributes;
import entity.*;
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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
                record.setTime(new Date());
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

    public String sumbitSearch(String num, String mName, String phone, Integer page, Integer limit) {
        Member member = new Member();
        if (num != null) {
            member.setMembernumber(num);
        }
        if (mName != null) {
            member.setMembername(mName);
        }
        if (member != null) {
            member.setPhonenumber(phone);
        }
        try {

            Pages pagess = new Pages();
            pagess.setCurrentPage(page);
            Integer count = memberMapper.countByMember(member);
            pagess.setTotalNumber(count);
            pagess.setDbNumber(limit);

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("msgs", member);
            map.put("pages", pagess);
            List<Member> list = memberMapper.selectByLike(map);
            Page pages = new Page();
            pages.setCode(0);
            pages.setCount(pagess.getTotalNumber());
            pages.setMsg("hi");
            pages.setData(list);
            return JSON.toJSONString(pages);
        } catch (Exception e) {
            System.out.println(e);
        }
        return "查找异常";
    }

    @Override
    public String transactionDetail(Integer id, Integer page, Integer limit) {
        Pages pages = new Pages();
        Integer total;
        if (id != null) {
            total = recordMapper.countByMember(id);
            pages.setTotalPage(total);
        }
        pages.setDbNumber(limit);
        pages.setCurrentPage(page);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("msgs", id);
        map.put("pages", pages);
        try {
            List<Record> list = recordMapper.getByMember(map);
            Page pagess = new Page();
            pagess.setCode(0);
            pagess.setCount(pages.getTotalNumber());
            pagess.setMsg("hi");
            pagess.setData(list);
            return JSON.toJSONString(pagess);
        } catch (Exception e) {
            System.out.println(e);
        }

        return "";
    }

    @Override
    public Member getMemberByID(Integer mId) {
        return memberMapper.selectByPrimaryKey(mId);
    }

    @Override
    public String submitRecord(String open, Integer price, String remarks, Integer mid) {
        try {
            Member member = memberMapper.selectByPrimaryKey(mid);
            if ("consume".equals(open)) {
                member.setBalance(member.getBalance() - price);
            } else if ("recharge".equals(open)) {
                member.setBalance(member.getBalance() + price);
            }else{
                return "交易异常";
            }
            if(member.getBalance()<0){
                return "余额不足，拒绝交易！";
            }else{
                memberMapper.updateByPrimaryKeySelective(member);
                Record record = new Record();
                record.setTime(new Date());
                if ("consume".equals(open)) {
                    record.setPay(-price);
                } else if ("recharge".equals(open)) {
                    record.setPay(price);
                }
                record.setRemarks(remarks);
                record.setMemberid(mid);
                record.setBalance(member.getBalance());
                recordMapper.insert(record);
            }

        }catch (Exception e){
            return "交易异常";
        }
        return "交易成功";

    }
}
