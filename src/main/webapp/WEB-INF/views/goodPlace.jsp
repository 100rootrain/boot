<%--
  Created by IntelliJ IDEA.
  User: qoreh
  Date: 2023-06-17
  Time: 오전 8:50
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <style>
        #tbl {
            border: 2px solid gray;
        }

        #a1 {
            width: 100%;
            text-align: center;
        }

        #a2 {
            width: 100%;
            text-align: center;
        }

        #airGrade {
            width: 100%;
            text-align: center;
            border-top: 1px solid #444444;
            border-collapse: collapse;
        }

        #airLegend {
            text-align: center;
            border-collapse: collapse;
            float: right;
            table-layout: fixed;
        }

        tr, td {
            border-top: 1px solid #444444;
            border-bottom: 1px solid #444444;
            border-left: 1px solid #444444;
            border-right: 1px solid #444444;
            padding: 10px;
        }
    </style>
    <script type="text/javascript"
            src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript">

        function fnSearch() {

            var sigunCd = $("#sigunCd").val();
            console.log(sigunCd);

            $
                .ajax({
                    url : "getGoodPlaceInfo", //요청할 url, 주소:포트(http://localhost:8080)는 일반적으로 생략
                    type : "GET", //요청 방식 - GET:조회, POST:입력
                    cache : false, //캐쉬 - 임시로 데이터를 저장할지 여부, 거의 false
                    dataType : "json", //데이터의 형식, 거의 json
                    data : {
                        sigunCd : $("#sigunCd").val()
                    },

                    success : function(data) { //데이터 송,수신에 성공했을 경우의 동작
                        console.log(data);
                        let rows = data.PlaceThatDoATasteyFoodSt[1].row; // row 요소들을 가져옵니다.

                        console.log('rows : ' + rows);
                        console.log('rows.length : ' + rows.length);


                        for (let i = 0; i < rows.length; i++) {
                            let row = rows[i];

                            // 각 요소에 접근하여 필요한 정보를 추출합니다.
                            let siguNm = row.SIGUN_NM;
                            let restrt = row.RESTRT_NM;
                            let food = row.REPRSNT_FOOD_NM;
                            let telno = row.TASTFDPLC_TELNO;
                            let address = row.REFINE_ROADNM_ADDR;

                            // 추출한 정보를 가지고 필요한 동작을 수행합니다.
                            console.log("지역명: " + siguNm);
                            console.log("식당명: " + restrt);
                            console.log("대표 음식: " + food);
                            console.log("전화번호: " + telno);
                            console.log("주소: " + address);
                            console.log("--------------------------------");
                        }


                    },
                    error : function(request, status, error) { // 오류가 발생했을 경우의 동작
                        alert("code:" + request.status + "\n" + "message:"
                            + request.responseText + "\n" + "error:"
                            + error);
                        console.log("code:" + request.status + "\n" + "message:"
                        + request.responseText + "\n" + "error:"
                        + error);
                    }
                });

        }


    </script>
</head>
<body>
<div id="a1">
    <select id="sigunCd" onchange="fnSearch()">

        <c:forEach var="sigunCdList" items="${sigunCdList}">
            <option value="${sigunCdList.SIGUN_CD}">${sigunCdList.SIGUN_CD}</option>

        </c:forEach>

    </select>
</div>

<br>
<div id="a3">
    <table id="airGrade">

    </table>
</div>


</body>
</html>