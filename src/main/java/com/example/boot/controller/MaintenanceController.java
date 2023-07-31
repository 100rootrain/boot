package com.example.boot.controller;

import com.example.boot.service.MaintenanceService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;


@Controller
public class MaintenanceController {
    private final static Logger logger = LoggerFactory.getLogger(MaintenanceController.class);
    private final MaintenanceService maintenanceService;

    public MaintenanceController(MaintenanceService maintenanceService) {
        this.maintenanceService = maintenanceService;
    }

    @RequestMapping(value = "/maintenance", method = RequestMethod.GET)
    public String maintenance(Locale locale, Model model) {
        ArrayList<HashMap<String, Object>> stateList = maintenanceService.getStateList();
        model.addAttribute("stateList", stateList);

        return "maintenance";
    }

    @RequestMapping(value = "/maintenanceInfoPopup", method = RequestMethod.GET)
    public String maintenanceInfoPopup(Locale locale, Model model) {
        ArrayList<HashMap<String, Object>> stateList = maintenanceService.getStateList();
        model.addAttribute("stateList", stateList);
        return "maintenanceInfoPopup";
    }

    //코드현황
    @RequestMapping(value="/maintenanceCodeList", method = RequestMethod.GET)
    public String maintenanceCodeList(Locale locale, Model model){
        return "maintenanceCodeList";
    }


}
