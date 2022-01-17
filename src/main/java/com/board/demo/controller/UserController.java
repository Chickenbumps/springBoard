package com.board.demo.controller;

import com.board.demo.domain.LoginDTO;
import com.board.demo.model.UserVO;
import com.board.demo.service.UserService;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService service;

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerGET() throws Exception {
        return "/user/register";
    }

    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public String registerPOST(UserVO userVO, RedirectAttributes redirectAttributes) throws Exception {
        String hashPW = BCrypt.hashpw(userVO.getUserPw(), BCrypt.gensalt());
        userVO.setUserPw(hashPW);
        service.register(userVO);
        redirectAttributes.addFlashAttribute("msg","registered");
        return "redirect:/user/login";
    }

    @RequestMapping(value="/login",method = RequestMethod.GET)
    public String loginGET() throws Exception {
        return "/user/login";
    }

    @RequestMapping(value = "/loginPost",method = RequestMethod.POST)
    public void loginPost(LoginDTO loginDTO, HttpSession httpSession, Model model) throws Exception {
        UserVO userVO = service.login(loginDTO);
        if(userVO == null || !BCrypt.checkpw(loginDTO.getUserPw(), userVO.getUserPw())){
            return;
        }
        model.addAttribute("user",userVO);
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception{
        HttpSession httpSession = (HttpSession)request.getSession();
        ModelMap modelMap = modelAndView.getModelMap();
        Object userVO = modelMap.get("user");

        if(userVO != null){
            httpSession.setAttribute("login",userVO);
            response.sendRedirect("/board/list");
        }
    }
}
