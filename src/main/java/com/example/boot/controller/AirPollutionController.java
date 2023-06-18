package com.example.boot.controller;


import com.example.boot.service.AirPollutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

@Controller
public class AirPollutionController {

    private final AirPollutionService airPollutionService;

    public  AirPollutionController(AirPollutionService airPollutionService){
        this.airPollutionService=airPollutionService;
    }

    @RequestMapping(value = "/airPollution", method = RequestMethod.GET)
    public String airPollution(Locale locale, Model model) { // INNERHTML
        ArrayList<HashMap<String, Object>> locationList = airPollutionService.getLocationList();

        model.addAttribute("locationList", locationList);

        return "airPollution";
    }



    @RequestMapping("/")
    public String hello() {
        return "index";
    }

    @RequestMapping("/happy")
    public String happy() {
        return "happy";
    }

    @RequestMapping("/sad")
    public String sad() {
        return "sad";
    }

    @RequestMapping("/jsptest")
    public ModelAndView jsptest() {
        ModelAndView mv = new ModelAndView();
        mv.addObject("name", "pooney.jsp");
        mv.setViewName("jsptest");
        return mv;
    }

    @RequestMapping("/thymetest")
    public String thymetest(Model model) {
        model.addAttribute("name", "pooney.th");
        return "thymeleaf/thymeleaftest";

    }

}
