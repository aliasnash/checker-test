package com.checker.cms.exception;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class ExceptionHandlingAdvice {
    
    @ExceptionHandler
    public ModelAndView handleDefault(HttpServletRequest request, Exception e) {
        log.error("", e);
        ModelAndView m = new ModelAndView("error");
        m.addObject("pageName", "error");
        m.addObject("detailMessage", e.getMessage());
        m.addObject("class", e.getClass());
        m.addObject("url", request.getRequestURI());
        m.addObject("stackTrace", e.getStackTrace());
        return m;
    }
    
}
