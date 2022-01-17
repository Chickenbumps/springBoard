package com.board.demo.service;

import com.board.demo.dao.UserDAO;
import com.board.demo.domain.LoginDTO;
import com.board.demo.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
