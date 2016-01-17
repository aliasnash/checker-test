package com.checker.cms.controllers;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.BooleanUtils;
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
import com.checker.core.dao.service.TaskService;
import com.checker.core.dao.service.UserService;
import com.checker.core.entity.City;
import com.checker.core.entity.Promo;
import com.checker.core.entity.ReportHistory;
import com.checker.core.entity.Task;
import com.checker.core.entity.TaskArticle;
import com.checker.core.model.ReportArticleData;
import com.checker.core.model.TupleHolder;
import com.checker.core.parser.excel.ReportBuilder;
import com.checker.core.utilz.CoreSettings;
import com.checker.core.utilz.FileUtilz;
import com.checker.core.utilz.PagerUtilz;
import com.checker.core.utilz.Transformer;

@Slf4j
@Controller
@RequestMapping("report")
public class ReportController {
    
    @Resource
    private ReportBuilder      reportBuilder;
    @Resource
    private TaskService        taskService;
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
    
    @SuppressWarnings("unchecked")
    @RequestMapping
    public ModelAndView report(HttpSession session, @RequestParam(value = "id", required = false) Long idReport, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        String reportTaskDate = (String) session.getAttribute("reportTaskDate");
        Integer idCity = (Integer) session.getAttribute("idCityReportSaved");
        Long idOwnTask = (Long) session.getAttribute("idOwnTaskReportSaved");
        List<Long> idsOtherTasks = (List<Long>) session.getAttribute("idOtherTaskReportSaved");
        List<Integer> idPromoList = (List<Integer>) session.getAttribute("idPromoReportSaved");
        Boolean withoutPhoto = (Boolean) session.getAttribute("withoutPhoto");
        
        log.info("#Report method(idCompany:" + idCompany + ",idReport:" + idReport + ",withoutPhoto:" + withoutPhoto + ",reportTaskDate:" + reportTaskDate + ",idCity:" + idCity + ",idOwnTask:" + idOwnTask + ",idsOtherTasks:" + idsOtherTasks
                + ",idPromoList:" + idPromoList + ",page:" + page + ")#");
        
        LocalDate dateTaskCreate = StringUtils.isNotEmpty(reportTaskDate) ? LocalDate.parse(reportTaskDate) : null;
        
        Map<String, Collection<City>> cityMap;
        if (dateTaskCreate != null) {
            List<Integer> idsCity = taskService.findIdCitiesTaskByIdCompanyAndDateCreate(idCompany, dateTaskCreate);
            cityMap = transformer.doCityTransformer(cityService.findCityByIdsAndIdCompany(idCompany, idsCity));
        } else {
            cityMap = Collections.emptyMap();
        }
        
        List<Task> ownTaskList;
        if (idCity != null && dateTaskCreate != null)
            ownTaskList = taskService.findOwnTaskByIdCompanyAndIdCityAndDateCreate(idCompany, idCity, dateTaskCreate);
        else
            ownTaskList = Collections.emptyList();
        
        List<Task> otherTaskList;
        if (idCity != null && idOwnTask != null)
            otherTaskList = taskService.findOtherTaskByIdCompanyAndIdTemplateAndIdCity(idCompany, idOwnTask, idCity);
        else
            otherTaskList = Collections.emptyList();
        
        Long recordsCount = reportService.countReportHistoryByIdCompanyAndDateAndIdCityAndIdTasks(idCompany, dateTaskCreate, idCity, idOwnTask, idsOtherTasks);
        Integer pageCount = pagerUtilz.getPageCount(recordsCount, recordsOnPage);
        page = pagerUtilz.getPage(page, pageCount);
        
        List<ReportHistory> reportList = reportService.findReportHistoryByIdCompanyAndDateAndIdCityAndIdTasks(idCompany, dateTaskCreate, idCity, idOwnTask, idsOtherTasks, page, recordsOnPage);
        List<Promo> promoList = promoService.findPromosByIdCompany(idCompany);
        
        ModelAndView m = new ModelAndView("report");
        m.addObject("pageName", "report");
        m.addObject("reportList", reportList);
        m.addObject("cityMap", cityMap);
        m.addObject("ownTaskList", ownTaskList);
        m.addObject("otherTaskList", otherTaskList);
        m.addObject("promoList", promoList);
        m.addObject("rootUrl", coreSettings.getRootUrlReport());
        m.addObject("idReport", idReport);
        m.addObject("recordsCount", recordsCount);
        m.addObject("pageCount", pageCount);
        m.addObject("page", page);
        
        return m;
    }
    
