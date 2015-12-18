package com.checker.cms.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorController {
    
    @RequestMapping(value = { "/404", "/400" })
    public ModelAndView error(HttpServletRequest request) {
        ModelAndView m = new ModelAndView("error");
        m.addObject("pageName", "error");
        m.addObject("detailMessage", "Страница не найдена");
        m.addObject("url", request.getAttribute("javax.servlet.forward.request_uri"));
        m.addObject("class", "");
        return m;
    }
    
}
