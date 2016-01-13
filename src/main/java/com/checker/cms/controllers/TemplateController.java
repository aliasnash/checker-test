package com.checker.cms.controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.ArticleService;
import com.checker.core.dao.service.CityService;
import com.checker.core.dao.service.TemplateService;
import com.checker.core.entity.Article;
import com.checker.core.entity.City;
import com.checker.core.entity.TaskTemplate;
import com.checker.core.entity.TaskTemplateArticle;
import com.checker.core.model.TupleHolder;
import com.checker.core.parser.excel.TemplateParser;
import com.checker.core.result.excel.ParsingResult;
import com.checker.core.utilz.CoreSettings;
import com.checker.core.utilz.FileUtilz;
import com.checker.core.utilz.JsonTemplateTransformer;
import com.checker.core.utilz.PagerUtilz;
import com.checker.core.utilz.Transformer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("template")
public class TemplateController {
    
    @Resource
    private CityService             cityService;
    @Resource
    private Transformer             transformer;
    @Resource
    private CoreSettings            coreSettings;
    @Resource
    private TemplateService         templateService;
    @Resource
    private ArticleService          articleService;
    @Resource
    private TemplateParser          templateParser;
    @Resource
    private FileUtilz               fileUtilz;
    @Resource
    private JsonTemplateTransformer jsonTemplateTransformer;
    @Resource
    private PagerUtilz              pagerUtilz;
                                    
    private DateTimeFormatter       fmt           = DateTimeFormat.forPattern("yyyyMMddHHmmss");
                                                  
    private Integer                 idCompany     = 1;
                                                  
    private Integer                 recordsOnPage = 10;
                                                  
    @RequestMapping()
    public ModelAndView templateList(HttpSession session, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        String templateDate = (String) session.getAttribute("templateDate");
        Integer idCity = (Integer) session.getAttribute("templateIdCity");
        log.info("#TemplateList GET method(idCompany:" + idCompany + ",date:" + templateDate + ",idCity:" + idCity + ",page:" + page + ")#");
        
        LocalDate localDate = StringUtils.isNotEmpty(templateDate) ? LocalDate.parse(templateDate) : null;
        
        Long recordsCount = 0L;
        if (localDate != null)
            recordsCount = templateService.countTemplatesByIdCompanyAndIdCityAndDate(idCompany, idCity, localDate);
        else
            recordsCount = templateService.countTemplatesByIdCompanyAndIdCity(idCompany, idCity);
            
        Integer pageCount = pagerUtilz.getPageCount(recordsCount, recordsOnPage);
        page = pagerUtilz.getPage(page, pageCount);
        
        List<TaskTemplate> templateList = null;
        if (localDate != null)
            templateList = templateService.findTemplatesByIdCompanyAndIdCityAndDate(idCompany, idCity, localDate, page, recordsOnPage);
        else
            templateList = templateService.findTemplatesByIdCompanyAndIdCity(idCompany, idCity, page, recordsOnPage);
            
        List<Integer> idsCity = templateService.findIdCitiesTemplateByIdCompanyAndDateCreate(idCompany, localDate);
        Map<String, Collection<City>> cityMap = transformer.doCityTransformer(cityService.findCityByIdsAndIdCompany(idCompany, idsCity));
        Map<String, Collection<City>> cityMapForFilter = transformer.doCityTransformer(cityService.findCitiesByIdCompany(idCompany));
        
        ModelAndView m = new ModelAndView("template");
        m.addObject("pageName", "template");
        m.addObject("cityMap", cityMap);
        m.addObject("cityMapForFilter", cityMapForFilter);
        m.addObject("templateList", templateList);
        m.addObject("recordsCount", recordsCount);
        m.addObject("pageCount", pageCount);
        m.addObject("page", page);
        return m;
    }
    
    @RequestMapping(method = RequestMethod.POST)
    public String templateList(HttpSession session, @RequestParam(value = "filtered_template_date") String templateDate, @RequestParam(value = "filtered_template_city") Integer idCity) {
        log.info("#TemplateList POST method(idCompany:" + idCompany + ",date:" + templateDate + ",idCity:" + idCity + ")#");
        session.setAttribute("templateDate", templateDate);
        session.setAttribute("templateIdCity", idCity);
        return "redirect:/template";
    }
    
