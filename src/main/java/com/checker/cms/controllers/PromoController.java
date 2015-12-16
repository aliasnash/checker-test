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
import com.checker.core.entity.Promo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PromoController {
    
    @Resource
    private CheckerService checkerService;
    
    @RequestMapping("/promo/list")
    public ModelAndView promoList() {
        log.info("#PromoList method()#");
        List<Promo> promoList = checkerService.findPromosByIdCompany(1);
        ModelAndView m = new ModelAndView("promo");
        m.addObject("pageName", "promo");
        m.addObject("promoList", promoList);
        return m;
    }
    
    @RequestMapping(value = "/promo/update", method = RequestMethod.POST)
    public String promoUpdate(@RequestParam("id") Integer id, @RequestParam("name") String caption) {
        log.info("#promoUpdate method(" + id + "," + caption + ")#");
        if (StringUtils.isNotEmpty(caption))
            checkerService.updatePromo(1, id, caption);
        return "redirect:/promo/list";
    }
    
    @RequestMapping("/promo/delete/{id}")
    public String promoDelete(@PathVariable Integer id) {
        log.info("#promoDelete method(" + id + ")#");
        if (id != null && id > 0)
            checkerService.deletePromo(1, id);
        return "redirect:/promo/list";
    }
}
