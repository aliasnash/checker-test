package com.checker.cms.controllers;

import java.io.File;
import java.io.UnsupportedEncodingException;
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
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.CityService;
import com.checker.core.dao.service.MainService;
import com.checker.core.dao.service.MarketPointService;
import com.checker.core.dao.service.PromoService;
import com.checker.core.dao.service.ReportService;
import com.checker.core.dao.service.UserService;
import com.checker.core.entity.Promo;
import com.checker.core.entity.Region;
import com.checker.core.entity.ReportHistory;
import com.checker.core.utilz.CoreSettings;
import com.checker.core.utilz.FileUtilz;
import com.checker.core.utilz.PagerUtilz;
import com.checker.core.utilz.Transformer;

@Slf4j
@Controller
@RequestMapping("report")
public class ReportController {
    
    @Resource
    private ReportService      reportService;
    @Resource
    private PromoService       promoService;
    @Resource
    private Transformer        transformer;
    @Resource
    private MarketPointService marketPointService;
    @Resource
    private CityService        cityService;
    @Resource
    private UserService        userService;
    @Resource
    private MainService        mainService;
    @Resource
    private CoreSettings       coreSettings;
    @Resource
    private FileUtilz          fileUtilz;
    
    @Resource
    private PagerUtilz         pagerUtilz;
    
    private Integer            idCompany     = 1;
    
    private Integer            recordsOnPage = 10;
    
    private DateTimeFormatter  fmt           = DateTimeFormat.forPattern("yyyyMMddHHmmss");
    
    @RequestMapping
    public ModelAndView report(@RequestParam(value = "id", required = false) Long idReport, @RequestParam(value = "error", required = false) String error, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#Report method(idCompany:" + idCompany + ",idReport:" + idReport + ",error:" + error + ",page:" + page + ")#");
        
        Long recordsCount = reportService.countReportHistoryByIdCompany(idCompany);
        Integer pageCount = pagerUtilz.getPageCount(recordsCount, recordsOnPage);
        page = pagerUtilz.getPage(page, pageCount);
        
        List<ReportHistory> reportList = reportService.findReportHistoryByIdCompany(idCompany, page, recordsOnPage);
        List<Region> regionList = cityService.findRegionsByIdCompany(idCompany);
        List<Promo> promoList = promoService.findPromosByIdCompany(idCompany);
        
        ModelAndView m = new ModelAndView("report");
        m.addObject("pageName", "report");
        m.addObject("reportList", reportList);
        m.addObject("regionList", regionList);
        m.addObject("promoList", promoList);
        m.addObject("rootUrl", coreSettings.getRootUrlReport());
        m.addObject("idReport", idReport);
        m.addObject("error", error);
        m.addObject("recordsCount", recordsCount);
        m.addObject("pageCount", pageCount);
        m.addObject("page", page);
        
        return m;
    }
    
    @RequestMapping(value = "generate", method = RequestMethod.POST)
    public String reportGenerate(@RequestParam(value = "filter_promo_id", required = false) Integer idPromo, @RequestParam(value = "filter_city_id", required = false) Integer idCity, @RequestParam("filter_task_create_date") String taskCreateDate,
            @RequestParam(value = "filter_own_task_id", required = false) Long idOwnMarketPoint, @RequestParam(value = "filter_other_task_id[]", required = false) List<Long> idMarketPointList)
    
    throws UnsupportedEncodingException {
        log.info("#ReportGenerate POST method(idCompany:" + idCompany + ",idCity:" + idCity + ",idOwnMarketPoint:" + idOwnMarketPoint + ",idMarketPointList:" + idMarketPointList + ",idPromo:" + idPromo + ",taskCreateDate:" + taskCreateDate + ")#");
        
        LocalDate dateTaskCreate = StringUtils.isNotEmpty(taskCreateDate) ? LocalDate.parse(taskCreateDate) : null;
        // String errorString = null;
        
        if (idCity == null) {
            // errorString = "Не указан город";
            // return "redirect:/report?error=" + URLDecoder.decode(errorString, "UTF-8");
            return "redirect:/report";
        } else if (idOwnMarketPoint == null) {
            // errorString = "Не указана своя сеть";
            // return "redirect:/report?error=" + URLDecoder.decode(errorString, "UTF-8");
            return "redirect:/report";
        } else if (idMarketPointList == null || idMarketPointList.size() == 0) {
            // errorString = "Не указаны сети конкурента";
            // return "redirect:/report?error=" + URLDecoder.decode(errorString, "UTF-8");
            return "redirect:/report";
        } else if (dateTaskCreate == null) {
            // errorString = "Не указана дата создания задачи";
            // return "redirect:/report?error=" + URLDecoder.decode(errorString, "UTF-8");
            return "redirect:/report";
        } else {
            DateTime dt = new DateTime();
            File dir = fileUtilz.createDirectory(coreSettings.getPathForReport() + LocalDate.now().toString());
            // File file = new File(dir.getAbsolutePath() + "/" + fmt.print(dt) + "_" + mFile.getOriginalFilename());
            
            ReportHistory reportHistory = new ReportHistory();
            reportHistory.setIdCompany(1);
            reportHistory.setCaption(fmt.print(dt) + "_report_v1");
            reportHistory.setFilePath("report_v1.xls");
            reportHistory.setFileSize(0L);
            reportHistory.setActive(true);
            reportHistory.setDateAdded(DateTime.now());
            mainService.save(reportHistory);
            
            return "redirect:/report?id=" + reportHistory.getId();
        }
    }
    
    @RequestMapping("{id}/delete")
    public String reportDelete(@PathVariable("id") Long idReport, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#ReportDelete method(idCompany:" + idCompany + ",idReport:" + idReport + ",page:" + page + ")#");
        if (idReport != null && idReport > 0)
            reportService.deleteReportHistory(idCompany, idReport);
        return "redirect:/report?page=" + page;
    }
    
}
