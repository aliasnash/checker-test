package com.checker.cms.controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

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
    
    @RequestMapping(value = "file/upload", method = RequestMethod.GET)
    public String templateFileAddDone() throws IllegalStateException, IOException {
        log.info("#TemplateFileAddDone method(idCompany:" + idCompany + ")#");
        return "redirect:/template/file/add/form";
    }
    
    @RequestMapping(value = "file/upload", headers = "content-type=multipart/*", method = RequestMethod.POST)
    public ModelAndView templateFileAddDone(@RequestParam(value = "name", required = false) String caption, @RequestParam(value = "usefilename", required = false) Boolean useFileName,
            @RequestParam(value = "useprice", required = false) Boolean usePrice, @RequestParam("templates[]") List<MultipartFile> mFileList) throws IllegalStateException, IOException {
        log.info("#TemplateFileAddDone method(idCompany:" + idCompany + ",caption:" + caption + ",useFileName:" + useFileName + ",usePrice:" + usePrice + ",file:" + mFileList.size() + ")#");
        
        List<ParsingResult> results = new ArrayList<>();
        DateTime dt = new DateTime();
        
        if (useFileName == null)
            useFileName = false;
        if (usePrice == null)
            usePrice = false;
        
        String originalCaption = caption;
        File dir = fileUtilz.createDirectory(params.getPathForTemplate() + LocalDate.now().toString());
        int index = 0;
        for (MultipartFile mFile : mFileList) {
            File file = new File(dir.getAbsolutePath() + "/" + fmt.print(dt) + "_" + mFile.getOriginalFilename());
            mFile.transferTo(file);
            
            if (StringUtils.isEmpty(caption) || useFileName)
                caption = mFile.getOriginalFilename().substring(0, mFile.getOriginalFilename().lastIndexOf('.') - 1);
            else if (mFileList.size() > 1)
                caption = (index++) + "_" + originalCaption;
            
            if (caption.length() > 128)
                caption = caption.substring(0, 127);
            
            ParsingResult result = templateParser.process(idCompany, file, caption, usePrice);
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
