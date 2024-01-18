package com.example.boot.controller;

import com.example.boot.service.AirPollutionService;
import com.example.boot.service.GoodPlaceService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

@Controller
public class GoodPlaceController {
    private final GoodPlaceService goodPlaceService;

    public  GoodPlaceController(GoodPlaceService goodPlaceService){
        this.goodPlaceService=goodPlaceService;
    }


    @RequestMapping(value = "/goodPlace", method = RequestMethod.GET)
    public String goodPlace(Locale locale, Model model) { // INNERHTML
        ArrayList<HashMap<String, Object>> sigunCdList = goodPlaceService.getSigunCdList();

        model.addAttribute("sigunCdList", sigunCdList);

        return "goodPlace";
    }

    @RequestMapping(value = "/taxNoValid", method = RequestMethod.GET)
    public String taxNoValid(){
        return "taxNoTest";
    }

}
