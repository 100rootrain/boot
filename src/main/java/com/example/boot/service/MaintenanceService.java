package com.example.boot.service;

import com.example.boot.dao.AirPollutionDAO;
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

    public MaintenanceService(MaintenanceDAO maintenanceDAO){
        this.maintenanceDAO=maintenanceDAO;
    }

    public ArrayList<HashMap<String, Object>> getStateList() {
        ArrayList<HashMap<String,Object>> list = maintenanceDAO.getStateList();
        return list;
    }
}
