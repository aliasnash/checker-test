package com.checker.cms.task;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TaskUploadResult {
    
    private boolean templateError;
    private boolean marketError;
    private boolean userError;
                    
    private boolean hasError;
                    
    public void templateError() {
        templateError = true;
        hasError = true;
    }
    
    public void marketError() {
        marketError = true;
        hasError = true;
    }
    
    public void userError() {
        userError = true;
        hasError = true;
    }
    
}
