package com.board.demo.interceptor;

import com.board.demo.model.UserVO;
import com.board.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class KeepLoginInterceptor implements HandlerInterceptor {
    @Autowired
    private UserService service;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession httpSession = request.getSession();
        Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
        if(loginCookie != null){
            UserVO userVO = service.checkUserSessionKey(loginCookie.getValue());
            if(userVO != null){
                httpSession.setAttribute("login",userVO);
            }
        }
        return true;
    }
}
