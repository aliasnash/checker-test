package com.checker.cms.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TestController {
    
    @RequestMapping("/home")
    public ModelAndView home() {
        ModelAndView m = new ModelAndView("home");
        m.addObject("message", "hello Denis");
        return m;
    }
}
