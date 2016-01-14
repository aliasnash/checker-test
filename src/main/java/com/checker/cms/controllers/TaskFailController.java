package com.checker.cms.controllers;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.LocalDate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CityService;
import com.checker.core.dao.service.MarketPointService;
import com.checker.core.dao.service.TaskFailService;
import com.checker.core.dao.service.UserService;
import com.checker.core.entity.City;
import com.checker.core.entity.MarketPoint;
import com.checker.core.entity.TaskArticleFail;
import com.checker.core.entity.User;
import com.checker.core.utilz.PagerUtilz;
import com.checker.core.utilz.Transformer;

@Slf4j
@Controller
@RequestMapping("tasksfail")
public class TaskFailController {
    
    @Resource
    private TaskFailService    taskFailService;
    
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
    
    private Integer            idCompany = 1;
    
    @RequestMapping("list")
    public ModelAndView tasksFailList(HttpSession session) {
        Integer idUserFailSaved = (Integer) session.getAttribute("idUserFailSaved");
        Integer idCityFailSaved = (Integer) session.getAttribute("idCityFailSaved");
        Long idMarketPointFailSaved = (Long) session.getAttribute("idMarketPointFailSaved");
        String failTaskCreateDate = (String) session.getAttribute("failTaskCreateDate");
        
        log.info("#TaskFailList GET method(idCompany:" + idCompany + ",idUserSaved:" + idUserFailSaved + ",idCitySaved:" + idCityFailSaved + ",idMarketPointSaved:" + idMarketPointFailSaved + ",taskCreateDate:" + failTaskCreateDate + ")#");
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        Map<String, Collection<City>> cityMap = transformer.doCityTransformer(cityService.findCitiesByIdCompany(idCompany));
        Map<String, Collection<MarketPoint>> marketPointMap;
        if (idCityFailSaved != null)
            marketPointMap = transformer.doMarketTransformer(marketPointService.findAllMarketPointByIdCompanyAndIdCity(idCompany, idCityFailSaved));
        else
            marketPointMap = Collections.emptyMap();
        LocalDate dateTaskCreate = StringUtils.isNotEmpty(failTaskCreateDate) ? LocalDate.parse(failTaskCreateDate) : null;
        
        List<TaskArticleFail> taskFailList = taskFailService.findAllTaskFailByIdCompanyAndFilterParams(idCompany, idUserFailSaved, idCityFailSaved, idMarketPointFailSaved, dateTaskCreate);
        
        ModelAndView m = new ModelAndView("taskfail");
        m.addObject("pageName", "taskfail");
        m.addObject("taskFailList", taskFailList);
        
        m.addObject("userList", userList);
        m.addObject("cityMap", cityMap);
        m.addObject("marketPointMap", marketPointMap);
        
        return m;
    }
    
    @RequestMapping(value = "list", method = RequestMethod.POST)
    public String tasksFailList(HttpSession session, @RequestParam(value = "filter_user_id") Integer idUserFailSaved, @RequestParam(value = "filter_city_id") Integer idCityFailSaved,
            @RequestParam(value = "filter_market_point_id", required = false) Long idMarketPointFailSaved, @RequestParam(value = "filtered_task_create_date") String failTaskCreateDate) {
        log.info("#TasksFailList POST method(idCompany:" + idCompany + ",idUserSaved:" + idUserFailSaved + ",idCitySaved:" + idCityFailSaved + ",idMarketPointSaved:" + idMarketPointFailSaved + ",taskCreateDate:" + failTaskCreateDate + ")#");
        session.setAttribute("idUserFailSaved", idUserFailSaved);
        session.setAttribute("idCityFailSaved", idCityFailSaved);
        session.setAttribute("idMarketPointFailSaved", idMarketPointFailSaved);
        session.setAttribute("failTaskCreateDate", failTaskCreateDate);
        return "redirect:/tasksfail/list";
    }
    
    @RequestMapping(value = "reset")
    public String taskFailReset(HttpSession session) {
        log.info("#TaskFailReset method(idCompany:" + idCompany + ")#");
        session.removeAttribute("idUserFailSaved");
        session.removeAttribute("idCityFailSaved");
        session.removeAttribute("idMarketPointFailSaved");
        session.removeAttribute("failTaskCreateDate");
        return "redirect:/tasksfail/list";
    }
}
