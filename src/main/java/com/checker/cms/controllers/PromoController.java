package com.checker.cms.controllers;

import java.util.List;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.PromoService;
import com.checker.core.entity.Promo;

@Slf4j
@Controller
@RequestMapping("promo")
public class PromoController {
    
    @Resource
    private PromoService promoService;
    
    private Integer      idCompany = 1;
    
    @RequestMapping("list")
    public ModelAndView promoList() {
        log.info("#PromoList method(idCompany:" + idCompany + ")#");
        List<Promo> promoList = promoService.findPromosByIdCompany(idCompany);
        ModelAndView m = new ModelAndView("promo");
        m.addObject("pageName", "promo");
        m.addObject("promoList", promoList);
        return m;
    }
    
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String promoUpdate(@RequestParam("id") Integer id, @RequestParam("name") String caption) {
        log.info("#promoUpdate method(idCompany:" + idCompany + ",id:" + id + ",caption:" + caption + ")#");
        if (StringUtils.isNotEmpty(caption))
            promoService.updatePromo(idCompany, id, caption);
        return "redirect:/promo/list";
    }
    
    @RequestMapping("delete/{id}")
    public String promoDelete(@PathVariable("id") Integer id) {
        log.info("#promoDelete method(idCompany:" + idCompany + ",id" + id + ")#");
        if (id != null && id > 0)
            promoService.deletePromo(idCompany, id);
        return "redirect:/promo/list";
    }
}
