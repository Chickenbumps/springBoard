package com.board.demo.dao;

import com.board.demo.model.BoardVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BoardDAO {
    @Autowired
    private SqlSession sqlSession;

    public void create(BoardVO boardVO) throws Exception {
        sqlSession.insert("insert",boardVO);
    }

    public BoardVO read(int bno) throws Exception {
        return sqlSession.selectOne("select", bno);
    }

    public void update(BoardVO boardVO) throws  Exception {
        sqlSession.update("update",boardVO);
    }

    public void delete(int bno) throws Exception {
        sqlSession.delete("delete",bno);
    }

    public List<BoardVO> listAll() throws Exception {
        return sqlSession.selectList("listAll");
    }
}
