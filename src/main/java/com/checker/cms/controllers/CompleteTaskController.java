package com.checker.cms.controllers;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CheckService;
import com.checker.core.dao.service.MainService;
import com.checker.core.entity.TaskArticle;
import com.checker.core.enums.TaskStatus;
import com.checker.core.utilz.CoreSettings;
import com.checker.core.utilz.PagerUtilz;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("taskcomplete")
public class CompleteTaskController {
    
    @Resource
    private PagerUtilz   pagerUtilz;
    @Resource
    private CheckService checkService;
    @Resource
    private MainService  mainService;
    @Resource
    private CoreSettings coreSettings;
                         
    private Integer      idCompany     = 1;
                                       
    private Integer      recordsOnPage = 6;
                                       
    @RequestMapping("list")
    public ModelAndView tasksCompleteList(@RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TasksCompleteList method(idCompany:" + idCompany + ",page:" + page + ")#");
        Long recordsCount = checkService.countTaskArticleByIdCompanyAndStatus(idCompany, TaskStatus.COMPLETED);
        Integer pageCount = pagerUtilz.getPageCount(recordsCount, recordsOnPage);
        if (page > pageCount)
            page = pageCount;
        if (page < 1)
            page = 1;
            
        List<TaskArticle> taskArticleCompleteList = checkService.findTaskArticleByIdCompanyAndStatus(idCompany, TaskStatus.COMPLETED, page, recordsOnPage);
        
        ModelAndView m = new ModelAndView("taskcomplete");
        m.addObject("pageName", "taskcomplete");
        m.addObject("taskArticleCompleteList", taskArticleCompleteList);
        m.addObject("rootUrl", coreSettings.getRootUrlPhoto());
        m.addObject("pageCount", pageCount);
        m.addObject("page", page);
        
        return m;
    }
    
//    @RequestMapping(value = "fail/new", method = RequestMethod.POST)
//    public String tasksCheckFail(@RequestParam("id") Long idTaskArticle, @RequestParam("fail-description") String description, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
//        log.info("#TasksCheckFail method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ",description:" + description + ",page:" + page + ")#");
//        if (StringUtils.isNotEmpty(description)) {
//            if (idTaskArticle != null && idTaskArticle > 0) {
//                TaskArticle taskArticle = checkService.findTaskArticleByIdAndIdCompany(idCompany, idTaskArticle);
//                if (taskArticle != null) {
//                    taskArticle.setTaskStatus(TaskStatus.FAIL);
//                    taskArticle.setDateUpdate(DateTime.now());
//                    mainService.update(taskArticle);
//                    
//                    TaskArticleFail taskArticleFail = new TaskArticleFail();
//                    taskArticleFail.setIdTasksArticle(taskArticle.getId());
//                    taskArticleFail.setDescription(description);
//                    taskArticleFail.setDateAdded(DateTime.now());
//                    mainService.save(taskArticleFail);
//                }
//            }
//        }
//        return "redirect:/taskcheck/list?page=" + page;
//    }
//    
//    @RequestMapping(value = "complete/{id}")
//    public String tasksCheckComplete(@PathVariable("id") Long idTaskArticle, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
//        log.info("#TasksCheckComplete method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ",page:" + page + ")#");
//        if (idTaskArticle != null && idTaskArticle > 0) {
//            TaskArticle taskArticle = checkService.findTaskArticleByIdAndIdCompany(idCompany, idTaskArticle);
//            if (taskArticle != null) {
//                taskArticle.setTaskStatus(TaskStatus.COMPLETED);
//                taskArticle.setDateUpdate(DateTime.now());
//                mainService.update(taskArticle);
//            }
//        }
//        return "redirect:/taskcheck/list?page=" + page;
//    }
//    
//    @RequestMapping(value = "correct", method = RequestMethod.POST)
//    public String tasksCheckCorrect(@RequestParam("id") Long idTaskArticle, @RequestParam("price") Double price, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
//        log.info("#TasksCheckCorrect method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ",price:" + price + ",page:" + page + ")#");
//        if (idTaskArticle != null && idTaskArticle > 0 && price != null) {
//            TaskArticle taskArticle = checkService.findTaskArticleByIdAndIdCompany(idCompany, idTaskArticle);
//            if (taskArticle != null) {
//                taskArticle.setPrice(price);
//                taskArticle.setDateUpdate(DateTime.now());
//                mainService.update(taskArticle);
//            }
//        }
//        return "redirect:/taskcheck/list?page=" + page;
//    }
    
}
