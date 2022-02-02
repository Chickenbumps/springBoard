package com.board.demo.domain;

import com.board.demo.model.UserVO;
import com.board.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import java.util.Collection;

public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Autowired
    UserService userService;

    @Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException  {
        Collection<? extends SimpleGrantedAuthority> authorities;
        String username = authentication.getName();
        String password = (String) authentication.getCredentials();

        UserVO userVO = (UserVO) userService.loadUserByUsername(username);
        authorities = (Collection<? extends SimpleGrantedAuthority>) userVO.getAuthorities();
        System.out.println("Authority:"+ authorities);
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        if(!bCryptPasswordEncoder.matches(password,userVO.getPassword())){
            throw  new BadCredentialsException("잘못된 비밀번호 입니다.");
        }
        return new UsernamePasswordAuthenticationToken(userVO, userVO.getPassword(),authorities);
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
