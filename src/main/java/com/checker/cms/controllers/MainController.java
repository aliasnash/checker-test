package com.checker.cms.controllers;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.checker.cms.tools.CheckerUserDetails;
import com.checker.core.dao.service.MainService;

@Slf4j
@Controller
public class MainController {
    
    @Resource
    private MainService checkerService;
    
    @RequestMapping(value = { "/", "/home" })
    public ModelAndView home(@AuthenticationPrincipal CheckerUserDetails user) {
        log.info("Home page !");
        
        System.out.println(user);
        
        ModelAndView m = new ModelAndView("home");
        m.addObject("pageName", "home");
        return m;
    }
}
