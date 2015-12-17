package com.checker.cms.controllers;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CheckerService;
import com.checker.core.entity.Region;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("region")
public class RegionController {
    
    @Resource
    private CheckerService checkerService;
                           
    private Integer        idCompany = 1;
                                     
    @RequestMapping("list")
    public ModelAndView regionList() {
        log.info("#RegionList method(" + idCompany + ")#");
        List<Region> regionList = checkerService.findRegionsByIdCompany(idCompany);
        ModelAndView m = new ModelAndView("region");
        m.addObject("pageName", "region");
        m.addObject("regionList", regionList);
        return m;
    }
    
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String regionUpdate(@RequestParam("id") Integer id, @RequestParam("name") String caption) {
        log.info("#RegionUpdate method(" + idCompany + "," + id + "," + caption + ")#");
        if (StringUtils.isNotEmpty(caption)) {
            if (id != null && id > 0) {
                checkerService.updateRegion(idCompany, id, caption);
            } else {
                Region region = new Region();
                region.setIdCompany(idCompany);
                region.setCaption(caption);
                region.setDateAdded(DateTime.now());
                checkerService.save(region);
            }
        }
        return "redirect:/region/list";
    }
    
    @RequestMapping("delete/{id}")
    public String regionDelete(@PathVariable Integer id) {
        log.info("#RegionDelete method(" + idCompany + "," + id + ")#");
        if (id != null && id > 0)
            checkerService.deleteRegion(idCompany, id);
        return "redirect:/region/list";
    }
}
