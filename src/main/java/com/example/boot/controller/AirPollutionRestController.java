package com.example.boot.controller;

import com.example.boot.service.AirPollutionService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

@RestController
public class AirPollutionRestController {

    private final AirPollutionService airPollutionService;

    public AirPollutionRestController(AirPollutionService airPollutionService){
        this.airPollutionService=airPollutionService;
    }
    @RequestMapping(value = "/getAirPollutionInfo", method = RequestMethod.GET)
    public HashMap<String, Object> getAirPollutionInfo(@RequestParam String stationName) throws Exception {

        // url과 파라미터를 조합하여 호출할 url 문자열 생성
        StringBuilder urlBuilder = new StringBuilder(
                "http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getMsrstnAcctoRltmMesureDnsty");
        /*
         * URL 에어코리아 대기오염정보 조회서비스 기술문서 참고 => "서비스URL:
         * http://apis.data.go.kr/B552584/ArpltnInforInqireSvc 상세기능명 :
         * /getMsrstnAcctoRltmMesureDnsty "
         */

        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "="
                + URLEncoder.encode(
                "oTQFATcA45CS46kxfTIjvzbK0duxFGFYn1CZGi6sLkj3uta6WowzOwfUgx5OgEVmx2tJcTezr19ZQH43WfsIog==",
                "UTF-8")); /* 공공데이터포털에서 받은 인증키 */
        urlBuilder.append(
                "&" + URLEncoder.encode("returnType", "UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /* 페이지번호 */
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
        urlBuilder.append(
                "&" + URLEncoder.encode("stationName", "UTF-8") + "=" + URLEncoder.encode(stationName, "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("dataTerm", "UTF-8") + "=" + URLEncoder.encode("DAILY", "UTF-8"));
        urlBuilder.append("&" + URLEncoder.encode("ver", "UTF-8") + "=" + URLEncoder.encode("1.0", "UTF-8"));

        // ▼ API 호출 시작 ▼
        URL url = new URL(urlBuilder.toString());
        System.out.println("urlBuilder.toString() : " + urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
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
        System.out.println("API 호출 결과 : " + sb); // API에서 반환받은 값(문자열)

        // API에서 돌려받은 값을 해시맵으로 변환
        HashMap<String, Object> map = new ObjectMapper().readValue(sb.toString(), HashMap.class);
        return map;
    }

    @RequestMapping(value = "/getStationList", method = RequestMethod.GET)
    public ArrayList<HashMap<String, Object>> getStationList(@RequestParam String locNm, Locale locale, Model model) {
        HashMap<String, Object> map = new HashMap<String, Object>();

        map.put("locNm", locNm);
        System.out.println("getStationList_locNm : " + locNm);

        ArrayList<HashMap<String, Object>> stationList = airPollutionService.getStationList(map);
        return stationList;
    }


}


