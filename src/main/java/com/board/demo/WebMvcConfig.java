package com.board.demo;

import com.board.demo.interceptor.AuthInterceptor;
import com.board.demo.interceptor.KeepLoginInterceptor;
import com.board.demo.interceptor.LoginAfterInterceptor;
import com.board.demo.interceptor.LoginInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/user/loginPost") // 해당 경로에 접근하기 전에 인터셉터가 가로챈다.
                .excludePathPatterns("/boards"); // 해당 경로는 인터셉터가 가로채지 않는다.
        registry.addInterceptor(new AuthInterceptor())
                .addPathPatterns("/board/write")
                .addPathPatterns("/board/update")
                .addPathPatterns("/board/delete");
        registry.addInterceptor(new KeepLoginInterceptor())
                .addPathPatterns("/**/");
        registry.addInterceptor(new LoginAfterInterceptor())
                .addPathPatterns("/user/login")
                .addPathPatterns("/user/register");
    }
}