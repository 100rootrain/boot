package com.example.boot.service;


import com.example.boot.dao.GoodPlaceDAO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class GoodPlaceService {
    private final GoodPlaceDAO goodPlaceDAO;

    public GoodPlaceService(GoodPlaceDAO goodPlaceDAO){
        this.goodPlaceDAO=goodPlaceDAO;
    }

    public ArrayList<HashMap<String, Object>> getSigunCdList() {
        ArrayList<HashMap<String, Object>> sigunNmList = goodPlaceDAO.getSigunCdList();
        return sigunNmList;
    }
}
