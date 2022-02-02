package com.board.demo.dao;

import com.board.demo.domain.LoginDTO;
import com.board.demo.model.UserVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Repository
public class UserDAO {
    @Autowired
    private SqlSession sqlSession;

    public void register(UserVO userVO) throws Exception{
        sqlSession.insert("register",userVO);
    }

    public UserVO login(String username) throws Exception{
        return sqlSession.selectOne("login",username);
    }

    // 로그인 유지
    public void keepLogin(String username, String sessionId, Date sessionLimit) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("username",username);
        map.put("sessionId",sessionId);
        map.put("sessionLimit",sessionLimit);

        sqlSession.update("keepLogin",map);
    }

    // 세션키 검증
    public UserVO checkUserSessionKey(String value) throws Exception {
        return sqlSession.selectOne("checkUserSessionKey",value);
    }
}
