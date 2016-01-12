package com.checker.cms.tools;

import java.util.Collection;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FunctionsTaglib {
    
    public static boolean contains(Collection<?> coll, Object o) {
        return coll != null && coll.contains(o);
    }
}
