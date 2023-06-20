package com.example.boot.dao;

import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;

@Repository
public interface GoodPlaceDAO {
    ArrayList<HashMap<String,Object>> getSigunCdList();
}
