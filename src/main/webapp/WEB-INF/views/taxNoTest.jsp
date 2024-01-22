<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
<h1>사업자등록번호 폐업여부 확인</h1>
<input type="text" id="taxNo">

</body>
<script>
//https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=oTQFATcA45CS46kxfTIjvzbK0duxFGFYn1CZGi6sLkj3uta6WowzOwfUgx5OgEVmx2tJcTezr19ZQH43WfsIog==

    function fnSearch(){

        var data = {
            b_no : [$("#taxNo").val()] // 사업자번호 "xxxxxxx" 로 조회 시,
        };
        console.log(data);
        $.ajax({
            url: "getTaxNo",  // serviceKey 값을 xxxxxx에 입력
            type: "POST",
            data: JSON.stringify(data), // json 을 string으로 변환하여 전송 //
            dataType: "JSON",
            contentType: "application/json",
            accept: "application/json",
            success: function(result) {
                console.log(result);
                console.log("===============");


                let jsonData = JSON.parse(result.data);
                let bSttCd = jsonData.data[0].b_stt_cd;
                let matchCnt = jsonData.match_cnt;

                if(matchCnt != 0){
                    console.log("국세청에 등록되지 않은 사업자등록번호 입니다.")
                }


                //사업자 상태 코드 (01 : 계속사업자, 02 : 휴업자, 03 : 폐업자 )
                if(bSttCd != '03'){
                    console.log("가능");
                }else{
                    console.log("불가능");
                }


            },
            error: function(result) {
                console.log(result.responseText); //responseText의 에러메세지 확인
                console.log("======");
                console.log(result);
            }
        });
    }

    $(document).ready(function () {
        // ID가 message에서 엔터키를 누를 경우
        $("#taxNo").keydown(function (key) {
            if (key.keyCode == 13) {
                fnSearch();
            }
        });

    });

</script>
</html>