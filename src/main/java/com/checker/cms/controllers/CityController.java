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
    
    @RequestMapping("list")
    public ModelAndView cityList() {
        log.info("#CityList method(idCompany:" + idCompany + ")#");
        List<Region> regionList = cityService.findRegionsByIdCompany(idCompany);
        List<City> cityList = cityService.findCitiesByIdCompany(idCompany);
        ModelAndView m = new ModelAndView("city");
        m.addObject("pageName", "city");
        m.addObject("cityList", cityList);
        m.addObject("regionList", regionList);
        return m;
    }
    
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String cityUpdate(@RequestParam("idregion") Integer idRegion, @RequestParam("id") Integer idCity, @RequestParam("name") String caption) {
        log.info("#CityUpdate method(idCompany:" + idCompany + ",idRegion:" + idRegion + ",idCity:" + idCity + ",caption:" + caption + ")#");
        if (idRegion != null && idRegion > 0 && StringUtils.isNotEmpty(caption)) {
            if (idCity != null && idCity > 0) {
                cityService.updateCity(idCompany, idRegion, idCity, caption);
            } else {
                City city = new City();
                city.setIdRegion(idRegion);
                city.setCaption(caption);
                city.setDateAdded(DateTime.now());
                cityService.saveCity(city);
            }
        }
        return "redirect:/city/list";
    }
    
    @RequestMapping("delete/{idRegion}/{idCity}")
    public String cityDelete(@PathVariable("idRegion") Integer idRegion, @PathVariable("idCity") Integer idCity) {
        log.info("#CityDelete method(idCompany:" + idCompany + ",idRegion:" + idRegion + ",idCity:" + idCity + ")#");
        if (idRegion != null && idRegion > 0 && idCity != null && idCity > 0)
            cityService.deleteCity(idCompany, idRegion, idCity);
        return "redirect:/city/list";
    }
    
}
