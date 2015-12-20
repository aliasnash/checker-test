package com.checker.cms.controllers;

import java.util.List;

import javax.annotation.Resource;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.checker.core.dao.service.ArticleService;
import com.checker.core.dao.service.CategoryService;
import com.checker.core.dao.service.GoodsService;
import com.checker.core.entity.Article;
import com.checker.core.entity.Category;
import com.checker.core.entity.Good;

@Slf4j
@Controller
@RequestMapping("category")
public class CategoryController {
    
    @Resource
    private CategoryService categoryService;
    @Resource
    private GoodsService    goodsService;
    @Resource
    private ArticleService  articleService;
    
    private Integer         idCompany = 1;
    
    @RequestMapping("list")
    public ModelAndView categoryList() {
        log.info("#CategoryList method(idCompany:" + idCompany + ")#");
        List<Category> categoryList = categoryService.findCategoryByIdCompany(idCompany);
        ModelAndView m = new ModelAndView("category");
        m.addObject("pageName", "category");
        m.addObject("categoryList", categoryList);
        return m;
    }
    
    @RequestMapping("{id}/delete")
    public String categoryDelete(@PathVariable("id") Long idCategory) {
        log.info("#CategoryDelete method(idCompany:" + idCompany + ",idCategory:" + idCategory + ")#");
        if (idCategory != null && idCategory > 0)
            categoryService.deleteCategory(idCompany, idCategory);
        return "redirect:/category/list";
    }
    
    @RequestMapping(value = "top/reset")
    public String categoryTopReset() {
        log.info("#CategoryTopReset method(idCompany:" + idCompany + ")#");
        articleService.categoryTopReset(idCompany);
        return "redirect:/category/list";
    }
    
    @RequestMapping(value = "update", method = RequestMethod.POST)
    public String categoryUpdate(@RequestParam("id") Long idCategory, @RequestParam("name") String caption) {
        log.info("#CategoryUpdate method(idCompany:" + idCompany + ",idCategory:" + idCategory + ",caption:" + caption + ")#");
        if (StringUtils.isNotEmpty(caption)) {
            if (idCategory != null && idCategory > 0) {
                categoryService.updateCategory(idCompany, idCategory, caption);
            } else {
                Category category = new Category();
                category.setIdCompany(idCompany);
                category.setCaption(caption);
                category.setDateAdded(DateTime.now());
                categoryService.saveCategory(category);
            }
        }
        return "redirect:/category/list";
    }
    
    @RequestMapping("{id}/goods/list")
    public ModelAndView goodsList(@PathVariable("id") Long idCategory) {
        log.info("#GoodsList method(idCompany:" + idCompany + ",idCategory:" + idCategory + ")#");
        List<Good> goodsList = goodsService.findGoodsByIdCategory(idCategory);
        Category category = categoryService.findCategoryByIdAndIdCompany(idCompany, idCategory);
        ModelAndView m = new ModelAndView("goods");
        m.addObject("pageName", "goods");
        m.addObject("category", category);
        m.addObject("goodsList", goodsList);
        return m;
    }
    
    @RequestMapping("{idc}/{idg}/delete")
    public String goodsDelete(@PathVariable("idc") Long idCategory, @PathVariable("idg") Long idGoods) {
        log.info("#GoodsDelete method(idCompany:" + idCompany + ",idCategory:" + idCategory + ",idGoods:" + idGoods + ")#");
        if (idCategory != null && idCategory > 0 && idGoods != null && idGoods > 0) {
            goodsService.deleteGoods(idCompany, idCategory, idGoods);
            return "redirect:/category/{idc}/goods/list";
        } else {
            return "redirect:/category/list";
        }
    }
    
    @RequestMapping(value = "{idc}/goods/update", method = RequestMethod.POST)
    public String goodsUpdate(@PathVariable("idc") Long idCategory, @RequestParam("id") Long idGoods, @RequestParam("name") String caption) {
        log.info("#GoodsUpdate method(idCompany:" + idCompany + ",idCategory:" + idCategory + ",idGoods:" + idGoods + ",caption:" + caption + ")#");
        if (StringUtils.isNotEmpty(caption)) {
            if (idGoods != null && idGoods > 0) {
                goodsService.updateGoods(idCompany, idCategory, idGoods, caption);
            } else {
                Good goods = new Good();
                goods.setIdCategory(idCategory);
                goods.setCaption(caption);
                goods.setDateAdded(DateTime.now());
                goodsService.saveGoods(goods);
            }
        }
        return "redirect:/category/{idc}/goods/list";
    }
    
    @RequestMapping("{idc}/{idg}/article/list")
    public ModelAndView articleList(@PathVariable("idc") Long idCategory, @PathVariable("idg") Long idGoods) {
        log.info("#ArticleList method(idCompany:" + idCompany + ",idCategory:" + idCategory + ",idGoods:" + idGoods + ")#");
        List<Article> articleList = articleService.findArticlesByIdGood(idGoods);
        Good goods = goodsService.findGoodById(idGoods);
        ModelAndView m = new ModelAndView("article");
        m.addObject("pageName", "article");
        m.addObject("goods", goods);
        m.addObject("articleList", articleList);
        return m;
    }
    
    @RequestMapping(value = "/{idc}/{idg}/article/update", method = RequestMethod.POST)
    public String articleUpdate(@PathVariable("idc") Long idCategory, @PathVariable("idg") Long idGoods, @RequestParam("id") Long idArticle, @RequestParam("code") String articleCode, @RequestParam("name") String caption,
            @RequestParam(value = "top_product", required = false) Boolean topProduct) {
        log.info("#ArticleUpdate method(idCompany:" + idCompany + ",idCategory:" + idCategory + ",idGoods:" + idGoods + ",idArticle:" + idArticle + ",article:" + articleCode + ",caption:" + caption + ",topProduct:" + topProduct + ")#");
        if (topProduct == null)
            topProduct = false;
        if (StringUtils.isNotEmpty(caption)) {
            if (idArticle != null && idArticle > 0) {
                articleService.updateArticle(idArticle, articleCode, caption, topProduct);
            } else {
                Article article = new Article();
                article.setIdGood(idGoods);
                article.setArticleCode(articleCode);
                article.setCaption(caption);
                article.setTopProduct(topProduct);
                article.setDateAdded(DateTime.now());
                articleService.saveArticle(article);
            }
        }
        return "redirect:/category/{idc}/{idg}/article/list";
    }
    
    // /{idc}/{idg}/{ida}/delete
    @RequestMapping("{idc}/{idg}/{ida}/delete")
    public String articleDelete(@PathVariable("idc") Long idCategory, @PathVariable("idg") Long idGoods, @PathVariable("ida") Long idArticle) {
        log.info("#ArticleDelete method(idCompany:" + idCompany + ",idCategory:" + idCategory + ",idGoods:" + idGoods + ")#");
        if (idCategory != null && idCategory > 0 && idGoods != null && idGoods > 0 && idArticle != null && idArticle > 0) {
            articleService.deleteArticle(idCompany, idGoods, idArticle);
            return "redirect:/category/{idc}/{idg}/article/list";
        } else {
            return "redirect:/category/{idc}/goods/list";
        }
    }
    
}
