package com.board.demo.service;

import com.board.demo.dao.UserDAO;
import com.board.demo.domain.LoginDTO;
import com.board.demo.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Date;

@Service
public class UserService implements UserDetailsService {
    @Autowired
    private UserDAO dao;

    public void register(UserVO userVO) throws Exception {
        dao.register(userVO);
    }

    public void keepLogin(String userId, String sessionId, Date sessionLimit) throws Exception{
        dao.keepLogin(userId,sessionId,sessionLimit);
    }

    public UserVO checkUserSessionKey(String value) throws Exception {
        return dao.checkUserSessionKey(value);
    }

    public UserVO login(String username) throws Exception{
        return dao.login(username);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        try {
           UserVO userVO = dao.login(username);
           if(userVO != null){
               return userVO;
           }else{
               return null;
           }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
