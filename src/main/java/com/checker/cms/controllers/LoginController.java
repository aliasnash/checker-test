package com.checker.cms.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {
    
    @RequestMapping("login")
    public ModelAndView login() {
        log.info("#Login method FUCK()#");
        ModelAndView m = new ModelAndView("login");
        // m.addObject("pageName", "login");
        return m;
    }
    
    @RequestMapping("logout")
    public ModelAndView logout() {
        log.info("#Logout method FUCK()#");
        ModelAndView m = new ModelAndView("login");
        m.addObject("failed", true);
        // m.addObject("pageName", "login");
        return m;
    }
    
}
