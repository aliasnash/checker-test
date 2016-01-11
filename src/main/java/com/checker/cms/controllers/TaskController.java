package com.checker.cms.controllers;

import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CityService;
import com.checker.core.dao.service.MainService;
import com.checker.core.dao.service.MarketPointService;
import com.checker.core.dao.service.TaskService;
import com.checker.core.dao.service.TemplateService;
import com.checker.core.dao.service.UserService;
import com.checker.core.entity.City;
import com.checker.core.entity.MarketPoint;
import com.checker.core.entity.Task;
import com.checker.core.entity.TaskArticle;
import com.checker.core.entity.TaskTemplate;
import com.checker.core.entity.User;
import com.checker.core.enums.TaskStatus;
import com.checker.core.model.TupleHolder;
import com.checker.core.result.task.TaskUploadResult;
import com.checker.core.utilz.JsonTaskTransformer;
import com.checker.core.utilz.PagerUtilz;
import com.checker.core.utilz.Transformer;

@Slf4j
@Controller
@RequestMapping("tasks")
public class TaskController {
    
    @Resource
    private Transformer         transformer;
    @Resource
    private MarketPointService  marketPointService;
    @Resource
    private CityService         cityService;
    
    @Resource
    private TaskService         taskService;
    @Resource
    private MainService         checkerService;
    @Resource
    private UserService         userService;
    @Resource
    private TemplateService     templateService;
    @Resource
    private JsonTaskTransformer jsonTaskTransformer;
    @Resource
    private PagerUtilz          pagerUtilz;
    
    private Integer             idCompany     = 1;
    
    private Integer             recordsOnPage = 15;
    
    @RequestMapping("list")
    public ModelAndView tasksList(HttpSession session, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        Integer idUserTaskSaved = (Integer) session.getAttribute("idUserTaskSaved");
        Integer idCityTaskSaved = (Integer) session.getAttribute("idCityTaskSaved");
        Long idMarketPointTaskSaved = (Long) session.getAttribute("idMarketPointTaskSaved");
        Integer idTaskStatusSaved = (Integer) session.getAttribute("idTaskStatusSaved");
        Long idTaskTemplateSaved = (Long) session.getAttribute("idTaskTemplateSaved");
        
        log.info("#TasksList GET method(idCompany:" + idCompany + ",page:" + page + ",idUserSaved:" + idUserTaskSaved + ",idCitySaved:" + idCityTaskSaved + ",idMarketPointSaved:" + idMarketPointTaskSaved + ",idTaskStatusSaved:" + idTaskStatusSaved
                + ",idTaskTemplateSaved:" + idTaskTemplateSaved + ")#");
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        List<TaskTemplate> templateList = templateService.findTemplatesByIdCompany(idCompany, null, null);
        Map<String, Collection<City>> cityMap = transformer.doCityTransformer(cityService.findCitiesByIdCompany(idCompany));
        Map<String, Collection<MarketPoint>> marketPointMap;
        if (idCityTaskSaved != null)
            marketPointMap = transformer.doMarketTransformer(marketPointService.findOtherMarketPointByIdCompanyAndIdCity(idCompany, idCityTaskSaved));
        else
            marketPointMap = Collections.emptyMap();
        
        Long recordsCount = taskService.countOtherTaskByIdCompanyAndFilterParams(idCompany, idUserTaskSaved, idCityTaskSaved, idMarketPointTaskSaved, idTaskStatusSaved, idTaskTemplateSaved);
        Integer pageCount = pagerUtilz.getPageCount(recordsCount, recordsOnPage);
        page = pagerUtilz.getPage(page, pageCount);
        
        List<Task> taskList = taskService.findOtherTaskByIdCompanyAndFilterParams(idCompany, idUserTaskSaved, idCityTaskSaved, idMarketPointTaskSaved, idTaskStatusSaved, idTaskTemplateSaved, page, recordsOnPage);
        
        ModelAndView m = new ModelAndView("task");
        m.addObject("pageName", "task");
        m.addObject("userList", userList);
        m.addObject("taskStatusList", TaskStatus.list());
        m.addObject("cityMap", cityMap);
        m.addObject("marketPointMap", marketPointMap);
        m.addObject("templateList", templateList);
        m.addObject("taskList", taskList);
        m.addObject("recordsCount", recordsCount);
        m.addObject("pageCount", pageCount);
        m.addObject("page", page);
        return m;
    }
    
