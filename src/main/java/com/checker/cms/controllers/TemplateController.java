package com.checker.cms.controllers;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

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

import com.checker.cms.excel.ParsingResult;
import com.checker.cms.excel.TemplateParser;
import com.checker.core.dao.service.TemplateService;
import com.checker.core.entity.TaskTemplate;
import com.checker.core.entity.TaskTemplateArticle;
import com.checker.core.utilz.FileUtilz;
import com.checker.core.utilz.Params;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("template")
public class TemplateController {
    
    @Resource
    private Params            params;
    @Resource
    private TemplateService   templateService;
    @Resource
    private TemplateParser    templateParser;
    @Resource
    private FileUtilz         fileUtilz;
                              
    private DateTimeFormatter fmt       = DateTimeFormat.forPattern("yyyyMMddHHmmss");
    private Integer           idCompany = 1;
                                        
    @PostConstruct
    public void init() {
        System.out.println("pathForTemplate:" + params.getPathForTemplate());
    }
    
    @RequestMapping("list")
    public ModelAndView templateList() {
        log.info("#TemplateList method(idCompany:" + idCompany + ")#");
        List<TaskTemplate> templateList = templateService.findTemplatesByIdCompany(idCompany);
        ModelAndView m = new ModelAndView("template");
        m.addObject("pageName", "template");
        m.addObject("templateList", templateList);
        return m;
    }
    
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String templateUpdate(@RequestParam("id") Long idTemplate, @RequestParam("name") String caption) {
        log.info("#TemplateUpdate method(idCompany:" + idCompany + ",idTemplate:" + idTemplate + ",caption:" + caption + ")#");
        if (StringUtils.isNotEmpty(caption)) {
            if (idTemplate != null && idTemplate > 0) {
                templateService.updateTemplate(idCompany, idTemplate, caption);
            } else {
                TaskTemplate template = new TaskTemplate();
                template.setIdCompany(idCompany);
                template.setCaption(caption);
                template.setDateAdded(DateTime.now());
                template.setCurrentDate(LocalDate.now());
                templateService.saveTemplate(template);
            }
        }
        return "redirect:/template/list";
    }
    
    @RequestMapping("{id}/delete")
    public String templateDelete(@PathVariable("id") Long idTemplate) {
        log.info("#TemplateDelete method(idCompany:" + idCompany + ",idTemplate:" + idTemplate + ")#");
        if (idTemplate != null && idTemplate > 0)
            templateService.deleteTemplate(idCompany, idTemplate);
        return "redirect:/template/list";
    }
    
    @RequestMapping(value = "file/upload", headers = "content-type=multipart/*", method = RequestMethod.POST)
    public ModelAndView templateFileAddDone(@RequestParam("name") String caption, @RequestParam("templates") MultipartFile mFile) throws IllegalStateException, IOException {
        log.info("#TemplateFileAddDone method(idCompany:" + idCompany + ",caption:" + caption + ",file:" + mFile.getOriginalFilename() + ")#");
        
        DateTime dt = new DateTime();
        
        File dir = fileUtilz.createDirectory(params.getPathForTemplate() + LocalDate.now().toString());
        File file = new File(dir.getAbsolutePath() + "/" + fmt.print(dt) + "_" + mFile.getOriginalFilename());
        mFile.transferTo(file);
        ParsingResult result = templateParser.process(idCompany, file, caption);
        
        ModelAndView m = new ModelAndView("templateadd");
        m.addObject("pageName", "template");
        m.addObject("result", result);
        return m;
    }
    
    @RequestMapping("file/add/form")
    public ModelAndView templateFileAddForm() {
        log.info("#TemplateFileAddForm method(idCompany:" + idCompany + ")#");
        ModelAndView m = new ModelAndView("templateadd");
        m.addObject("pageName", "template");
        return m;
    }
    
    @RequestMapping("{id}/list")
    public ModelAndView templateArticleList(@PathVariable("id") Long idTemplate) {
        log.info("#TemplateArticleList method(idCompany:" + idCompany + ")#");
        List<TaskTemplateArticle> templateArticleList = templateService.findArticleTemplatesByIdCompanyAndIdTemplate(idCompany, idTemplate);
        ModelAndView m = new ModelAndView("templatearticle");
        m.addObject("pageName", "template");
        m.addObject("templateArticleList", templateArticleList);
        return m;
    }
    
}