    @RequestMapping(value = "reset")
    public String templateReset(HttpSession session) {
        log.info("#TemplateReset method(idCompany:" + idCompany + ")#");
        session.removeAttribute("templateDate");
        session.removeAttribute("templateIdCity");
        return "redirect:/template";
    }
    
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String templateUpdate(@RequestParam("id") Long idTemplate,
            /* @RequestParam(value = "template-save-city", required = false) Integer idCity, */ @RequestParam("name") String caption, @RequestParam("date-template-filtered") String templateDate,
            @RequestParam("idcity-template-filtered") Integer idCity, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TemplateUpdate method(idCompany:" + idCompany + ",idTemplate:" + idTemplate + ",idCity:" + idCity + ",caption:" + caption + ",date:" + templateDate + ",page:" + page + ")#");
        if (StringUtils.isNotEmpty(caption)) {
            if (idTemplate != null && idTemplate > 0) {
                templateService.updateTemplate(idCompany, idTemplate, caption, idCity);
            } else {
                TaskTemplate template = new TaskTemplate();
                template.setIdCompany(idCompany);
                template.setCaption(caption);
                template.setDateAdded(DateTime.now());
                template.setCurrentDate(LocalDate.now());
                template.setIdCity(idCity);
                // template.setPriceExist(Boolean.FALSE);
                template.setActive(Boolean.TRUE);
                templateService.saveTemplate(template);
            }
        }
        return "redirect:/template?page=" + page;
    }
    
    @RequestMapping("{id}/delete")
    public String templateDelete(@PathVariable("id") Long idTemplate, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#TemplateDelete method(idCompany:" + idCompany + ",idTemplate:" + idTemplate + ",page:" + page + ")#");
        if (idTemplate != null && idTemplate > 0)
            templateService.deleteTemplate(idCompany, idTemplate);
        return "redirect:/template?page=" + page;
    }
    
    @RequestMapping(value = "file/upload", method = RequestMethod.GET)
    public String templateFileAddDone() throws IllegalStateException, IOException {
        log.info("#TemplateFileAddDone method(idCompany:" + idCompany + ")#");
        return "redirect:/template/file/add/form";
    }
    
    @RequestMapping(value = "file/upload", headers = "content-type=multipart/*", method = RequestMethod.POST)
    public ModelAndView templateFileAddDone(@RequestParam("template-upload-city") Integer idCity, @RequestParam("templates[]") List<MultipartFile> mFileList) throws IllegalStateException, IOException {
        log.info("#TemplateFileAddDone method(idCompany:" + idCompany + ",idCity:" + idCity + ",file:" + mFileList.size() + ")#");
        List<ParsingResult> results = new ArrayList<>();
        DateTime dt = new DateTime();
        File dir = fileUtilz.createDirectory(coreSettings.getPathForTemplate() + LocalDate.now().toString());
        for (MultipartFile mFile : mFileList) {
            File file = new File(dir.getAbsolutePath() + "/" + fmt.print(dt) + "_" + mFile.getOriginalFilename());
            mFile.transferTo(file);
            String caption = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf('.') - 1);
            if (caption.length() > 128)
                caption = caption.substring(0, 127);
            ParsingResult result = templateParser.process(idCompany, idCity, file, caption);
            result.setFileName(mFile.getOriginalFilename());
            results.add(result);
        }
        
        ModelAndView m = new ModelAndView("templateadd");
        m.addObject("pageName", "template");
        m.addObject("results", results);
        return m;
    }
    
    @RequestMapping("file/add/form")
    public ModelAndView templateFileAddForm() {
        log.info("#TemplateFileAddForm method(idCompany:" + idCompany + ")#");
        Map<String, Collection<City>> cityMap = transformer.doCityTransformer(cityService.findCitiesByIdCompany(idCompany));
        
        ModelAndView m = new ModelAndView("templateadd");
        m.addObject("pageName", "template");
        m.addObject("cityMap", cityMap);
        return m;
    }
    
    @RequestMapping("{id}/list")
    public ModelAndView templateArticleList(@PathVariable("id") Long idTemplate) {
        log.info("#TemplateArticleList method(idCompany:" + idCompany + ",idTemplate:" + idTemplate + ")#");
        List<Article> articleList = articleService.findArticles(idCompany);
        List<TaskTemplateArticle> templateArticleList = templateService.findArticleTemplatesByIdCompanyAndIdTemplate(idCompany, idTemplate);
        TaskTemplate taskTemplate = templateService.findTemplateByIdAndIdCompany(idCompany, idTemplate);
        TupleHolder<String, List<Long>> result = jsonTemplateTransformer.process(templateArticleList, articleList);
        ModelAndView m = new ModelAndView("templatearticles");
        m.addObject("pageName", "template");
        m.addObject("taskTemplate", taskTemplate);
        m.addObject("templateTree", result.getValue1());
        m.addObject("templateSelected", result.getValue2());
        return m;
    }
    
    @RequestMapping("{id}/articule/update")
    public String templateArticleUpdateList(@PathVariable("id") Long idTemplate, @RequestParam("idarticle[]") List<Long> idArticleList) {
        log.info("#TemplateList method(idCompany:" + idCompany + ",idTemplate:" + idTemplate + ",idArticleList:" + idArticleList.size() + ")#");
        templateService.reUpdateTemplateArticle(idCompany, idTemplate, idArticleList);
        return "redirect:/template/{id}/list";
    }
}
