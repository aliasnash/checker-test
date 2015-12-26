package com.checker.cms.controllers;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.BooleanUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.cms.task.TaskUploadResult;
import com.checker.core.dao.service.CheckerService;
import com.checker.core.dao.service.MarketPointService;
import com.checker.core.dao.service.TaskService;
import com.checker.core.dao.service.TemplateService;
import com.checker.core.dao.service.UserService;
import com.checker.core.entity.MarketPoint;
import com.checker.core.entity.Task;
import com.checker.core.entity.TaskArticle;
import com.checker.core.entity.TaskTemplate;
import com.checker.core.entity.TaskTemplateArticle;
import com.checker.core.entity.User;
import com.checker.core.enums.TaskStatus;
import com.checker.core.model.TupleHolder;
import com.checker.core.utilz.JsonTaskTransformer;
import com.checker.core.utilz.Transformer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("tasks")
public class TaskController {
    
    @Resource
    private Transformer         transformer;
    @Resource
    private MarketPointService  marketPointService;
                                
    @Resource
    private TaskService         taskService;
    @Resource
    private CheckerService      checkerService;
    @Resource
    private UserService         userService;
    @Resource
    private TemplateService     templateService;
    @Resource
    private JsonTaskTransformer jsonTaskTransformer;
                                
    private Integer             idCompany = 1;
                                          
    @RequestMapping("list")
    public ModelAndView tasksList() {
        log.info("#TasksList method(idCompany:" + idCompany + ")#");
        List<Task> taskList = taskService.findTaskByIdCompany(idCompany);
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        ModelAndView m = new ModelAndView("task");
        m.addObject("pageName", "task");
        m.addObject("userList", userList);
        m.addObject("taskList", taskList);
        return m;
    }
    
    @RequestMapping("{id}/delete")
    public String taskDelete(@PathVariable("id") Long idTask) {
        log.info("#TaskDelete method(idCompany:" + idCompany + ",idTask:" + idTask + ")#");
        if (idTask != null && idTask > 0)
            taskService.deleteTask(idCompany, idTask);
        return "redirect:/tasks/list";
    }
    
    @RequestMapping(value = "assign", method = RequestMethod.POST)
    public String taskAssign(@RequestParam("id") Long idTask, @RequestParam("iduser") Integer idUser) {
        log.info("#TaskAssign method(idCompany:" + idCompany + ",idTask:" + idTask + ",idUser:" + idUser + ")#");
        
        if (idUser != null && idUser > 0 && idTask != null && idTask > 0) {
            taskService.assignTask(idCompany, idTask, idUser);
        }
        
        return "redirect:/tasks/list";
    }
    
    @RequestMapping("{id}/articles/list")
    public ModelAndView taskArticleList(@PathVariable("id") Long idTask) {
        log.info("#TaskArticleList method(idCompany:" + idCompany + ",idTask:" + idTask + ")#");
        
        Task task = taskService.findTaskByIdAndIdCompany(idCompany, idTask);
        List<TaskArticle> taskArticle = taskService.findTaskArticleByIdCompanyAndIdTemplate(idCompany, idTask);
        TupleHolder<String, List<Long>> result = jsonTaskTransformer.process(taskArticle);
        
        ModelAndView m = new ModelAndView("taskarticles");
        m.addObject("pageName", "task");
        m.addObject("task", task);
        m.addObject("taskTree", result.getValue1());
        m.addObject("taskSelected", result.getValue2());
        return m;
    }
    
    @RequestMapping("add/form")
    public ModelAndView taskAddForm() {
        log.info("#TaskAddForm method(idCompany:" + idCompany + ")#");
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        List<TaskTemplate> templateList = templateService.findTemplatesByIdCompany(idCompany);
        Map<String, List<MarketPoint>> marketPointMap = transformer.doMarketTransformer(marketPointService.findMarketPointByIdCompany(idCompany));
        ModelAndView m = new ModelAndView("taskadd");
        m.addObject("pageName", "task");
        m.addObject("userList", userList);
        m.addObject("templateList", templateList);
        m.addObject("marketPointMap", marketPointMap);
        return m;
    }
    
    @RequestMapping(value = "upload", method = RequestMethod.GET)
    public String taskAddDone() throws IllegalStateException, IOException {
        log.info("#TaskAddDone method(idCompany:" + idCompany + ")#");
        return "redirect:/tasks/add/form";
    }
    
    @RequestMapping(value = "upload", method = RequestMethod.POST)
    public ModelAndView taskAddDone(@RequestParam(value = "template_id", required = false) Long idTemplate, @RequestParam(value = "marketpoint_id[]", required = false) List<Long> idMarketPointList,
            @RequestParam(value = "useuser", required = false) Boolean useUser, @RequestParam(value = "user_id", required = false) Integer idUser) throws IllegalStateException, IOException {
        log.info("#TaskAddDone method(idCompany:" + idCompany + ",idTemplate:" + idTemplate + ",idMarketPointList:" + idMarketPointList + ",useUser:" + useUser + ",idUser:" + idUser + ")#");
        TaskUploadResult results = new TaskUploadResult();
        
        if (idTemplate == null)
            results.templateError();
        if (idMarketPointList == null || idMarketPointList.size() == 0)
            results.marketError();
        if (BooleanUtils.isTrue(useUser) && idUser == null)
            results.userError();
            
        if (!results.isHasError()) {
            User user = null;
            List<TaskTemplateArticle> templateList = templateService.findArticleTemplatesByIdCompanyAndIdTemplate(idCompany, idTemplate);
            List<MarketPoint> marketPointList = marketPointService.findMarketPointByIdCompanyAndIds(idCompany, idMarketPointList);
            if (idUser != null) {
                user = userService.findUserByIdAndIdCompany(idCompany, idUser);
            }
            
            for (MarketPoint marketPoint : marketPointList) {
                Task task = new Task();
                task.setIdCompany(idCompany);
                task.setIdMarketPoint(marketPoint.getId());
                if (user == null) {
                    task.setTaskStatus(TaskStatus.ACTIVED);
                } else {
                    task.setTaskStatus(TaskStatus.ASSIGNED);
                    task.setIdUser(user.getId());
                }
                task.setCaption("Task:" + marketPoint.getMarket().getCaption() + " (" + marketPoint.getDescription() + ")");
                task.setDateAdded(DateTime.now());
                checkerService.save(task);
                
                for (TaskTemplateArticle template : templateList) {
                    TaskArticle taskArticle = new TaskArticle();
                    taskArticle.setIdTask(task.getId());
                    taskArticle.setIdArticle(template.getIdArticle());
                    taskArticle.setDateAdded(DateTime.now());
                    checkerService.save(taskArticle);
                }
            }
        }
        
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        List<TaskTemplate> templateList = templateService.findTemplatesByIdCompany(idCompany);
        Map<String, List<MarketPoint>> marketPointMap = transformer.doMarketTransformer(marketPointService.findMarketPointByIdCompany(idCompany));
        
        ModelAndView m = new ModelAndView("taskadd");
        m.addObject("pageName", "task");
        m.addObject("userList", userList);
        m.addObject("templateList", templateList);
        m.addObject("marketPointMap", marketPointMap);
        m.addObject("results", results);
        return m;
    }
}
