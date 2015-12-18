package com.checker.cms.config;

import javax.annotation.PostConstruct;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@EnableWebMvc
@Configuration
@Import({ MvcViewConfig.class })
@ComponentScan(basePackages = "com.checker.cms")
public class MvcCoreConfig extends WebMvcConfigurerAdapter {
    
    @PostConstruct
    public void init() {
        log.info("###MvcCoreConfig loaded!###");
    }
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }
    
    @Override
    public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
        configurer.ignoreAcceptHeader(true).defaultContentType(MediaType.TEXT_HTML);
    }
    
    @Bean
    public TilesConfigurer tilesConfigurer() {
        TilesConfigurer tilesConfigurer = new TilesConfigurer();
        tilesConfigurer.setCheckRefresh(true);
        tilesConfigurer.setDefinitions("/WEB-INF/tiles/tiles-definitions.xml");
        return tilesConfigurer;
    }
    
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("home");
    }
    
    /**
     * Resolves specific types of exceptions to corresponding logical view names
     * for error views.
     * 
     * <p>
     * View name resolved using bean of type InternalResourceViewResolver
     * (declared in {@link SpringWebConfig}).
     */
    // @Override
    // public void configureHandlerExceptionResolvers(List<HandlerExceptionResolver> exceptionResolvers) {
    // SimpleMappingExceptionResolver exceptionResolver = new SimpleMappingExceptionResolver();
    // exceptionResolver.setDefaultErrorView("exception");
    // // needed otherwise exceptions won't be logged anywhere
    // exceptionResolver.setWarnLogCategory("error");
    // exceptionResolvers.add(exceptionResolver);
    // }
}
