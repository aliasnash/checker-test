package com.checker.cms.controllers;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
import com.checker.core.dao.service.DynamicService;
import com.checker.core.dao.service.MarketPointService;
import com.checker.core.dao.service.UserService;
import com.checker.core.entity.City;
import com.checker.core.entity.MarketPoint;
import com.checker.core.entity.User;
import com.checker.core.model.DynamicTaskInfoStacked;
import com.checker.core.utilz.PagerUtilz;
import com.checker.core.utilz.Transformer;

@Slf4j
@Controller
@RequestMapping("dynamic")
public class DynamicController {
    
    @Resource
    private DynamicService     dynamicService;
    
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
    
    private Integer            idCompany     = 1;
    
    private Integer            recordsOnPage = 9;
    
    @RequestMapping
    public ModelAndView dynamic(HttpSession session, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        Integer idUserDynSaved = (Integer) session.getAttribute("idUserDynSaved");
        Integer idCityDynSaved = (Integer) session.getAttribute("idCityDynSaved");
        Long idMarketPointDynSaved = (Long) session.getAttribute("idMarketPointDynSaved");
        String dynTaskCreateDate = (String) session.getAttribute("dynTaskCreateDate");
        
        log.info("#Dynamic GET method(idCompany:" + idCompany + ",page:" + page + ",idUserSaved:" + idUserDynSaved + ",idCitySaved:" + idCityDynSaved + ",idMarketPointSaved:" + idMarketPointDynSaved + ",taskCreateDate:" + dynTaskCreateDate + ")#");
        List<User> userList = userService.findMobileUserByIdCompany(idCompany);
        Map<String, Collection<City>> cityMap = transformer.doCityTransformer(cityService.findCitiesByIdCompany(idCompany));
        Map<String, Collection<MarketPoint>> marketPointMap;
        if (idCityDynSaved != null)
            marketPointMap = transformer.doMarketTransformer(marketPointService.findOtherMarketPointByIdCompanyAndIdCity(idCompany, idCityDynSaved));
        else
            marketPointMap = Collections.emptyMap();
        
        if (StringUtils.isEmpty(dynTaskCreateDate)) {
            dynTaskCreateDate = LocalDate.now().toString("yyyy-MM-dd");
            session.setAttribute("dynTaskCreateDate", dynTaskCreateDate);
        }
        LocalDate dateTaskCreate = LocalDate.parse(dynTaskCreateDate);
        
        Long recordsCount = dynamicService.countDynamicInfoStackedByFilterParams(idCompany, idUserDynSaved, idCityDynSaved, idMarketPointDynSaved, dateTaskCreate);
        Integer pageCount = pagerUtilz.getPageCount(recordsCount, recordsOnPage);
        page = pagerUtilz.getPage(page, pageCount);
        
        Set<DynamicTaskInfoStacked> dynamicTasks = dynamicService.getDynamicInfoStackedByFilterParams(idCompany, idUserDynSaved, idCityDynSaved, idMarketPointDynSaved, dateTaskCreate, page, recordsOnPage);
        
        ModelAndView m = new ModelAndView("dynamic");
        m.addObject("pageName", "dynamic");
        m.addObject("dynamicTasks", dynamicTasks);
        m.addObject("userList", userList);
        m.addObject("cityMap", cityMap);
        m.addObject("marketPointMap", marketPointMap);
        m.addObject("recordsCount", recordsCount);
        m.addObject("pageCount", pageCount);
        m.addObject("page", page);
        
        return m;
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public String dynamic(HttpSession session, @RequestParam(value = "filter_user_id") Integer idUserDynSaved, @RequestParam(value = "filter_city_id") Integer idCityDynSaved,
            @RequestParam(value = "filter_market_point_id", required = false) Long idMarketPointDynSaved, @RequestParam(value = "filtered_task_create_date") String dynTaskCreateDate) {
        log.info("#Dynamic POST method(idCompany:" + idCompany + ",idUserSaved:" + idUserDynSaved + ",idCitySaved:" + idCityDynSaved + ",idMarketPointSaved:" + idMarketPointDynSaved + ",taskCreateDate:" + dynTaskCreateDate + ")#");
        session.setAttribute("idUserDynSaved", idUserDynSaved);
        session.setAttribute("idCityDynSaved", idCityDynSaved);
        session.setAttribute("idMarketPointDynSaved", idMarketPointDynSaved);
        session.setAttribute("dynTaskCreateDate", dynTaskCreateDate);
        return "redirect:/dynamic";
    }
    
    @RequestMapping(value = "reset")
    public String dynamicReset(HttpSession session) {
        log.info("#DynamicReset method(idCompany:" + idCompany + ")#");
        session.removeAttribute("idUserDynSaved");
        session.removeAttribute("idCityDynSaved");
        session.removeAttribute("idMarketPointDynSaved");
        session.removeAttribute("dynTaskCreateDate");
        return "redirect:/dynamic";
    }
    
}
