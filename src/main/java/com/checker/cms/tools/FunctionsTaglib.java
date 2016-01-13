package com.checker.cms.tools;

import java.util.Collection;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FunctionsTaglib {
    
    public static boolean containsInt(Collection<Integer> coll, Integer o) {
        return coll != null && coll.contains(o);
    }
    
    public static boolean containsLong(Collection<Long> coll, Long o) {
        return coll != null && coll.contains(o);
    }
}
