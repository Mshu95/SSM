package utilssm;

import entity.Member;
import entity.Record;
import mapper.AdminMapper;
import mapper.MemberMapper;
import mapper.RecordMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChangeMoney {
    @Autowired
     AdminMapper adminMapper;
    @Autowired
     MemberMapper memberMapper;
    @Autowired
     RecordMapper recordMapper;


}
