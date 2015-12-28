package com.checker.cms.controllers;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.TaskFailService;
import com.checker.core.entity.TaskArticleFail;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("tasksfail")
public class TaskFailController {
    
    @Resource
    private TaskFailService taskFailService;
                            
    private Integer         idCompany = 1;
                                      
    @RequestMapping("list")
    public ModelAndView taskFailList() {
        log.info("#TaskFailList method(idCompany:" + idCompany + ")#");
        List<TaskArticleFail> taskFailList = taskFailService.findTaskFailByIdCompany(idCompany);
        ModelAndView m = new ModelAndView("taskfail");
        m.addObject("pageName", "taskfail");
        m.addObject("taskFailList", taskFailList);
        return m;
    }
}
