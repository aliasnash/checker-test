package com.checker.cms.controllers;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.MainService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
    
    @Resource
    private MainService checkerService;
    
    @RequestMapping(value = { "/", "/home" })
    public ModelAndView home() {
        log.info("Home page !");
        
        ModelAndView m = new ModelAndView("home");
        m.addObject("pageName", "home");
        return m;
    }
    
    @RequestMapping(value = { "/photo" })
    public ModelAndView photo() {
        log.info("Photo page !");
        
        ModelAndView m = new ModelAndView("photo");
        m.addObject("pageName", "photo");
        return m;
    }
}
