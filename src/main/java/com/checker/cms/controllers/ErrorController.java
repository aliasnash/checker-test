package com.checker.cms.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ErrorController {
    
    @RequestMapping(value = { "/404", "/400" })
    public ModelAndView error4x(HttpServletRequest request) {
        ModelAndView m = new ModelAndView("error");
        m.addObject("pageName", "error");
        m.addObject("detailMessage", "Страница не найдена [" + request.getAttribute("javax.servlet.error.exception") + "]");
        m.addObject("url", request.getAttribute("javax.servlet.forward.request_uri"));
        m.addObject("class", "");
        return m;
    }
    
    @RequestMapping(value = { "/500", "/500" })
    public ModelAndView error5x(HttpServletRequest request) {
        ModelAndView m = new ModelAndView("error");
        m.addObject("pageName", "error");
        m.addObject("detailMessage", "ошибка 500 [" + request.getAttribute("javax.servlet.error.exception") + "]");
        m.addObject("url", request.getAttribute("javax.servlet.forward.request_uri"));
        m.addObject("class", "");
        return m;
    }
    
}
