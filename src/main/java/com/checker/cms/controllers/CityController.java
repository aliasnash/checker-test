package com.checker.cms.controllers;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CityService;
import com.checker.core.entity.City;
import com.checker.core.entity.Region;

@Slf4j
@Controller
@RequestMapping("city")
public class CityController {
    
    @Resource
    private CityService cityService;
    
    private Integer     idCompany = 1;
    
    @RequestMapping(value = "list", method = RequestMethod.GET)
    public ModelAndView cityList(HttpSession session) {
        Integer idRegion = (Integer) session.getAttribute("idRegion");
        log.info("#CityList GET method(idCompany:" + idCompany + ",idRegion:" + idRegion + ")#");
        List<Region> regionList = cityService.findRegionsByIdCompany(idCompany);
        List<City> cityList = null;
        if (idRegion != null)
            cityList = cityService.findCitiesByIdCompanyAndIdRegion(idCompany, idRegion);
        else
            cityList = cityService.findCitiesByIdCompany(idCompany);
        
        ModelAndView m = new ModelAndView("city");
        m.addObject("pageName", "city");
        m.addObject("idRegion", (idRegion != null ? idRegion : -1));
        m.addObject("cityList", cityList);
        m.addObject("regionList", regionList);
        return m;
    }
    
    @RequestMapping(value = "list", method = RequestMethod.POST)
    public String cityList(HttpSession session, @RequestParam(value = "filter_region_id") Integer idRegion) {
        log.info("#CityList POST method(idCompany:" + idCompany + ",idRegion:" + idRegion + ")#");
        session.setAttribute("idRegion", idRegion);
        return "redirect:/city/list";
    }
    
    @RequestMapping(value = "reset")
    public String cityReset(HttpSession session) {
        log.info("#CityReset method(idCompany:" + idCompany + ")#");
        session.removeAttribute("idRegion");
        return "redirect:/city/list";
    }
    
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String cityUpdate(HttpSession session, @RequestParam("idregion") Integer idRegion, @RequestParam("id") Integer idCity, @RequestParam("name") String caption) {
        log.info("#CityUpdate method(idCompany:" + idCompany + ",idRegion:" + idRegion + ",idCity:" + idCity + ",caption:" + caption + ")#");
        if (idRegion != null && idRegion > 0 && StringUtils.isNotEmpty(caption)) {
            if (idCity != null && idCity > 0) {
                cityService.updateCity(idCompany, idRegion, idCity, caption);
            } else {
                City city = new City();
                city.setActive(true);
                city.setIdRegion(idRegion);
                city.setCaption(caption);
                city.setDateAdded(DateTime.now());
                cityService.saveCity(city);
            }
        }
        session.setAttribute("idRegion", idRegion);
        return "redirect:/city/list";
    }
    
    @RequestMapping("delete/{idRegion}/{idCity}")
    public String cityDelete(HttpSession session, @PathVariable("idRegion") Integer idRegion, @PathVariable("idCity") Integer idCity) {
        log.info("#CityDelete method(idCompany:" + idCompany + ",idRegion:" + idRegion + ",idCity:" + idCity + ")#");
        if (idRegion != null && idRegion > 0 && idCity != null && idCity > 0)
            cityService.deleteCity(idCompany, idRegion, idCity);
        session.setAttribute("idRegion", idRegion);
        return "redirect:/city/list";
    }
    
}
