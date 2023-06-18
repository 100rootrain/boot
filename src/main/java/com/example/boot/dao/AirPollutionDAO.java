package com.example.boot.dao;

import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;

@Repository
public interface AirPollutionDAO {
    public ArrayList<HashMap<String, Object>> getLocationList();

    public ArrayList<HashMap<String, Object>> getStationList(HashMap<String, Object> map);
}
