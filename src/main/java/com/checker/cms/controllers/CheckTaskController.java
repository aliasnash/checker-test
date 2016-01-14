package com.checker.cms.controllers;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.BooleanUtils;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CheckService;
import com.checker.core.dao.service.CityService;
import com.checker.core.dao.service.MainService;
import com.checker.core.dao.service.MarketPointService;
import com.checker.core.dao.service.UserService;
import com.checker.core.entity.City;
import com.checker.core.entity.MarketPoint;
import com.checker.core.entity.TaskArticle;
import com.checker.core.entity.TaskArticleFail;
import com.checker.core.entity.User;
import com.checker.core.enums.TaskStatus;
import com.checker.core.utilz.CoreSettings;
import com.checker.core.utilz.PagerUtilz;
import com.checker.core.utilz.Transformer;

@Slf4j
@Controller
@RequestMapping("taskcheck")
public class CheckTaskController {
    
    @Resource
    private Transformer        transformer;
    @Resource
    private MarketPointService marketPointService;
    @Resource
    private CityService        cityService;
    @Resource
    private UserService        userService;
    
    @Resource
    private PagerUtilz         pagerUtilz;
    @Resource
    private CheckService       checkService;
    @Resource
    private MainService        mainService;
    @Resource
    private CoreSettings       coreSettings;
    
    private Integer            idCompany     = 1;
    
    private Integer            recordsOnPage = 3;
    
    @RequestMapping("list")
    public ModelAndView tasksCheckList(HttpSession session, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        Integer idUserCheckSaved = (Integer) session.getAttribute("idUserCheckSaved");
        Integer idCityCheckSaved = (Integer) session.getAttribute("idCityCheckSaved");
        Long idMarketPointCheckSaved = (Long) session.getAttribute("idMarketPointCheckSaved");
        String checkTaskCreateDate = (String) session.getAttribute("checkTaskCreateDate");
        
        log.info("#TasksCheckList GET method(idCompany:" + idCompany + ",page:" + page + ",idUserSaved:" + idUserCheckSaved + ",idCitySaved:" + idCityCheckSaved + ",idMarketPointSaved:" + idMarketPointCheckSaved + ",taskCreateDate:"
                + checkTaskCreateDate + ")#");
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        Map<String, Collection<City>> cityMap = transformer.doCityTransformer(cityService.findCitiesByIdCompany(idCompany));
        Map<String, Collection<MarketPoint>> marketPointMap;
        if (idCityCheckSaved != null)
            marketPointMap = transformer.doMarketTransformer(marketPointService.findAllMarketPointByIdCompanyAndIdCity(idCompany, idCityCheckSaved));
        else
            marketPointMap = Collections.emptyMap();
        LocalDate dateTaskCreate = StringUtils.isNotEmpty(checkTaskCreateDate) ? LocalDate.parse(checkTaskCreateDate) : null;
        
        Long recordsCount = checkService.countAllTaskArticleByIdCompanyAndStatusAndFilterParams(idCompany, TaskStatus.CHECK, idUserCheckSaved, idCityCheckSaved, idMarketPointCheckSaved, dateTaskCreate);
        Integer pageCount = pagerUtilz.getPageCount(recordsCount, recordsOnPage);
        page = pagerUtilz.getPage(page, pageCount);
        
        List<TaskArticle> taskArticleCheckList = checkService.findAllTaskArticleByIdCompanyAndStatusAndFilterParams(idCompany, TaskStatus.CHECK, idUserCheckSaved, idCityCheckSaved, idMarketPointCheckSaved, dateTaskCreate, page, recordsOnPage);
        
        ModelAndView m = new ModelAndView("taskcheck");
        m.addObject("pageName", "taskcheck");
        m.addObject("taskArticleCheckList", taskArticleCheckList);
        m.addObject("rootUrl", coreSettings.getRootUrlPhoto());
        m.addObject("userList", userList);
        m.addObject("cityMap", cityMap);
        m.addObject("marketPointMap", marketPointMap);
        m.addObject("recordsCount", recordsCount);
        m.addObject("pageCount", pageCount);
        m.addObject("page", page);
        
        return m;
    }
    
