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
import com.checker.core.entity.User;
import com.checker.core.enums.TaskStatus;
import com.checker.core.utilz.CoreSettings;
import com.checker.core.utilz.PagerUtilz;
import com.checker.core.utilz.Transformer;

@Slf4j
@Controller
@RequestMapping("taskcomplete")
public class CompleteTaskController {
    
    @Resource
    private PagerUtilz         pagerUtilz;
    @Resource
    private CheckService       checkService;
    @Resource
    private MainService        mainService;
    @Resource
    private CoreSettings       coreSettings;
    @Resource
    private Transformer        transformer;
    @Resource
    private MarketPointService marketPointService;
    @Resource
    private CityService        cityService;
    @Resource
    private UserService        userService;
    
    private Integer            idCompany     = 1;
    
    private Integer            recordsOnPage = 9;
    
    @RequestMapping("list")
    public ModelAndView tasksCheckList(HttpSession session, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        Integer idUserCompleteSaved = (Integer) session.getAttribute("idUserCompleteSaved");
        Integer idCityCompleteSaved = (Integer) session.getAttribute("idCityCompleteSaved");
        Long idMarketPointCompleteSaved = (Long) session.getAttribute("idMarketPointCompleteSaved");
        String completeTaskCreateDate = (String) session.getAttribute("completeTaskCreateDate");
        
        log.info("#TasksCompleteList GET method(idCompany:" + idCompany + ",page:" + page + ",idUserSaved:" + idUserCompleteSaved + ",idCitySaved:" + idCityCompleteSaved + ",idMarketPointSaved:" + idMarketPointCompleteSaved + ",taskCreateDate:"
                + completeTaskCreateDate + ")#");
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        Map<String, Collection<City>> cityMap = transformer.doCityTransformer(cityService.findCitiesByIdCompany(idCompany));
        Map<String, Collection<MarketPoint>> marketPointMap;
        if (idCityCompleteSaved != null)
            marketPointMap = transformer.doMarketTransformer(marketPointService.findOtherMarketPointByIdCompanyAndIdCity(idCompany, idCityCompleteSaved));
        else
            marketPointMap = Collections.emptyMap();
        LocalDate dateTaskCreate = StringUtils.isNotEmpty(completeTaskCreateDate) ? LocalDate.parse(completeTaskCreateDate) : null;
        
        Long recordsCount = checkService.countOtherTaskArticleByIdCompanyAndStatus(idCompany, TaskStatus.COMPLETED, idUserCompleteSaved, idCityCompleteSaved, idMarketPointCompleteSaved, dateTaskCreate);
        Integer pageCount = pagerUtilz.getPageCount(recordsCount, recordsOnPage);
        page = pagerUtilz.getPage(page, pageCount);
        
        List<TaskArticle> taskArticleCompleteList = checkService.findOtherTaskArticleByIdCompanyAndStatusAndFilterParams(idCompany, TaskStatus.COMPLETED, idUserCompleteSaved, idCityCompleteSaved, idMarketPointCompleteSaved, dateTaskCreate, page,
                recordsOnPage);
        
        ModelAndView m = new ModelAndView("taskcomplete");
        m.addObject("pageName", "taskcomplete");
        m.addObject("taskArticleCompleteList", taskArticleCompleteList);
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
    public String tasksCompleteList(HttpSession session, @RequestParam(value = "filter_user_id") Integer idUserCompleteSaved, @RequestParam(value = "filter_city_id") Integer idCityCompleteSaved,
            @RequestParam(value = "filter_market_point_id", required = false) Long idMarketPointCompleteSaved, @RequestParam(value = "filtered_task_create_date") String completeTaskCreateDate) {
        log.info("#TasksCompleteList POST method(idCompany:" + idCompany + ",idUserSaved:" + idUserCompleteSaved + ",idCitySaved:" + idCityCompleteSaved + ",idMarketPointSaved:" + idMarketPointCompleteSaved + ",taskCreateDate:"
                + completeTaskCreateDate + ")#");
        session.setAttribute("idUserCompleteSaved", idUserCompleteSaved);
        session.setAttribute("idCityCompleteSaved", idCityCompleteSaved);
        session.setAttribute("idMarketPointCompleteSaved", idMarketPointCompleteSaved);
        session.setAttribute("completeTaskCreateDate", completeTaskCreateDate);
        return "redirect:/taskcomplete/list";
    }
    
    @RequestMapping(value = "reset")
    public String taskCompleteReset(HttpSession session) {
        log.info("#TaskCompleteReset method(idCompany:" + idCompany + ")#");
        session.removeAttribute("idUserCompleteSaved");
        session.removeAttribute("idCityCompleteSaved");
        session.removeAttribute("idMarketPointCompleteSaved");
        session.removeAttribute("completeTaskCreateDate");
        return "redirect:/taskcomplete/list";
    }
    
    @RequestMapping(value = "correct", method = RequestMethod.POST)
    public String tasksCompleteCorrect(@RequestParam("id") Long idTaskArticle, @RequestParam("complete-task-price") Double price, @RequestParam("complete-task-weight") String weight,
            @RequestParam(value = "complete-task-availability", required = false) Boolean availability, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TasksCompleteCorrect method(idCompany:" + idCompany + ",idTaskArticle:" + idTaskArticle + ",price:" + price + ",weight:" + weight + ",availability:" + availability + ",page:" + page + ")#");
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
        return "redirect:/taskcomplete/list?page=" + page;
    }
}
