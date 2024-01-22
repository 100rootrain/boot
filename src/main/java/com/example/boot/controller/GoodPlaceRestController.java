package com.example.boot.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    @PostMapping("/getTaxNo")
    public ResponseEntity<Map<String, Object>> getTaxNo(@RequestBody Map<String, List<String>> requestData) throws Exception {
        OutputStream outputStream = null;
        BufferedWriter bufferedWriter = null;

        ObjectMapper objectMapper = new ObjectMapper();
        String jsonRequestData = objectMapper.writeValueAsString(requestData);

        // url과 파라미터를 조합하여 호출할 url 문자열 생성
        StringBuilder urlBuilder = new StringBuilder("https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=oTQFATcA45CS46kxfTIjvzbK0duxFGFYn1CZGi6sLkj3uta6WowzOwfUgx5OgEVmx2tJcTezr19ZQH43WfsIog==");

        // ▼ API 호출 시작 ▼
        URL url = new URL(urlBuilder.toString());
        logger.info("urlBuilder.toString() : " + urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-type", "application/json");
        conn.setDoOutput(true);

        outputStream = conn.getOutputStream();

        bufferedWriter = new BufferedWriter(new OutputStreamWriter(outputStream,"UTF-8"));
        bufferedWriter.write(jsonRequestData);
        bufferedWriter.flush();


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

        //성공적인 처리를 나타내는 JSON 응답을 반환
        Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("status", "success");
        responseMap.put("message", "Request processed successfully");
        responseMap.put("data",sb);

        return ResponseEntity.ok(responseMap);
    }


//    @PostMapping("/getTaxNo")
//    public  ResponseEntity<Map<String, Object>> getTaxNo(@RequestBody Map<String, List<String>> requestData) {
//        String readLine = null;
//        StringBuilder buffer = null;
//        OutputStream outputStream = null;
//        BufferedReader bufferedReader = null;
//        BufferedWriter bufferedWriter = null;
//        HttpURLConnection urlConnection = null;
//
//
//        try {
//            // 예시: 받은 사업자 번호를 이용하여 로깅
//            logger.info("Received business number: {}", requestData);
//            // Convert requestData to a JSON string
//            ObjectMapper objectMapper = new ObjectMapper();
//            String jsonRequestData = objectMapper.writeValueAsString(requestData);
//
//
//            // TODO: 여기에 실제 API 호출 및 처리 로직 추가
//            // url과 파라미터를 조합하여 호출할 url 문자열 생성
//            URL url = new URL("https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=oTQFATcA45CS46kxfTIjvzbK0duxFGFYn1CZGi6sLkj3uta6WowzOwfUgx5OgEVmx2tJcTezr19ZQH43WfsIog==");
//
//            urlConnection = (HttpURLConnection)url.openConnection();
//            urlConnection.setRequestMethod("POST");
////            urlConnection.setConnectTimeout(connTimeout);
////            urlConnection.setReadTimeout(readTimeout);
//            urlConnection.setRequestProperty("dataType", "JSON;");
//            urlConnection.setRequestProperty("Content-Type", "application/json;");
//            urlConnection.setRequestProperty("accept", "application/json;");
//            urlConnection.setDoOutput(true);
//            urlConnection.setInstanceFollowRedirects(true);
//
//            outputStream = urlConnection.getOutputStream();
//
//            bufferedWriter = new BufferedWriter(new OutputStreamWriter(outputStream,"UTF-8"));
//            bufferedWriter.write(jsonRequestData);
//            bufferedWriter.flush();
//
//            buffer = new StringBuilder();
//            if(urlConnection.getResponseCode() == HttpURLConnection.HTTP_OK)
//            {
//                bufferedReader = new BufferedReader(new InputStreamReader(urlConnection.getInputStream(),"UTF-8"));
//                while((readLine = bufferedReader.readLine()) != null)
//                {
//                    buffer.append(readLine).append("\n");
//                }
//            }
//            else
//            {
//                buffer.append("\"code\" : \""+urlConnection.getResponseCode()+"\"");
//                buffer.append(", \"message\" : \""+urlConnection.getResponseMessage()+"\"");
//            }
//
//            logger.info("buffer : " + String.valueOf(buffer));
//
//            // 성공적인 처리를 나타내는 JSON 응답을 반환
//            Map<String, Object> responseMap = new HashMap<>();
//            responseMap.put("status", "success");
//            responseMap.put("message", "Request processed successfully");
//
//            return ResponseEntity.ok(responseMap);
//        } catch (Exception e) {
//            // 에러 발생 시 클라이언트에 에러 응답
//            logger.error("Error processing the request", e);
//            // 에러가 발생한 경우를 나타내는 JSON 응답을 반환
//            Map<String, Object> errorResponseMap = new HashMap<>();
//            errorResponseMap.put("status", "error");
//            errorResponseMap.put("message", "Error processing the request");
//
//            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(errorResponseMap);
//        }
//        finally
//        {
//            try
//            {
//                if (bufferedWriter != null) { bufferedWriter.close(); }
//                if (outputStream != null) { outputStream.close(); }
//                if (bufferedReader != null) { bufferedReader.close(); }
//            }
//            catch(Exception ex)
//            {
//                ex.printStackTrace();
//            }
//        }
//
//
//
//    }


}
