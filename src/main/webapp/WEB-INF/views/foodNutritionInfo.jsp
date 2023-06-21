<%--
  Created by IntelliJ IDEA.
  User: kma04
  Date: 2023-06-20
  Time: 오후 5:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<html>
<head>
    <title>Title</title>
  <script type="text/javascript"
          src="https://www.gstatic.com/charts/loader.js"></script>
  <script src="http://code.jquery.com/jquery-latest.min.js"></script>
  <script type="text/javascript">

    function fnSearch() {

      let descKor = $("#descKor").val(); //식품이름
      console.log(descKor);

      $
              .ajax({
                url : "getDescKor", //요청할 url, 주소:포트(http://localhost:8080)는 일반적으로 생략
                type : "GET", //요청 방식 - GET:조회, POST:입력
                cache : false, //캐쉬 - 임시로 데이터를 저장할지 여부, 거의 false
                dataType : "json", //데이터의 형식, 거의 json
                data : {
                    descKor : $("#descKor").val()
                },

                success : function(data) { //데이터 송,수신에 성공했을 경우의 동작
                  console.log(data);

                  //페이지 넘길때
                    let totalCount = data.body.totalCount;
                    let numOfRows = data.body.numOfRows;
                    let pageNo = data.body.pageNo;

                    console.log("전체 결과 수: " + totalCount);
                    let items = data.body.items; // row 요소들을 가져옵니다.


                    for (let i = 0; i < items.length; i++) {
                        let item = items[i];

                        // 각 요소에 접근하여 필요한 정보를 추출합니다.
                        let currentCnt = i;
                        let descKor = item.DESC_KOR;
                        let servingWt = item.SERVING_WT;
                        let nutrCont1 = item.NUTR_CONT1;
                        let nutrCont2 = item.NUTR_CONT2;
                        let nutrCont3 = item.NUTR_CONT3;
                        let nutrCont4 = item.NUTR_CONT4;
                        let nutrCont5 = item.NUTR_CONT5;
                        let nutrCont6 = item.NUTR_CONT6;
                        let nutrCont7 = item.NUTR_CONT7;
                        let nutrCont8 = item.NUTR_CONT8;
                        let nutrCont9 = item.NUTR_CONT9;
                        let bgnYear = item.BGN_YEAR;
                        let animalPlant = item.ANIMAL_PLANT;



                        // 추출한 정보를 가지고 필요한 동작을 수행합니다.
                        console.log("--------------------"+currentCnt+"----------------------");
                        console.log("페이지 번호: " + pageNo);
                        console.log("한 페이지 결과수:" + numOfRows);
                        console.log("식품이름: " + descKor);
                        console.log("1회 제공량 (g): " + servingWt);
                        console.log("열량 (kcal): " + nutrCont1);
                        console.log("탄수화물 (g): " + nutrCont2);
                        console.log("단백질 (g): " + nutrCont3);
                        console.log("지방 (g): " + nutrCont4);
                        console.log("당류 (g): " + nutrCont5);
                        console.log("나트륨 (mg): " + nutrCont6);
                        console.log("콜레스트롤 (mg): " + nutrCont7);
                        console.log("포화지방산 (g): " + nutrCont8);
                        console.log("트랜스지방산 (g): " + nutrCont9);
                        console.log("구축년도: " + bgnYear);
                        console.log("가공업체: " + animalPlant);
                        console.log("-------------------------------------------------");
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

    $(document).ready(function () {
        $("button").click(fnSearch);

        // ID가 message에서 엔터키를 누를 경우
        $("#descKor").keydown(function (key) {
            if (key.keyCode == 13) {
                fnSearch();
            }
        });

    });



  </script>

</head>
<body>
<input id="descKor"/>
<button>검색</button>
</body>
</html>
