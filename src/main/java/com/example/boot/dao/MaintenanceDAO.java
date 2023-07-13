package com.example.boot.dao;

import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;

@Repository
public interface MaintenanceDAO {
    public ArrayList<HashMap<String, Object>> getStateList();

    public ArrayList<HashMap<String, Object>> getMaintenanceList(HashMap<String, Object> map);

    public HashMap<String, Object> getMaintenanceInfoPopup(HashMap<String, Object> map);

    void insertMaintenanceInfoPopup(HashMap<String, Object> map);

    public ArrayList<HashMap<String, Object>> getMaintenanceCodeList(HashMap<String, Object> map);

    void insertMaintenanceCodeList(HashMap<String, Object> map);

}
