package com.checker.cms.tools;

import java.io.Writer;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PaginationTaglib extends SimpleTagSupport {
    
    private int    page;
    private int    pageCount;
    private int    paginatorSize = 10;
    private String uri;
    private String previous      = "Previous";
    private String next          = "Next";
                                 
    private Writer getWriter() {
        JspWriter out = getJspContext().getOut();
        return out;
    }
    
    @Override
    public void doTag() throws JspException {
        Writer out = getWriter();
        
        try {
            out.write("<nav>");
            out.write("<ul class=\"pagination\">");
            
            if (page <= 1)
                out.write(constructLink(1, previous, "disabled", true));
            else
                out.write(constructLink(page - 1, previous, null, false));
                
            int paginatorBegin = 0;
            if (page % paginatorSize == 0)
                paginatorBegin = (page - 1) / paginatorSize * paginatorSize + 1;
            else
                paginatorBegin = page / paginatorSize * paginatorSize + 1;
                
            int paginatorEnd = paginatorBegin + paginatorSize - 1;
            if (paginatorEnd > pageCount)
                paginatorEnd = pageCount;
                
            for (int itr = paginatorBegin; itr <= paginatorEnd; itr++) {
                if (page == itr)
                    out.write(constructLink(itr, String.valueOf(itr), "active", true));
                else
                    out.write(constructLink(itr, String.valueOf(itr), null, false));
            }
            
            if (page >= pageCount)
                out.write(constructLink(pageCount, next, "disabled", true));
            else
                out.write(constructLink(page + 1, next, null, false));
                
            out.write("</ul>");
            out.write("</nav>");
        } catch (java.io.IOException ex) {
            throw new JspException("Error in Paginator tag", ex);
        }
    }
    
    private String constructLink(int page, String text, String className, boolean disabled) {
        StringBuilder link = new StringBuilder("<li");
        if (className != null) {
            link.append(" class=\"");
            link.append(className);
            link.append("\"");
        }
        if (disabled)
            link.append(">").append("<a href=\"#\">" + text + "</a></li>");
        else
            link.append(">").append("<a href=\"" + uri + "?page=" + page + "\">" + text + "</a></li>");
        return link.toString();
    }
    
}
