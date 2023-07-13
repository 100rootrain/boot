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
import java.util.List;
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
    public HashMap<String, Object> getMaintenanceInfoPopup(@RequestParam String mngCode, @RequestParam String mngSeq) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("mngCode", mngCode);
        map.put("mngSeq", mngSeq);

        return maintenanceService.getMaintenanceInfoPopup(map);

    }

    @RequestMapping(value = "/insertMaintenanceInfoPopup", method = RequestMethod.POST)
    public void insertMaintenanceInfoPopup(@RequestParam String mngCode, @RequestParam String mngSeq,@RequestParam String mngCompany,
                                                              @RequestParam String mngContact,@RequestParam String mngSite,@RequestParam String mngBg,
                                                              @RequestParam String mngSystem,@RequestParam String mngType,@RequestParam String mngDescR,
                                                              @RequestParam String mngDescS,@RequestParam String mngStatus/*@RequestParam String mngStart,
                                                              @RequestParam String mngClose*/) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("mngCode", mngCode);
        map.put("mngSeq", mngSeq);
        map.put("mngCompany",mngCompany);
        map.put("mngContact",mngContact);
        map.put("mngSite",mngSite);
        map.put("mngBg",mngBg);
        map.put("mngSystem",mngSystem);
        map.put("mngType",mngType);
        map.put("mngDescR",mngDescR);
        map.put("mngDescS",mngDescS);
        map.put("mngStatus",mngStatus);
//        map.put("mngStart",mngStart);
//        map.put("mngClose",mngClose);

        maintenanceService.insertMaintenanceInfoPopup(map); // 게시판

    }

    @RequestMapping(value = "/getMaintenanceCodeList", method = RequestMethod.GET)
    public  ArrayList<HashMap<String,Object>> getMaintenanceCodeList(@RequestParam String codeType) {
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("codeType",codeType);

        return maintenanceService.getMaintenanceCodeList(map);

    }

    @RequestMapping(value = "/insertMaintenanceCodeList", method = RequestMethod.POST)
    public void insertMaintenanceCodeList(@RequestParam String codType, @RequestParam String codCode, @RequestParam String codDesc,@RequestParam String saveDate) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("codType", codType);
        map.put("codCode", codCode);
        map.put("codDesc", codDesc);
        map.put("saveDate",saveDate);

        logger.info("codType" + codType);
        logger.info("codCode" + codCode);
        logger.info("codDesc" + codDesc);
        logger.info("saveDate" + saveDate);
        maintenanceService.insertMaintenanceCodeList(map);

    }


}
