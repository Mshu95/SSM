package service;

import javax.servlet.http.HttpSession;

public interface AdminService {
    String charckLogin(String name, String passWord, HttpSession session);
    String submitMember(String  memberNum ,String userName ,String  phoneNum,String sex,String balance,String birthday,String remarks);
    }
