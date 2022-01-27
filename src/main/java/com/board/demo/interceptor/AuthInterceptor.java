package com.board.demo.interceptor;

import org.springframework.web.servlet.HandlerInterceptor;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthInterceptor implements HandlerInterceptor {

    private void saveDestination(HttpServletRequest request) {
        String uri = request.getRequestURI();
        String query = request.getQueryString();
        if(query == null || query.equals("null")){
            query = "";
        }else{
            query = "?" + query;
        }

        if(request.getMethod().equals("GET")){
            request.getSession().setAttribute("destination",uri+query);
        }
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession httpSession = (HttpSession) request.getSession();
        if(httpSession.getAttribute("login") == null){
            saveDestination(request);
            response.sendRedirect("/user/login");
            return false;
        }
        return true;
    }
}
