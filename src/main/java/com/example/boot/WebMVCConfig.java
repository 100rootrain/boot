//package com.example.boot;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//import org.thymeleaf.TemplateEngine;
//import org.thymeleaf.templatemode.TemplateMode;
//import org.thymeleaf.templateresolver.ClassLoaderTemplateResolver;
//
//@Configuration
//public class WebMVCConfig implements WebMvcConfigurer {
//
//    @Bean
//    public ClassLoaderTemplateResolver thymeleafTemplateResolver(){
//        ClassLoaderTemplateResolver resolver = new ClassLoaderTemplateResolver();
//        resolver.setPrefix("templates/");
//        resolver.setSuffix(".html");
//        resolver.setTemplateMode(TemplateMode.HTML);
//        resolver.setCacheable(false);
//        resolver.setCharacterEncoding("UTF-8");
//        return resolver;
//    }
//
//    @Bean
//    public TemplateEngine customTemplateEngine() {
//        TemplateEngine templateEngine = new TemplateEngine();
//        templateEngine.setTemplateResolver(thymeleafTemplateResolver());
//        return templateEngine;
//    }
//
//}