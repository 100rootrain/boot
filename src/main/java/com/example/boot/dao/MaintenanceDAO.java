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
//1.서비스단에서 for문 돌리는방법
//    void insertMaintenanceCodeList(HashMap<String, Object> map);

//2.Mybatis에서 foreach로 처리하기[MERGE INTO]
// void insertMaintenanceCodeList(ArrayList<MaintenanceCodeVo> updateData);

    //3.Mybatis에서 foreach로 처리하기[INSERT INTO]
    void insertMaintenanceCodeList(ArrayList<HashMap<String, Object>> list);

    public ArrayList<HashMap<String, Object>> getMaintenancePopupCodeList(HashMap<String, Object> map);


}
