package com.example.boot.service;

import com.example.boot.dao.MaintenanceDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class MaintenanceService {
    private final Logger logger = LoggerFactory.getLogger(MaintenanceService.class);
    private final MaintenanceDAO maintenanceDAO;



    public MaintenanceService(MaintenanceDAO maintenanceDAO) {
        this.maintenanceDAO = maintenanceDAO;
    }

    public ArrayList<HashMap<String, Object>> getStateList() {
        ArrayList<HashMap<String, Object>> list = maintenanceDAO.getStateList();
        return list;
    }

    public ArrayList<HashMap<String, Object>> getMaintenanceList(HashMap<String, Object> map) {
        ArrayList<HashMap<String, Object>> list = maintenanceDAO.getMaintenanceList(map);
        return list;
    }

    public HashMap<String, Object> getMaintenanceInfoPopup(HashMap<String, Object> map) {
        return  maintenanceDAO.getMaintenanceInfoPopup(map);

    }

    public void insertMaintenanceInfoPopup(HashMap<String, Object> map) {
        maintenanceDAO.insertMaintenanceInfoPopup(map);
    }

    public ArrayList<HashMap<String, Object>> getMaintenanceCodeList(HashMap<String, Object> map) {
        ArrayList<HashMap<String, Object>> list = maintenanceDAO.getMaintenanceCodeList(map);
        return list;
    }


    //1.서비스단에서 for문 돌리는방법
/*
    public void insertMaintenanceCodeList(ArrayList<HashMap<String,Object>> list) {
        for (HashMap<String, Object> map : list) {
            logger.info("map : " + map);
            maintenanceDAO.insertMaintenanceCodeList(map);
        }

    }
*/

    //2.Mybatis에서 foreach로 처리하기[MERGE INTO]
    public void insertMaintenanceCodeList(ArrayList<HashMap<String,Object>> list) {

            maintenanceDAO.insertMaintenanceCodeList(list);


    }
}
