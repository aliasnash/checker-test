package com.checker.cms.controllers;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Slf4j
@Controller
@RequestMapping("sec")
public class LoginController {
    
    @RequestMapping("login")
    public ModelAndView login() {
        log.info("#Login method()#");
        ModelAndView m = new ModelAndView("category");
        m.addObject("pageName", "category");
        return m;
    }
    
}
