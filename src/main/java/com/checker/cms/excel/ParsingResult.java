package com.checker.cms.excel;

import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ParsingResult {
    
    private String       fileName;
    
    private int          totalAdded        = 0;
    private int          withoutPriceAdded = 0;
    
    private int          categoryAdded     = 0;
    private int          goodAdded         = 0;
    private int          articleAdded      = 0;
    
    private List<String> notAdded          = new ArrayList<>();
    
    public void totalAdded() {
        totalAdded++;
    }
    
    public void withoutPriceAdded() {
        withoutPriceAdded++;
    }
    
    public void categoryAdded() {
        categoryAdded++;
    }
    
    public void goodAdded() {
        goodAdded++;
    }
    
    public void articleAdded() {
        articleAdded++;
    }
    
    public void addNotAdded(String error) {
        notAdded.add(error);
    }
}
