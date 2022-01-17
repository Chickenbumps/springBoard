package com.board.demo.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception{
        HttpSession httpSession = (HttpSession)request.getSession();
        ModelMap modelMap = modelAndView.getModelMap();
        Object userVO = modelMap.get("user");
        if(userVO != null){
            httpSession.setAttribute("login",userVO);
            if(request.getParameter("useCookie") != null){
                Cookie loginCookie = new Cookie("loginCookie",httpSession.getId());
                loginCookie.setPath("/board/list");
                loginCookie.setMaxAge(60*60*24);
                response.addCookie(loginCookie);
            }
            Object destination = httpSession.getAttribute("destination");
            response.sendRedirect(destination != null ? (String)destination : "/board/list");
        }
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession httpSession = (HttpSession)request.getSession();

        if(httpSession.getAttribute("login")!= null){
            httpSession.removeAttribute("login");
        }
        return true;
    }
}
