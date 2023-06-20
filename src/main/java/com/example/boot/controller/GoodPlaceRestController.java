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
public class GoodPlaceRestController {
    final static Logger logger = LoggerFactory.getLogger(GoodPlaceRestController.class);
    @RequestMapping(value = "/getGoodPlaceInfo", method = RequestMethod.GET)
    public HashMap<String, Object> getGoodPlaceInfo(@RequestParam String sigunCd) throws Exception {

        // url과 파라미터를 조합하여 호출할 url 문자열 생성
        StringBuilder urlBuilder = new StringBuilder(
                "https://openapi.gg.go.kr/PlaceThatDoATasteyFoodSt"); //요청주소

        urlBuilder.append("?" + URLEncoder.encode("key", "UTF-8") + "="
                + URLEncoder.encode(
                "84d269776805412481628c96b7eb346b",
                "UTF-8")); /* 공공데이터포털에서 받은 인증키 */
        urlBuilder.append(
                "&" + URLEncoder.encode("Type", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("pIndex", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("pSize", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));
        urlBuilder.append(
                "&" + URLEncoder.encode("SIGUN_CD", "UTF-8") + "=" + URLEncoder.encode(sigunCd, "UTF-8"));

        // ▼ API 호출 시작 ▼
        URL url = new URL(urlBuilder.toString());
        logger.info("urlBuilder.toString() : " + urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        logger.info("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if (conn.getResponseCode() >= 0 && conn.getResponseCode() < 300) {
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
