package com.checker.cms.controllers;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CheckerService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MainController {
    
    @Resource
    private CheckerService checkerService;
    
    @RequestMapping(value = { "/", "/home" })
    public ModelAndView home() {
        log.info("Home page !");
        ModelAndView m = new ModelAndView("home");
        m.addObject("pageName", "home");
        return m;
    }
    
    @RequestMapping("/report")
    public ModelAndView report() {
        log.info("Report page !");
        ModelAndView m = new ModelAndView("report");
        m.addObject("pageName", "report");
        return m;
    }
    
    @RequestMapping("/goods")
    public ModelAndView goods() {
        log.info("Goods page !");
        ModelAndView m = new ModelAndView("goods");
        m.addObject("pageName", "goods");
        return m;
    }
    
    @RequestMapping("/check")
    public ModelAndView check() {
        log.info("Check page !");
        ModelAndView m = new ModelAndView("home");
        m.addObject("pageName", "check");
        return m;
    }
    
    @RequestMapping("/tasks/list")
    public ModelAndView tasksList() {
        log.info("TtasksList page !");
        ModelAndView m = new ModelAndView("home");
        m.addObject("pageName", "tasks");
        return m;
    }
    
    @RequestMapping("/chains/list")
    public ModelAndView chainsList() {
        log.info("ChainsList page !");
        ModelAndView m = new ModelAndView("home");
        m.addObject("pageName", "chains");
        return m;
    }
    
    @RequestMapping("/users/list")
    public ModelAndView usersList() {
        log.info("UsersList page !");
        ModelAndView m = new ModelAndView("home");
        m.addObject("pageName", "users");
        return m;
    }
    
    @RequestMapping("/category/list")
    public ModelAndView categoryList() {
        log.info("CategoryList page !");
        ModelAndView m = new ModelAndView("home");
        m.addObject("pageName", "category");
        return m;
    }
    
    @RequestMapping("/exit")
    public ModelAndView exit() {
        log.info("exit page !");
        ModelAndView m = new ModelAndView("home");
        m.addObject("pageName", "home");
        return m;
    }
    // @RequestMapping(value = "/about", method = RequestMethod.POST)
    // public ModelAndView about(@RequestParam("data") String data) {
    // log.info("About page POST!");
    //
    // ModelAndView m = new ModelAndView("otherPage");
    // m.addObject("data", data);
    //
    // return m;
    // }
}
