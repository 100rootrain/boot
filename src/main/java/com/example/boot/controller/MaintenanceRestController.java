package com.example.boot.controller;

import com.example.boot.service.MaintenanceService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@RestController
public class MaintenanceRestController {
    private final static Logger logger = LoggerFactory.getLogger(MaintenanceRestController.class);
    private final MaintenanceService maintenanceService;

    public MaintenanceRestController(MaintenanceService maintenanceService) {
        this.maintenanceService = maintenanceService;
    }

    //유지보수관리 메인조회
    @RequestMapping(value = "/getMaintenanceList", method = RequestMethod.GET)
    public ArrayList<HashMap<String, Object>> getMaintenanceList(@RequestParam String startPeriod, @RequestParam String endPeriod, @RequestParam String mngStatus, @RequestParam String descSearch,
                                                                 @RequestParam String mngCompany, @RequestParam String mngPerson, @RequestParam String mngContact, @RequestParam String mngSite,
                                                                 @RequestParam String mngBg, @RequestParam String mngSystem, @RequestParam String mngType, Locale locale, Model model) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("startPeriod", startPeriod);
        map.put("endPeriod", endPeriod);
        map.put("mngStatus", mngStatus);
        map.put("descSearch", descSearch);
        map.put("mngCompany", mngCompany);
        map.put("mngPerson", mngPerson);
        map.put("mngContact", mngContact);

        map.put("mngSite", mngSite);
        map.put("mngBg", mngBg);
        map.put("mngSystem", mngSystem);
        map.put("mngType", mngType);

        ArrayList<HashMap<String, Object>> getMaintenanceList = maintenanceService.getMaintenanceList(map);

        return getMaintenanceList;
    }

    //유지보수관리 팝업조회
    @RequestMapping(value = "/getMaintenanceInfoPopup", method = RequestMethod.GET)
    public HashMap<String, Object> getMaintenanceInfoPopup(@RequestParam String mngCode, @RequestParam String mngSeq) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("mngCode", mngCode);
        map.put("mngSeq", mngSeq);

        return maintenanceService.getMaintenanceInfoPopup(map);

    }

    //유지보수관리팝업 삽입&수정
    @RequestMapping(value = "/insertMaintenanceInfoPopup", method = RequestMethod.POST)
    public void insertMaintenanceInfoPopup(@RequestParam String mngCode, @RequestParam String mngSeq, @RequestParam String mngCompany,
                                           @RequestParam String mngContact, @RequestParam String mngSite, @RequestParam String mngBg,
                                           @RequestParam String mngPerson, @RequestParam String mngSystem, @RequestParam String mngType, @RequestParam String mngDescR,
                                           @RequestParam String mngDescS, @RequestParam String mngStatus/*@RequestParam String mngStart,
                                                              @RequestParam String mngClose*/) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("mngCode", mngCode);
        map.put("mngSeq", mngSeq);
        map.put("mngCompany", mngCompany);
        map.put("mngContact", mngContact);
        map.put("mngSite", mngSite);
        map.put("mngBg", mngBg);
        map.put("mngPerson", mngPerson);
        map.put("mngSystem", mngSystem);
        map.put("mngType", mngType);
        map.put("mngDescR", mngDescR);
        map.put("mngDescS", mngDescS);
        map.put("mngStatus", mngStatus);
//        map.put("mngStart",mngStart);
//        map.put("mngClose",mngClose);

        maintenanceService.insertMaintenanceInfoPopup(map); // 게시판

    }

    @RequestMapping(value = "/getMaintenanceCodeList", method = RequestMethod.GET)
    public ArrayList<HashMap<String, Object>> getMaintenanceCodeList(@RequestParam String codeType) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("codeType", codeType);

        return maintenanceService.getMaintenanceCodeList(map);

    }

    /*

        @PostMapping(value = "/insertMaintenanceCodeList")
        public void insertMaintenanceCodeList(
                @RequestBody ArrayList<HashMap<String, Object>> updateData) {
            logger.info("updateData : " + updateData);

            maintenanceService.insertMaintenanceCodeList(updateData);

        }

    */
//2.Mybatis에서 foreach로 처리하기[MERGE INTO]
    @PostMapping(value = "/insertMaintenanceCodeList")
    public void insertMaintenanceCodeList(
            @RequestBody ArrayList<HashMap<String, Object>> updateData) {
        logger.info("updateData : " + updateData);

        maintenanceService.insertMaintenanceCodeList(updateData);

    }


    @RequestMapping(value = "/getMaintenancePopupCodeList", method = RequestMethod.POST)
    public ArrayList<HashMap<String, Object>> getMaintenancePopupCodeList(@RequestBody Map<String, String> requestData) {
        String mngCompany = requestData.get("mngCompany");
        String mngPerson = requestData.get("mngPerson");
        String mngContact = requestData.get("mngContact");

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("mngCompany", mngCompany);
        map.put("mngPerson", mngPerson);
        map.put("mngContact", mngContact);

        logger.info("map : " + map);

        return maintenanceService.getMaintenancePopupCodeList(map);

    }


    @RequestMapping(value = "/getNew", method = RequestMethod.GET)
    public HashMap<String, Object> getNew() {
        return maintenanceService.getNew();

    }

}