    @RequestMapping(value = "list", method = RequestMethod.POST)
    public String tasksCheckList(HttpSession session, @RequestParam(value = "filter_user_id") Integer idUserCheckSaved, @RequestParam(value = "filter_city_id") Integer idCityCheckSaved,
            @RequestParam(value = "filter_market_point_id", required = false) Long idMarketPointCheckSaved, @RequestParam(value = "filtered_task_create_date") String checkTaskCreateDate) {
        log.info("#TasksCheckList POST method(idCompany:" + idCompany + ",idUserSaved:" + idUserCheckSaved + ",idCitySaved:" + idCityCheckSaved + ",idMarketPointSaved:" + idMarketPointCheckSaved + ",taskCreateDate:" + checkTaskCreateDate + ")#");
        session.setAttribute("idUserCheckSaved", idUserCheckSaved);
        session.setAttribute("idCityCheckSaved", idCityCheckSaved);
        session.setAttribute("idMarketPointCheckSaved", idMarketPointCheckSaved);
        session.setAttribute("checkTaskCreateDate", checkTaskCreateDate);
        return "redirect:/taskcheck/list";
    }
    
    @RequestMapping(value = "reset")
    public String taskCheckReset(HttpSession session) {
        log.info("#TaskCheckReset method(idCompany:" + idCompany + ")#");
        session.removeAttribute("idUserCheckSaved");
        session.removeAttribute("idCityCheckSaved");
        session.removeAttribute("idMarketPointCheckSaved");
        session.removeAttribute("checkTaskCreateDate");
        return "redirect:/taskcheck/list";
    }
    
    @RequestMapping(value = "fail/new", method = RequestMethod.POST)
    public String tasksCheckFail(@RequestParam("id") Long idTaskArticle, @RequestParam("fail-description") String description, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TasksCheckFail method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ",description:" + description + ",page:" + page + ")#");
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
        return "redirect:/taskcheck/list?page=" + page;
    }
    
    @RequestMapping(value = "complete/{id}")
    public String tasksCheckComplete(@PathVariable("id") Long idTaskArticle, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TasksCheckComplete method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ",page:" + page + ")#");
        if (idTaskArticle != null && idTaskArticle > 0) {
            TaskArticle taskArticle = checkService.findTaskArticleByIdAndIdCompany(idCompany, idTaskArticle);
            if (taskArticle != null) {
                taskArticle.setTaskStatus(TaskStatus.COMPLETED);
                taskArticle.setDateUpdate(DateTime.now());
                mainService.update(taskArticle);
            }
        }
        return "redirect:/taskcheck/list?page=" + page;
    }
    
    @RequestMapping(value = "correct", method = RequestMethod.POST)
    public String tasksCheckCorrect(@RequestParam("id") Long idTaskArticle, @RequestParam("check-task-price") Double price, @RequestParam("check-task-weight") String weight,
            @RequestParam(value = "check-task-availability", required = false) Boolean availability, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TasksCheckCorrect method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ",price:" + price + ",weight:" + weight + ",availability:" + availability + ",page:" + page + ")#");
        if (idTaskArticle != null && idTaskArticle > 0 && price != null) {
            TaskArticle taskArticle = checkService.findTaskArticleByIdAndIdCompany(idCompany, idTaskArticle);
            if (taskArticle != null) {
                taskArticle.setPrice(price);
                taskArticle.setWeight(weight);
                taskArticle.setAvailability(BooleanUtils.isTrue(availability));
                taskArticle.setDateUpdate(DateTime.now());
                mainService.update(taskArticle);
            }
        }
        return "redirect:/taskcheck/list?page=" + page;
    }
}