    @RequestMapping(value = "generate", method = RequestMethod.POST)
    public String reportGenerate(HttpSession session, @RequestParam(value = "filter_task_create_date", required = false) String taskDateCreate, @RequestParam(value = "filter_city_id", required = false) Integer idCity,
            @RequestParam(value = "filter_own_task_id", required = false) Long idOwnTask, @RequestParam(value = "filter_other_task_id[]", required = false) List<Long> idsOtherTasks,
            @RequestParam(value = "filter_promo_id[]", required = false) List<Integer> idPromoList, @RequestParam(value = "filter_use_photo", required = false) Boolean withoutPhoto) throws IOException {
        log.info("#ReportGenerate POST method(idCompany:" + idCompany + ",withoutPhoto:" + withoutPhoto + ",taskDateCreate:" + taskDateCreate + ",idCity:" + idCity + ",idOwnTask:" + idOwnTask + ",idsOtherTasks:" + idsOtherTasks + ",idPromo:"
                + idPromoList + ")#");
        
        session.setAttribute("reportTaskDate", taskDateCreate);
        session.setAttribute("idCityReportSaved", idCity);
        session.setAttribute("idOwnTaskReportSaved", idOwnTask);
        session.setAttribute("idOtherTaskReportSaved", idsOtherTasks);
        session.setAttribute("idPromoReportSaved", idPromoList);
        session.setAttribute("withoutPhoto", withoutPhoto);
        
        if (taskDateCreate == null || idOwnTask == null || idsOtherTasks == null || idsOtherTasks.size() == 0) {
            return "redirect:/report";
        } else {
            DateTime dt = new DateTime();
            String dirDate = LocalDate.now().toString();
            String fileName = fmt.print(dt) + "_report.xls";
            
            File dir = fileUtilz.createDirectory(coreSettings.getPathForReport() + dirDate);
            File file = new File(dir.getAbsolutePath() + "/" + fileName);
            
            TupleHolder<Map<Long, String>, Map<ReportArticleData, Map<Long, TaskArticle>>> tuple = reportService.getTaskData(idCompany, idOwnTask, idsOtherTasks);
            Map<Long, String> headers = tuple.getValue1();
            Map<ReportArticleData, Map<Long, TaskArticle>> map = tuple.getValue2();
            
            if (idPromoList == null)
                idPromoList = Collections.emptyList();
            boolean isWithoutPromo = idPromoList.contains(-1);
            
            reportBuilder.process(file, headers, map, idOwnTask, idsOtherTasks, isWithoutPromo, idPromoList, !BooleanUtils.isTrue(withoutPhoto));
            
            long fileSize = FileUtils.sizeOf(file);
            
            ReportHistory reportHistory = new ReportHistory();
            reportHistory.setIdCompany(idCompany);
            reportHistory.setCaption("Отчет за " + taskDateCreate);
            reportHistory.setFilePath(dirDate + "/" + fileName);
            reportHistory.setFileSize(fileSize);
            reportHistory.setActive(true);
            reportHistory.setDateAdded(DateTime.now());
            reportHistory.setIdTask(idOwnTask);
            reportHistory.setTaskDate(LocalDate.parse(taskDateCreate));
            reportHistory.setIdCity(idCity);
            reportHistory.setIdsTaskOther(String.valueOf(idsOtherTasks));
            if (idPromoList != null)
                reportHistory.setIdsPromo(String.valueOf(idPromoList));
            mainService.save(reportHistory);
            
            return "redirect:/report?id=" + reportHistory.getId();
        }
    }
    
    @RequestMapping(value = "reset")
    public String reportReset(HttpSession session) {
        log.info("#ReportReset method(idCompany:" + idCompany + ")#");
        session.removeAttribute("reportTaskDate");
        session.removeAttribute("idCityReportSaved");
        session.removeAttribute("idOwnTaskReportSaved");
        session.removeAttribute("idOtherTaskReportSaved");
        session.removeAttribute("idPromoReportSaved");
        session.removeAttribute("withoutPhoto");
        return "redirect:/report";
    }
    
    @RequestMapping("{id}/delete")
    public String reportDelete(@PathVariable("id") Long idReport, @RequestParam(value = "page", required = false, defaultValue = "1") Integer page) {
        log.info("#ReportDelete method(idCompany:" + idCompany + ",idReport:" + idReport + ",page:" + page + ")#");
        if (idReport != null && idReport > 0)
            reportService.deleteReportHistory(idCompany, idReport);
        return "redirect:/report?page=" + page;
    }
    
}
