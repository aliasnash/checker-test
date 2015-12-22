package com.checker.cms.utils;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

import org.springframework.stereotype.Component;

import com.checker.core.entity.Category;
import com.checker.core.entity.Good;
import com.checker.core.entity.TaskTemplateArticle;
import com.checker.core.model.StateObject;
import com.checker.core.model.TemplateArticleObject;
import com.checker.core.model.TemplateCategoryObject;
import com.checker.core.model.TemplateGoodsObject;
import com.google.gson.Gson;

@Slf4j
@Component
public class JsonTransformer {
    
    @Resource
    private Gson gson;
    
    public String process(List<TaskTemplateArticle> templateArticleList) {
        Map<Category, Map<Good, List<TaskTemplateArticle>>> data = transformToMap(templateArticleList);
        String result = transformToJson(data);
        log.debug(result);
        return result;
    }
    
    private String transformToJson(Map<Category, Map<Good, List<TaskTemplateArticle>>> data) {
        int goodCount = 0;
        int articleCount = 0;
        
        LinkedList<TemplateCategoryObject> result = new LinkedList<>();
        
        for (Map.Entry<Category, Map<Good, List<TaskTemplateArticle>>> categoryMap : data.entrySet()) {
            Category category = categoryMap.getKey();
            LinkedList<TemplateGoodsObject> categoryNodes = new LinkedList<>();
            goodCount = 0;
            articleCount = 0;
            
            for (Map.Entry<Good, List<TaskTemplateArticle>> goodMap : categoryMap.getValue().entrySet()) {
                Good good = goodMap.getKey();
                goodCount++;
                
                LinkedList<TemplateArticleObject> goodNodes = new LinkedList<>();
                
                for (TaskTemplateArticle templateArticle : goodMap.getValue()) {
                    articleCount++;
                    goodNodes.add(new TemplateArticleObject(templateArticle.getArticle().getCaption(), templateArticle.getIdArticle(), new StateObject(true)));
                }
                
                List<String> goodTags = new LinkedList<>(Arrays.asList("артикулов " + goodNodes.size()));
                categoryNodes.add(new TemplateGoodsObject(good.getCaption(), good.getId(), new StateObject(true), goodTags, goodNodes));
            }
            
            List<String> categoryTags = new LinkedList<>(Arrays.asList("артикулов " + articleCount, "товаров " + goodCount));
            result.add(new TemplateCategoryObject(category.getCaption(), category.getId(), new StateObject(true), categoryTags, categoryNodes));
        }
        
        return gson.toJson(result);
    }
    
    private Map<Category, Map<Good, List<TaskTemplateArticle>>> transformToMap(List<TaskTemplateArticle> templateArticleList) {
        Map<Category, Map<Good, List<TaskTemplateArticle>>> mapCategory = new LinkedHashMap<>();
        
        for (TaskTemplateArticle article : templateArticleList) {
            Good good = article.getArticle().getGood();
            Category category = article.getArticle().getGood().getCategory();
            
            Map<Good, List<TaskTemplateArticle>> mapGood = mapCategory.get(category);
            if (mapGood == null) {
                mapGood = new LinkedHashMap<>();
                mapCategory.put(category, mapGood);
            }
            
            List<TaskTemplateArticle> listArticle = mapGood.get(good);
            if (listArticle == null) {
                listArticle = new LinkedList<>();
                mapGood.put(good, listArticle);
            }
            
            listArticle.add(article);
        }
        return mapCategory;
    }
}
