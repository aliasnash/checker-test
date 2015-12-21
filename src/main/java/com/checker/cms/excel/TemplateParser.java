package com.checker.cms.excel;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.joda.time.DateTime;
import org.joda.time.LocalDate;
import org.springframework.stereotype.Component;

import com.checker.core.dao.service.ArticleService;
import com.checker.core.dao.service.CategoryService;
import com.checker.core.dao.service.CheckerService;
import com.checker.core.dao.service.GoodsService;
import com.checker.core.dao.service.TemplateService;
import com.checker.core.entity.Article;
import com.checker.core.entity.Category;
import com.checker.core.entity.Good;
import com.checker.core.entity.TaskTemplate;
import com.checker.core.entity.TaskTemplateArticle;

@Slf4j
@Component
public class TemplateParser {
    
    @Resource
    private CheckerService  checkerService;
    @Resource
    private ArticleService  articleService;
    @Resource
    private GoodsService    goodsService;
    @Resource
    private CategoryService categoryService;
    @Resource
    private TemplateService templateService;
    
    @Getter
    @Setter
    @ToString
    @AllArgsConstructor
    private static class Product {
        private String category;
        private String good;
        private String articul;
        private String desc;
        private Double price;
    }
    
    public ParsingResult process(Integer idCompany, File file, String caption, boolean usePrice) throws IOException {
        ParsingResult result = new ParsingResult();
        String filePath = file.getAbsolutePath();
        String fileName = file.getName();
        BufferedInputStream buffer = null;
        Workbook workbook = null;
        List<Product> added = new ArrayList<>();
        
        try {
            log.info("processing file:" + filePath);
            buffer = new BufferedInputStream(new FileInputStream(file));
            
            if (fileName.endsWith(".xlsx"))
                workbook = new XSSFWorkbook(buffer);
            else
                workbook = new HSSFWorkbook(buffer);
            
            Sheet sheet = workbook.getSheetAt(0);
            Iterator<Row> rowIterator = sheet.iterator();
            while (rowIterator.hasNext()) {
                Row row = rowIterator.next();
                
                String category = convertToString(row.getCell(0));
                String good = convertToString(row.getCell(1));
                String articul = convertToString(row.getCell(2));
                String desc = convertToString(row.getCell(3));
                Double price = convertToDouble(row.getCell(4));
                
                try {
                    Integer.valueOf(articul);
                    if (category != null && good != null && desc != null) {
                        Product p = new Product(category.trim(), good.trim(), articul, desc.trim(), price);
                        if (price == null)
                            result.withoutPriceAdded();
                        
                        if (usePrice && price == null)
                            result.addNotAdded("Строка:" + (row.getRowNum() + 1) + ", ОШИБКА:не указана цена (артикул:" + articul + ",категория:" + category + ")");
                        else
                            added.add(p);
                    } else {
                        result.addNotAdded("Строка:" + (row.getRowNum() + 1) + ", ОШИБКА:не заполненые данные (категория:" + category + ",товар:" + good + ",описание:" + desc + ")");
                    }
                } catch (Exception e) {
                    result.addNotAdded("Строка:" + (row.getRowNum() + 1) + ", ОШИБКА:" + e.getMessage());
                }
            }
        } finally {
            buffer.close();
            workbook.close();
        }
        
        if ((!usePrice || (usePrice && result.getWithoutPriceAdded() == 0)) && added.size() > 0) {
            generateTemplate(idCompany, filePath, fileName, caption, added, result);
        }
        
        log.info(String.valueOf(result));
        return result;
    }
    
    @Transactional
    private void generateTemplate(Integer idCompany, String filepath, String filename, String caption, List<Product> products, ParsingResult result) {
        TaskTemplate template = new TaskTemplate();
        template.setIdCompany(idCompany);
        template.setCaption(caption);
        template.setFileName(filename);
        template.setFilePath(filepath);
        template.setDateAdded(DateTime.now());
        template.setCurrentDate(LocalDate.now());
        templateService.saveTemplate(template);
        
        for (Product p : products) {
            log.debug("parsing product:" + p);
            
            Article article = articleService.findArticleByCode(idCompany, p.getArticul());
            if (article == null) {
                Good good = goodsService.findGoodByCaption(idCompany, p.getGood());
                if (good == null) {
                    Category category = categoryService.findCategoryByCaption(idCompany, p.getCategory());
                    if (category == null) {
                        category = new Category();
                        category.setCaption(p.getCategory());
                        category.setIdCompany(idCompany);
                        category.setDateAdded(DateTime.now());
                        categoryService.saveCategory(category);
                        result.categoryAdded();
                    }
                    good = new Good();
                    good.setIdCategory(category.getId());
                    good.setCategory(category);
                    good.setCaption(p.getGood());
                    good.setDateAdded(DateTime.now());
                    goodsService.saveGoods(good);
                    result.goodAdded();
                }
                article = new Article();
                article.setIdGood(good.getId());
                article.setGood(good);
                article.setCaption(p.getDesc());
                article.setArticleCode(p.getArticul());
                article.setTopProduct(false);
                article.setDateAdded(DateTime.now());
                articleService.saveArticle(article);
                result.articleAdded();
            }
            
            TaskTemplateArticle art = new TaskTemplateArticle();
            art.setIdTemplate(template.getId());
            art.setIdArticle(article.getId());
            art.setDescription(p.getDesc());
            art.setPrice(p.getPrice());
            templateService.saveTemplateArticle(art);
            result.totalAdded();
        }
    }
    
    private String convertToString(Cell c) {
        String res = null;
        if (c != null) {
            switch (c.getCellType()) {
                case Cell.CELL_TYPE_NUMERIC:
                    res = String.valueOf((int) c.getNumericCellValue());
                    break;
                case Cell.CELL_TYPE_STRING:
                    res = c.getStringCellValue();
                    break;
            }
        }
        return res;
    }
    
    private Double convertToDouble(Cell c) {
        Double res = null;
        try {
            switch (c.getCellType()) {
                case Cell.CELL_TYPE_BLANK:
                    res = null;
                    break;
                case Cell.CELL_TYPE_NUMERIC:
                    res = Double.valueOf(c.getNumericCellValue());
                    break;
                case Cell.CELL_TYPE_STRING:
                    res = Double.valueOf(c.getStringCellValue());
                    break;
            }
        } catch (Exception e) {}
        return res;
    }
}
