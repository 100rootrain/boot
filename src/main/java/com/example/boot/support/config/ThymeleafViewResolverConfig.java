//package com.example.boot.support.config;
//
//import nz.net.ultraq.thymeleaf.layoutdialect.LayoutDialect;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.MessageSource;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.core.Ordered;
//import org.springframework.core.env.Environment;
//import org.springframework.web.servlet.ViewResolver;
//import org.thymeleaf.spring6.SpringTemplateEngine;
//import org.thymeleaf.spring6.templateresolver.SpringResourceTemplateResolver;
//import org.thymeleaf.spring6.view.ThymeleafViewResolver;
//
//@Configuration
//public class ThymeleafViewResolverConfig {
//    @Autowired
//    private Environment env;
//
//    @Bean
//    public SpringResourceTemplateResolver templateResolver() {
//        SpringResourceTemplateResolver templateResolver = new SpringResourceTemplateResolver();
//        templateResolver.setPrefix("classpath:/templates/");
//        templateResolver.setSuffix(".html");
//        templateResolver.setCharacterEncoding("UTF-8");
//        templateResolver.setCacheable(false);
//        return templateResolver;
//    }
//
//    @Bean
//    public LayoutDialect layoutDialect() {
//        return new LayoutDialect();
//    }
//    @Bean
//    public SpringTemplateEngine templateEngine() {
//        SpringTemplateEngine templateEngine = new SpringTemplateEngine();
//        templateEngine.setTemplateResolver(templateResolver());
//        templateEngine.addDialect(layoutDialect());
//        return templateEngine;
//    }
//
//
//
//
//    @Bean
//    public ViewResolver viewResolver() {
//        ThymeleafViewResolver viewResolver = new ThymeleafViewResolver();
//
//        viewResolver.setTemplateEngine(templateEngine());
//        viewResolver.setCharacterEncoding("UTF-8");
//        viewResolver.setOrder(0);
////        viewResolver.setOrder(Ordered.HIGHEST_PRECEDENCE);
////
////        String[] viewNames = new String[]{"/index",""
////
////        };
////        viewResolver.setViewNames(viewNames);
//        return viewResolver;
//    }
//}
