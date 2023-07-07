package com.example.boot.service;

import com.example.boot.dao.MaintenanceDAO;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
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
        return maintenanceDAO.getMaintenanceInfoPopup(map);

    }
}
