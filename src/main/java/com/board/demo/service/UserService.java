package com.board.demo.service;

import com.board.demo.dao.UserDAO;
import com.board.demo.domain.LoginDTO;
import com.board.demo.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class UserService {
    @Autowired
    private UserDAO dao;

    public void register(UserVO userVO) throws Exception {
        dao.register(userVO);
    }

    public UserVO login(LoginDTO loginDTO) throws Exception {
        return dao.login(loginDTO);
    }

    public void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception{
        dao.keepLogin(userId,sessionId,sessionLimit);
    }

    public UserVO checkUserSessionKey(String value) throws Exception {
        return dao.checkUserSessionKey(value);
    }
}
