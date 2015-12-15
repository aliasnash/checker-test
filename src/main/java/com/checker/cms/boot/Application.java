package com.checker.cms.boot;


// @Slf4j
// @Import({ SpringRootConfig.class })
// @Configuration
public class Application /* extends SpringBootServletInitializer */{
    
    // public static void main(String[] args) {
    // SpringApplication.run(Application.class, args);
    // }
    //
    // @PostConstruct
    // public void init() {
    // log.info("###Application loaded!###");
    // }
    //
    // // Used when deploying to a standalone servlet container, i.e. tomcat
    // @Override
    // protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
    // return application.sources(Application.class);
    // }
    //
    // @Bean
    // public ServletRegistrationBean servlet(ApplicationContext context) {
    // ServletRegistrationBean servlet = new ServletRegistrationBean(new DispatcherServlet(), "/");
    // servlet.addInitParameter("contextClass", "org.springframework.web.context.support.AnnotationConfigWebApplicationContext");
    // servlet.addInitParameter("contextConfigLocation", "com.checker.cms.config.SpringWebConfig");
    // servlet.setLoadOnStartup(1);
    // return servlet;
    // }
    //
    // @Bean
    // public EmbeddedServletContainerFactory servletContainer() {
    // TomcatEmbeddedServletContainerFactory factory = new TomcatEmbeddedServletContainerFactory(9091);
    // factory.addConnectorCustomizers(new TomcatConnectorCustomizer() {
    // @Override
    // public void customize(Connector connector) {
    // connector.setURIEncoding("UTF-8");
    // connector.setMaxPostSize(4388608);
    // connector.setUseBodyEncodingForURI(true);
    // }
    // });
    // return factory;
    // }
}
