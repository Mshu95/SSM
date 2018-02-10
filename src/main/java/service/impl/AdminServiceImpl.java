package service.impl;

import com.alibaba.fastjson.JSON;
import entity.*;
import mapper.AdminMapper;
import mapper.MemberMapper;
import mapper.RecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import service.AdminService;
import utilssm.ChangeMoney;
import javax.servlet.http.HttpSession;
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
        pages.setCurrentPage(page);

        if (id != null) {
            total = recordMapper.countByMember(id);
            pages.setTotalNumber(total);
        }
        pages.setDbNumber(limit);

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
                Record record = new Record();
                record.setTime(new Date());
                if ("consume".equals(open)) {
                    record.setPay(-price);
                    Integer Consumptionsum=member.getConsumptionsum()==null?0:member.getConsumptionsum();
                    member.setConsumptionsum(Consumptionsum+price);
                } else if ("recharge".equals(open)) {
                    record.setPay(price);
                }
                record.setRemarks(remarks);
                record.setMemberid(mid);
                record.setBalance(member.getBalance());
                recordMapper.insert(record);
                memberMapper.updateByPrimaryKeySelective(member);
            }

        }catch (Exception e){
            System.out.println(e);
            return "交易异常";
        }
        return "交易成功";

    }

    @Override
    public String motifyRecord(Integer open_pay, String open_remark, Integer currentRecordId) {
        Record record = recordMapper.selectByPrimaryKey(currentRecordId);
        if(changeMoneyByRecord(currentRecordId,open_pay)==1){
            record.setPay(open_pay);
            record.setRemarks(open_remark);
            int result_r = recordMapper.updateByPrimaryKey(record);
            if(result_r==1){
                return "修改成功";
            }
        }
        return "修改失败";
    }

    @Override
    public Integer delRecord(Integer rId) {
       Record  record =  recordMapper.selectByPrimaryKey(rId);
       try {
           Member member = memberMapper.selectByPrimaryKey(record.getMemberid());
           member.setBalance(member.getBalance()-record.getPay());
           memberMapper.updateByPrimaryKey(member);
           return recordMapper.deleteByPrimaryKey(rId);
       }catch (Exception e){
           return 0;
       }
    }

    public   Integer changeMoneyByRecord(Integer rId,Integer changeMoney){
        try{
            Record record = recordMapper.selectByPrimaryKey(rId);
            Integer memberId = record.getMemberid();
            Member member  = memberMapper.selectByPrimaryKey(memberId);
            member.setBalance(member.getBalance()+changeMoney-record.getPay());
            if(record.getPay()<0&&changeMoney+record.getPay()<0){
                if(changeMoney>0){
                    member.setConsumptionsum(member.getConsumptionsum()+(changeMoney+record.getPay()));
                }else{
                    member.setConsumptionsum(member.getConsumptionsum()+(record.getPay()-changeMoney));
                }
            }
            memberMapper.updateByPrimaryKey(member);
            return 1;
        }catch (Exception e ){
            System.out.println(e);
            return 0;
        }
    }
}
