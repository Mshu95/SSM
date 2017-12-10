package mapper;

import entity.Member;
import entity.Record;
import entity.RecordExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RecordMapper {
    int countByExample(RecordExample example);
    int countByMember(Integer memberId);

    int deleteByExample(RecordExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Record record);

    int insertSelective(Record record);

    List<Record> getByMember(Map<String,Object> map);

    List<Record> selectByExample(RecordExample example);

    Record selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Record record, @Param("example") RecordExample example);

    int updateByExample(@Param("record") Record record, @Param("example") RecordExample example);

    int updateByPrimaryKeySelective(Record record);

    int updateByPrimaryKey(Record record);
}