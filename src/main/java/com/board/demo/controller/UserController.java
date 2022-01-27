package com.board.demo.controller;

import com.board.demo.domain.LoginDTO;
import com.board.demo.model.UserVO;
import com.board.demo.service.UserService;
import org.apache.catalina.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

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
    public void loginPost(LoginDTO loginDTO, HttpSession httpSession, Model model,HttpServletRequest request) throws Exception {
        UserVO userVO = service.login(loginDTO);
        System.out.println("USERVO:"+ userVO.toString());
        System.out.println("LOGINDTO:"+loginDTO.toString());
        System.out.println("BCRYPT:"+BCrypt.checkpw(loginDTO.getPassword(),userVO.getUserPw()));
        if(userVO == null || !BCrypt.checkpw(loginDTO.getPassword(), userVO.getUserPw())){
            return;
        }
        model.addAttribute("user",userVO);

        // 로그인 유지
        if(loginDTO.isUseCookie()){
            int limit = 60 * 60 * 24;
            Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * limit));
            service.keepLogin(userVO.getUserId(),httpSession.getId(),sessionLimit);
        }
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession httpSession) throws Exception {
        Object object = httpSession.getAttribute("login");
        if(object != null){
            UserVO userVO = (UserVO)object;
            httpSession.removeAttribute("login");
            httpSession.invalidate();
            Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
            if(loginCookie != null){
                loginCookie.setPath("/");
                loginCookie.setMaxAge(0);
                response.addCookie(loginCookie);
                service.keepLogin(userVO.getUserId(),"none",new Date());
            }
        }
        return "/user/logout";
    }
}
