package com.checker.cms.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice
public class ExceptionHandlingAdvice {
    
    @ExceptionHandler
    public ModelAndView handleDefault(Exception e) {
        ModelAndView m = new ModelAndView("error");
        log.error("", e);
        m.addObject("detailMessage", e.getMessage());
        m.addObject("class", e.getClass());
        return m;
    }
    
}
