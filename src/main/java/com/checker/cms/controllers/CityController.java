package com.checker.cms.controllers;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CheckerService;
import com.checker.core.entity.City;
import com.checker.core.entity.Region;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CityController {
    
    @Resource
    private CheckerService checkerService;
    
    @RequestMapping("/region/list")
    public ModelAndView regionList() {
        log.info("#RegionList method()#");
        List<Region> regionList = checkerService.findRegionsByIdCompany(1);
        ModelAndView m = new ModelAndView("region");
        m.addObject("pageName", "region");
        m.addObject("regionList", regionList);
        return m;
    }
    
    @RequestMapping(value = "/region/update", method = RequestMethod.POST)
    public String regionUpdate(@RequestParam("id") Integer id, @RequestParam("name") String caption) {
        log.info("#RegionUpdate method(" + id + "," + caption + ")#");
        if (StringUtils.isNotEmpty(caption))
            checkerService.updateRegion(1, id, caption);
        return "redirect:/region/list";
    }
    
    @RequestMapping("/region/delete/{id}")
    public String regionDelete(@PathVariable Integer id) {
        log.info("#RegionDelete method(" + id + ")#");
        if (id != null && id > 0)
            checkerService.deleteRegion(1, id);
        return "redirect:/region/list";
    }
    
    @RequestMapping("/city/list")
    public ModelAndView cityList() {
        log.info("#CityList method()#");
        List<City> cityList = checkerService.findCitiesByIdCompany(1);
        ModelAndView m = new ModelAndView("city");
        m.addObject("pageName", "city");
        m.addObject("cityList", cityList);
        return m;
    }
    
    @RequestMapping(value = "/city/update", method = RequestMethod.POST)
    public String cityUpdate(@RequestParam("idregion") Integer idRegion, @RequestParam("idcity") Integer idCity, @RequestParam("name") String caption) {
        log.info("#CityUpdate method(" + idRegion + ", " + idCity + ")#");
        if (StringUtils.isNotEmpty(caption))
            checkerService.updateCity(1, idRegion, idCity, caption);
        return "redirect:/city/list";
    }
    
    @RequestMapping("/city/delete/{idRegion}/{idCity}")
    public String cityDelete(@PathVariable Integer idRegion, @PathVariable Integer idCity) {
        log.info("#CityDelete method(" + idRegion + ", " + idCity + ")#");
        if (idRegion != null && idRegion > 0 && idCity != null && idCity > 0)
            checkerService.deleteCity(1, idRegion, idCity);
        return "redirect:/city/list";
    }
    
}
