package com.checker.cms.config;

import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.Jackson2ObjectMapperFactoryBean;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.fasterxml.jackson.databind.ObjectMapper;

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
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("home");
        registry.addViewController("/photo").setViewName("photo");
    }
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }
    
//    @Bean
//    public TilesConfigurer tilesConfigurer() {
//        TilesConfigurer tilesConfigurer = new TilesConfigurer();
//        tilesConfigurer.setCheckRefresh(true);
//        tilesConfigurer.setDefinitions("/WEB-INF/tiles/tiles-definitions.xml");
//        return tilesConfigurer;
//    }
    
    @Override
    public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
        configurer.ignoreAcceptHeader(true);
        configurer.defaultContentType(MediaType.TEXT_HTML);
        configurer.mediaType("xml", MediaType.APPLICATION_XML);
        configurer.mediaType("json", MediaType.APPLICATION_JSON);
    }
    
    @Bean
    public Jackson2ObjectMapperFactoryBean jackson2ObjectMapperFactoryBean() {
        Jackson2ObjectMapperFactoryBean bean = new Jackson2ObjectMapperFactoryBean();
        bean.setIndentOutput(true);
        bean.setSimpleDateFormat("yyyy-MM-dd");
        return bean;
    }
    
    @Bean
    public ObjectMapper objectMapper() {
        ObjectMapper objectMapper = jackson2ObjectMapperFactoryBean().getObject();
        objectMapper.registerModule(new com.fasterxml.jackson.datatype.joda.JodaModule());
        return objectMapper;
    }
    
    @Bean
    public MappingJackson2HttpMessageConverter mappingJackson2HttpMessageConverter() {
        MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
        converter.setObjectMapper(objectMapper());
        return converter;
    }
    
    @Override
    public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
        converters.add(mappingJackson2HttpMessageConverter());
    }
    
    /**
     * Resolves specific types of exceptions to corresponding logical view names
     * for error views.
     * 
     * <p>
     * View name resolved using bean of type InternalResourceViewResolver (declared in {@link SpringWebConfig}).
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
