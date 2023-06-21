package com.example.boot.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

@RestController
public class FoodNutritionInfoRestController {
    private final static Logger logger = LoggerFactory.getLogger(FoodNutritionInfoRestController.class);

    @RequestMapping(value = "/getDescKor", method = RequestMethod.GET)
    public HashMap<String, Object> getDescKor(@RequestParam String descKor) throws Exception {

        // url과 파라미터를 조합하여 호출할 url 문자열 생성
        StringBuilder urlBuilder = new StringBuilder(
                "http://apis.data.go.kr/1471000/FoodNtrIrdntInfoService1/getFoodNtrItdntList1"); //요청주소

        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="
                + URLEncoder.encode(
                "oTQFATcA45CS46kxfTIjvzbK0duxFGFYn1CZGi6sLkj3uta6WowzOwfUgx5OgEVmx2tJcTezr19ZQH43WfsIog==",
                "UTF-8")); /* 공공데이터포털에서 받은 인증키 */
        urlBuilder.append(
                "&" + URLEncoder.encode("desc_kor", "UTF-8") + "=" + URLEncoder.encode(descKor, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("3", "UTF-8"));
//        urlBuilder.append(
//                "&" + URLEncoder.encode("animal_plant", "UTF-8") + "=" + URLEncoder.encode("animal_plant", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));

        // ▼ API 호출 시작 ▼
        URL url = new URL(urlBuilder.toString());
        logger.info("urlBuilder.toString() : " + urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        logger.info("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        // ▲ API 호출 종료 ▲
        logger.info("API 호출 결과 : " + sb); // API에서 반환받은 값(문자열)

        // API에서 돌려받은 값을 해시맵으로 변환
        HashMap<String, Object> map = new ObjectMapper().readValue(sb.toString(), HashMap.class);
        return map;


    }
}