package com.checker.cms.controllers;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.LocalDate;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.checker.core.dao.service.CityService;
import com.checker.core.dao.service.MainService;
import com.checker.core.dao.service.MarketPointService;
import com.checker.core.dao.service.TaskService;
import com.checker.core.dao.service.TemplateService;
import com.checker.core.dao.service.UserService;
import com.checker.core.entity.City;
import com.checker.core.entity.MarketPoint;
import com.checker.core.entity.Task;
import com.checker.core.entity.TaskTemplate;
import com.checker.core.entity.User;
import com.checker.core.utilz.Transformer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@ResponseBody
@RequestMapping("ajax")
public class AjaxFunctions {
    
    @Resource
    private Transformer        transformer;
    @Resource
    private MarketPointService marketPointService;
    @Resource
    private CityService        cityService;
    @Resource
    private TemplateService    templateService;
    @Resource
    private TaskService        taskService;
    @Resource
    private MainService        checkerService;
    @Resource
    private UserService        userService;
                               
    private Integer            idCompany = 1;
                                         
    // http://localhost:9090/checker-cms/ajax/2/marketpoints
    
    @RequestMapping(value = "{idc}/marketpoints.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Collection<MarketPoint>> selectMarketPoint(@PathVariable("idc") Integer idCity) {
        log.info("#Ajax SelectMarketPoint method(idCompany:" + idCompany + ",idCity:" + idCity + ")#");
        
        Map<String, Collection<MarketPoint>> marketPointMap;
        if (idCity != null)
            marketPointMap = transformer.doMarketTransformer(marketPointService.findAllMarketPointByIdCompanyAndIdCity(idCompany, idCity));
        else
            marketPointMap = Collections.emptyMap();
            
        return marketPointMap;
    }
    
    @RequestMapping(value = "{id}/own/marketpoints.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<MarketPoint> selectOwnMarketPointsList(@PathVariable("id") Integer idCity) {
        log.info("#Ajax selectOwnMarketPointsList method(idCompany:" + idCompany + ",idCity:" + idCity + ")#");
        
        if (idCity != null)
            return marketPointService.findOwnMarketPointByIdCompanyAndIdCity(idCompany, idCity);
        else
            return Collections.emptyList();
    }
    
    @RequestMapping(value = "{id}/other/marketpoints.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<MarketPoint> selectOtherMarketPointsList(@PathVariable("id") Integer idCity) {
        log.info("#Ajax selectOtherMarketPointsList method(idCompany:" + idCompany + ",idCity:" + idCity + ")#");
        
        if (idCity != null)
            return marketPointService.findOtherMarketPointByIdCompanyAndIdCity(idCompany, idCity);
        else
            return Collections.emptyList();
    }
    
    @RequestMapping(value = "task/{date}/citiesbydate.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Collection<City>> selectCityTaskByDate(@PathVariable("date") String taskCreateDate) {
        log.info("#Ajax selectCityTaskByDate method(idCompany:" + idCompany + ",taskCreateDate:" + taskCreateDate + ")#");
        
        LocalDate taskDate = StringUtils.isNotEmpty(taskCreateDate) ? LocalDate.parse(taskCreateDate) : null;
        
        Map<String, Collection<City>> cityMap;
        if (taskDate != null) {
            List<Integer> idsCity = taskService.findIdCitiesTaskByIdCompanyAndDateCreate(idCompany, taskDate);
            cityMap = transformer.doCityTransformer(cityService.findCityByIdsAndIdCompany(idCompany, idsCity));
        } else
            cityMap = Collections.emptyMap();
            
        return cityMap;
    }
    
    @RequestMapping(value = "city/{idc}/templates.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<TaskTemplate> selectTemplateByCity(@PathVariable("idc") Integer idCity) {
        log.info("#Ajax selectTemplateByCity method(idCompany:" + idCompany + ",idCity:" + idCity + ")#");
        
        List<TaskTemplate> templateList;
        if (idCity != null)
            templateList = templateService.findTemplatesByIdCompanyAndIdCity(idCompany, idCity, null, null);
        else
            templateList = Collections.emptyList();
            
        return templateList;
    }
    
    @RequestMapping(value = "city/{idc}/users.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<User> selectUserByCity(@PathVariable("idc") Integer idCity) {
        log.info("#Ajax selectUserByCity method(idCompany:" + idCompany + ",idCity:" + idCity + ")#");
        
        List<User> userList;
        if (idCity != null)
            userList = userService.findMobileUserByIdCompanyAndIdCity(idCompany, idCity);
        else
            userList = Collections.emptyList();
            
        return userList;
    }
    
    @RequestMapping(value = "template/{date}/citiesbydate.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public Map<String, Collection<City>> selectCityTemplateByDate(@PathVariable("date") String taskCreateTemplate) {
        log.info("#Ajax selectCityTemplateByDate method(idCompany:" + idCompany + ",taskCreateTemplate:" + taskCreateTemplate + ")#");
        
        LocalDate templateDate = StringUtils.isNotEmpty(taskCreateTemplate) ? LocalDate.parse(taskCreateTemplate) : null;
        
        Map<String, Collection<City>> cityMap;
        if (templateDate != null) {
            List<Integer> idsCity = templateService.findIdCitiesTemplateByIdCompanyAndDateCreate(idCompany, templateDate);
            cityMap = transformer.doCityTransformer(cityService.findCityByIdsAndIdCompany(idCompany, idsCity));
        } else
            cityMap = Collections.emptyMap();
            
        return cityMap;
    }
    
    @RequestMapping(value = "{id}/cities.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<City> selectCityList(@PathVariable("id") Integer idRegion) {
        log.info("#Ajax selectCityList method(idCompany:" + idCompany + ",idRegion:" + idRegion + ")#");
        
        if (idRegion != null)
            return cityService.findCitiesByIdCompanyAndIdRegion(idCompany, idRegion);
        else
            return Collections.emptyList();
    }
    
    // http://localhost:9090/checker-cms/ajax/2016-01-04/6/tasks.json
    @RequestMapping(value = "{date}/{idc}/tasks.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Task> selectOwnTasksList(@PathVariable("date") String taskCreateDate, @PathVariable("idc") Integer idCity) {
        log.info("#Ajax selectOwnTasksList method(idCompany:" + idCompany + ",idCity:" + idCity + ",taskCreateDate:" + taskCreateDate + ")#");
        LocalDate dateTaskCreate = StringUtils.isNotEmpty(taskCreateDate) ? LocalDate.parse(taskCreateDate) : null;
        
        if (taskCreateDate != null && idCity != null)
            return taskService.findOwnTaskByIdCompanyAndIdCityAndDateCreate(idCompany, idCity, dateTaskCreate);
        else
            return Collections.emptyList();
    }
    
    @RequestMapping(value = "{idot}/{idc}/others/tasks.json", produces = MediaType.APPLICATION_JSON_VALUE)
    public List<Task> selectOtherTasksList(@PathVariable("idot") Long idTask, @PathVariable("idc") Integer idCity) {
        log.info("#Ajax selectOtherTasksList method(idCompany:" + idCompany + ",idTask:" + idTask + ",idCity:" + idCity + ")#");
        
        if (idTask != null && idCity != null)
            return taskService.findOtherTaskByIdCompanyAndIdTemplateAndIdCity(idCompany, idTask, idCity);
        else
            return Collections.emptyList();
    }
    
}
