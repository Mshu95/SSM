package service;

import entity.Member;

import javax.servlet.http.HttpSession;

public interface AdminService {
    String charckLogin(String name, String passWord, HttpSession session);
    String submitMember(String  memberNum ,String userName ,String  phoneNum,String sex,String balance,String birthday,String remarks);
    String sumbitSearch(String num, String mName, String phone,Integer page,Integer limit);
    String transactionDetail(Integer id,Integer page,Integer limit);
    Member getMemberByID(Integer mId);
    String  submitRecord(String open,Integer price,String remarks,Integer mid);
    String  motifyRecord(Integer open_pay,String open_remark,Integer currentRecordId);
    }
