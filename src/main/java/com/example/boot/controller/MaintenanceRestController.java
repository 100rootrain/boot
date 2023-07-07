package com.example.boot.controller;

import com.example.boot.service.MaintenanceService;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

@RestController
public class MaintenanceRestController {
    private final static Logger logger = LoggerFactory.getLogger(MaintenanceRestController.class);
    private final MaintenanceService maintenanceService;

    public MaintenanceRestController(MaintenanceService maintenanceService) {
        this.maintenanceService = maintenanceService;
    }


    @RequestMapping(value = "/getMaintenanceList", method = RequestMethod.GET)
    public ArrayList<HashMap<String, Object>> getMaintenanceList(@RequestParam String startPeriod, @RequestParam String endPeriod, @RequestParam String mngStatus, @RequestParam String descSearch, Locale locale, Model model) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("startPeriod", startPeriod);
        map.put("endPeriod", endPeriod);
        map.put("mngStatus", mngStatus);
        map.put("descSearch", descSearch);

        ArrayList<HashMap<String, Object>> getMaintenanceList = maintenanceService.getMaintenanceList(map);

        return getMaintenanceList;
    }

    @RequestMapping(value = "/getMaintenanceInfoPopup", method = RequestMethod.GET)
    public String getMaintenanceInfoPopup(@RequestParam String mngCode, @RequestParam String mngSeq, Locale locale, Model model) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("mngCode", mngCode);
        map.put("mngSeq", mngSeq);
        HashMap<String, Object> result = maintenanceService.getMaintenanceInfoPopup(map);
        model.addAttribute("result",result);
        logger.info("========>result"+result);

        return "getMaintenanceInfoPopup";
    }


}
