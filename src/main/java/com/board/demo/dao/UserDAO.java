package com.board.demo.dao;

import com.board.demo.domain.LoginDTO;
import com.board.demo.model.UserVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class UserDAO {
    @Autowired
    private SqlSession sqlSession;

    public void register(UserVO userVO) throws Exception{
        sqlSession.insert("register",userVO);
    }

    public UserVO login(LoginDTO loginDTO) throws Exception{
        return sqlSession.selectOne("login",loginDTO);
    }
}
