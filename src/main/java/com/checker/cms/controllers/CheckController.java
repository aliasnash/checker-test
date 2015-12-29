package com.checker.cms.controllers;

import java.util.List;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CheckService;
import com.checker.core.dao.service.MainService;
import com.checker.core.entity.TaskArticle;
import com.checker.core.entity.TaskArticleFail;
import com.checker.core.enums.TaskStatus;
import com.checker.core.utilz.CoreSettings;

@Slf4j
@Controller
@RequestMapping("taskcheck")
public class CheckController {
    
    @Resource
    private CheckService checkService;
    @Resource
    private MainService  mainService;
    @Resource
    private CoreSettings coreSettings;
    
    private Integer      idCompany = 1;
    
    private Integer      pageSize  = 1;
    
    @RequestMapping("list")
    public ModelAndView tasksCheckList(@RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TasksCheckList method(idCompany:" + idCompany + ",page:" + page + ")#");
        if (page < 1)
            page = 1;
        List<TaskArticle> taskArticleCheckList = checkService.findTaskArticleByIdCompanyAndStatus(idCompany, TaskStatus.CHECK, page, pageSize);
        ModelAndView m = new ModelAndView("taskcheck");
        m.addObject("pageName", "taskcheck");
        m.addObject("taskArticleCheckList", taskArticleCheckList);
        m.addObject("rootUrl", coreSettings.getRootUrlPhoto());
        m.addObject("pageCount", 15 / 3);
        m.addObject("page", page);
        
        return m;
    }
    
    @RequestMapping(value = "fail/new", method = RequestMethod.POST)
    public String tasksCheckFail(@RequestParam("id") Long idTaskArticle, @RequestParam("fail-description") String description) {
        log.info("#TasksCheckFail method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ",description:" + description + ")#");
        if (StringUtils.isNotEmpty(description)) {
            if (idTaskArticle != null && idTaskArticle > 0) {
                TaskArticle taskArticle = checkService.findTaskArticleByIdAndIdCompany(idCompany, idTaskArticle);
                if (taskArticle != null) {
                    taskArticle.setTaskStatus(TaskStatus.FAIL);
                    taskArticle.setDateUpdate(DateTime.now());
                    mainService.update(taskArticle);
                    
                    TaskArticleFail taskArticleFail = new TaskArticleFail();
                    taskArticleFail.setIdTasksArticle(taskArticle.getId());
                    taskArticleFail.setDescription(description);
                    taskArticleFail.setDateAdded(DateTime.now());
                    mainService.save(taskArticleFail);
                }
            }
        }
        return "redirect:/taskcheck/list";
    }
    
    @RequestMapping(value = "complete/{id}")
    public String tasksCheckComplete(@PathVariable("id") Long idTaskArticle) {
        log.info("#TasksCheckComplete method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ")#");
        if (idTaskArticle != null && idTaskArticle > 0) {
            TaskArticle taskArticle = checkService.findTaskArticleByIdAndIdCompany(idCompany, idTaskArticle);
            if (taskArticle != null) {
                taskArticle.setTaskStatus(TaskStatus.COMPLETED);
                taskArticle.setDateUpdate(DateTime.now());
                mainService.update(taskArticle);
            }
        }
        return "redirect:/taskcheck/list";
    }
    
    @RequestMapping(value = "correct", method = RequestMethod.POST)
    public String tasksCheckCorrect(@RequestParam("id") Long idTaskArticle, @RequestParam("price") Double price) {
        log.info("#TasksCheckCorrect method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ",price:" + price + ")#");
        if (idTaskArticle != null && idTaskArticle > 0 && price != null) {
            TaskArticle taskArticle = checkService.findTaskArticleByIdAndIdCompany(idCompany, idTaskArticle);
            if (taskArticle != null) {
                taskArticle.setPrice(price);
                taskArticle.setDateUpdate(DateTime.now());
                mainService.update(taskArticle);
            }
        }
        return "redirect:/taskcheck/list";
    }
    
}