    @RequestMapping(value = "list", method = RequestMethod.POST)
    public String tasksList(HttpSession session, @RequestParam(value = "filter_user_id") Integer idUserTaskSaved, @RequestParam(value = "filter_city_id") Integer idCityTaskSaved,
            @RequestParam(value = "filter_market_point_id", required = false) Long idMarketPointTaskSaved, @RequestParam(value = "filter_task_status_id") Integer idTaskStatusSaved,
            @RequestParam(value = "filter_task_template_id") Long idTaskTemplateSaved) {
        log.info("#TasksList POST method(idCompany:" + idCompany + ",idUserSaved:" + idUserTaskSaved + ",idCitySaved:" + idCityTaskSaved + ",idMarketPointSaved:" + idMarketPointTaskSaved + ",idTaskStatusSaved:" + idTaskStatusSaved
                + ",idTaskTemplateSaved:" + idTaskTemplateSaved + ")#");
        session.setAttribute("idUserTaskSaved", idUserTaskSaved);
        session.setAttribute("idCityTaskSaved", idCityTaskSaved);
        session.setAttribute("idMarketPointTaskSaved", idMarketPointTaskSaved);
        session.setAttribute("idTaskStatusSaved", idTaskStatusSaved);
        session.setAttribute("idTaskTemplateSaved", idTaskTemplateSaved);
        return "redirect:/tasks/list";
    }
    
    @RequestMapping(value = "reset")
    public String taskReset(HttpSession session) {
        log.info("#TaskReset method(idCompany:" + idCompany + ")#");
        session.removeAttribute("idUserTaskSaved");
        session.removeAttribute("idCityTaskSaved");
        session.removeAttribute("idMarketPointTaskSaved");
        session.removeAttribute("idTaskStatusSaved");
        session.removeAttribute("idTaskTemplateSaved");
        return "redirect:/tasks/list";
    }
    
    @RequestMapping("{id}/delete")
    public String taskDelete(@PathVariable("id") Long idTask, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TaskDelete method(idCompany:" + idCompany + ",idTask:" + idTask + ",page:" + page + ")#");
        if (idTask != null && idTask > 0)
            taskService.deleteTask(idCompany, idTask);
        return "redirect:/tasks/list?page=" + page;
    }
    
    @RequestMapping(value = "assign", method = RequestMethod.POST)
    public String taskAssign(@RequestParam("id") Long idTask, @RequestParam("iduser") Integer idUser, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TaskAssign method(idCompany:" + idCompany + ",idTask:" + idTask + ",idUser:" + idUser + ",page:" + page + ")#");
        if (idUser != null && idUser > 0 && idTask != null && idTask > 0) {
            taskService.assignTask(idCompany, idTask, idUser);
        }
        return "redirect:/tasks/list?page=" + page;
    }
    
    @RequestMapping("{id}/articles/list")
    public ModelAndView taskArticleList(@PathVariable("id") Long idTask) {
        log.info("#TaskArticleList method(idCompany:" + idCompany + ",idTask:" + idTask + ")#");
        
        Task task = taskService.findTaskByIdAndIdCompany(idCompany, idTask);
        List<TaskArticle> taskArticle = taskService.findTaskArticleByIdCompanyAndIdTask(idCompany, idTask);
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
        List<TaskTemplate> templateList = templateService.findTemplatesByIdCompany(idCompany, null, null);
        Map<String, Collection<MarketPoint>> marketPointMap = transformer.doMarketTransformer(marketPointService.findAllMarketPointByIdCompany(idCompany));
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
            @RequestParam(value = "task_name", required = false) String taskName, @RequestParam(value = "useuser", required = false) Boolean useUser, @RequestParam(value = "user_id", required = false) Integer idUser) throws IllegalStateException,
            IOException {
        log.info("#TaskAddDone method(idCompany:" + idCompany + ",idTemplate:" + idTemplate + ",idMarketPointList:" + idMarketPointList + ",taskName:" + taskName + ",useUser:" + useUser + ",idUser:" + idUser + ")#");
        TaskUploadResult results = new TaskUploadResult();
        
        if (idTemplate == null)
            results.templateError();
        if (StringUtils.isEmpty(taskName))
            results.taskNameError();
        if (idMarketPointList == null || idMarketPointList.size() == 0)
            results.marketError();
        if (BooleanUtils.isTrue(useUser) && idUser == null)
            results.userError();
        
        if (!results.isHasError()) {
            results.setTaskStatus(taskService.saveTaskAndArticles(idCompany, idTemplate, idUser, idMarketPointList, taskName));
        }
        
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        List<TaskTemplate> templateList = templateService.findTemplatesByIdCompany(idCompany, null, null);
        Map<String, Collection<MarketPoint>> marketPointMap = transformer.doMarketTransformer(marketPointService.findAllMarketPointByIdCompany(idCompany));
        
        ModelAndView m = new ModelAndView("taskadd");
        m.addObject("pageName", "task");
        m.addObject("userList", userList);
        m.addObject("templateList", templateList);
        m.addObject("marketPointMap", marketPointMap);
        m.addObject("results", results);
        return m;
    }
}
