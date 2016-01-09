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
import com.checker.core.entity.Region;

@Slf4j
@Controller
@RequestMapping("region")
public class RegionController {
    
    @Resource
    private CityService cityService;
    
    private Integer     idCompany = 1;
    
    @RequestMapping("list")
    public ModelAndView regionList() {
        log.info("#RegionList method(idCompany:" + idCompany + ")#");
        List<Region> regionList = cityService.findRegionsByIdCompany(idCompany);
        ModelAndView m = new ModelAndView("region");
        m.addObject("pageName", "region");
        m.addObject("regionList", regionList);
        return m;
    }
    
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String regionUpdate(@RequestParam("id") Integer id, @RequestParam("name") String caption) {
        log.info("#RegionUpdate method(idCompany:" + idCompany + ",id:" + id + ",caption:" + caption + ")#");
        if (StringUtils.isNotEmpty(caption)) {
            if (id != null && id > 0) {
                cityService.updateRegion(idCompany, id, caption);
            } else {
                Region region = new Region();
                region.setActive(Boolean.TRUE);
                region.setIdCompany(idCompany);
                region.setCaption(caption);
                region.setDateAdded(DateTime.now());
                cityService.saveRegion(region);
            }
        }
        return "redirect:/region/list";
    }
    
    @RequestMapping("delete/{id}")
    public String regionDelete(@PathVariable Integer id) {
        log.info("#RegionDelete method(idCompany:" + idCompany + ",id:" + id + ")#");
        if (id != null && id > 0)
            cityService.deleteRegion(idCompany, id);
        return "redirect:/region/list";
    }
}
