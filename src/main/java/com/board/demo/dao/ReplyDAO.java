package com.board.demo.dao;

import com.board.demo.model.ReplyVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ReplyDAO {

    @Autowired
    private SqlSession sqlSession;

    public List<ReplyVO> list(int bno) throws Exception {
        return sqlSession.selectList("replyList",bno);
    }

    public void create(ReplyVO replyVO) throws Exception {
        sqlSession.insert("replyInsert",replyVO);
    }

    public void update(ReplyVO replyVO) throws Exception {
        sqlSession.update("replyUpdate",replyVO);
    }

    public void delete(int rno) throws Exception{
        sqlSession.delete("replyDelete",rno);
    }
}
