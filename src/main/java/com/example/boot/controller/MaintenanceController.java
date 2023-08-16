package com.example.boot.controller;

import com.example.boot.service.MaintenanceService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;


/**
 * The type Maintenance controller.
 */
@Controller
public class MaintenanceController {
    private final static Logger logger = LoggerFactory.getLogger(MaintenanceController.class);
    private final MaintenanceService maintenanceService;

    /**
     * Instantiates a new Maintenance controller.
     *
     * @param maintenanceService the maintenance service
     */
    public MaintenanceController(MaintenanceService maintenanceService) {
        this.maintenanceService = maintenanceService;
    }

    /**
     * Maintenance string.
     *
     * @param locale the locale
     * @param model  the model
     * @return the string
     */
    @RequestMapping(value = "/maintenance", method = RequestMethod.GET)
    public String maintenance(Locale locale, Model model) {
        ArrayList<HashMap<String, Object>> stateList = maintenanceService.getStateList();
        model.addAttribute("stateList", stateList);

        return "maintenance/maintenance";
    }

    /**
     * Maintenance info popup string.
     *
     * @param locale the locale
     * @param model  the model
     * @return the string
     */
    @RequestMapping(value = "/maintenanceInfoPopup", method = RequestMethod.GET)
    public String maintenanceInfoPopup(Locale locale, Model model) {
        ArrayList<HashMap<String, Object>> stateList = maintenanceService.getStateList();
        model.addAttribute("stateList", stateList);
        return "maintenance/maintenanceInfoPopup";
    }

    /**
     * 코드현황(조회 및 팝업)
     *
     * @param locale the locale
     * @param model  the model
     * @return the string
     */

    @RequestMapping(value="/maintenanceCodeList", method = RequestMethod.GET)
    public String maintenanceCodeList(Locale locale, Model model){
        return "maintenance/maintenanceCodeList";
    }

    /**
     * 회사, 요청자, 연락처 조회 팝업
     *
     * @param locale the locale
     * @param model  the model
     * @return the string
     */
    @RequestMapping(value="/maintenancePopupCodeList", method = RequestMethod.GET)
    public String maintenancePopupCodeList(Locale locale, Model model){
        return "maintenance/maintenancePopupCodeList";
    }


}
