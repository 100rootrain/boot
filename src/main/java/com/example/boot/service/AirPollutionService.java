package com.example.boot.service;

import com.example.boot.dao.AirPollutionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class AirPollutionService {

    private final AirPollutionDAO airPollutionDAO;

    public AirPollutionService(AirPollutionDAO airPollutionDAO){
        this.airPollutionDAO=airPollutionDAO;
    }

    public ArrayList<HashMap<String, Object>> getLocationList() {
        ArrayList<HashMap<String, Object>> list = airPollutionDAO.getLocationList();
        return list;
    }

    public ArrayList<HashMap<String, Object>> getStationList(HashMap<String, Object> map) {
        return airPollutionDAO.getStationList(map);
    }

}
