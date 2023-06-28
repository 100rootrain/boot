package com.example.boot.dao;

import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.HashMap;

@Repository
public interface MaintenanceDAO {
    public ArrayList<HashMap<String, Object>> getStateList();
}
