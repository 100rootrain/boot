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
    <title>식품 영양성분(DB)서비스</title>
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

        #foodDBTable {
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

        .page {
            cursor: pointer;
            float: none;
        }

        .page:hover {
            color: blue;
            font-weight: bold;
        }

        div {
            text-align: center;
        }


        ul {
            text-align: center;
            display: inline-block;
            border: 1px solid #ccc;
            border-right: 0;
            padding-left :0;
            margin-left: auto;
            margin-right: auto;
            display: table;
        }
        ul li {
            text-align: center;
            float: left;
            list-style:none;

        }

        ul li a {
            display: block;
            font-size: 14px;
            color: black;
            padding: 9px 12px;
            border-right: solid 1px #ccc;
            box-sizing: border-box;
            text-decoration-line:none;
        }

        ul li.on {
            background: #eda712;
        }

        ul li.on a {
            color: #fff;
        }
    </style>

    <title>Title</title>
    <script type="text/javascript"
            src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://kit.fontawesome.com/dee675b7cb.js" crossorigin="anonymous"></script>

    <script type="text/javascript">

        function fnSearch(pageNum,dataPerPage) {



            let descKor = $("#descKor").val(); //식품이름
            console.log(descKor);
            console.log("pageNum : " + pageNum);
            console.log("dataPerPage : " + dataPerPage);

            $
                .ajax({
                    url: "getDescKor", //요청할 url, 주소:포트(http://localhost:8080)는 일반적으로 생략
                    type: "GET", //요청 방식 - GET:조회, POST:입력
                    cache: false, //캐쉬 - 임시로 데이터를 저장할지 여부, 거의 false
                    dataType: "json", //데이터의 형식, 거의 json
                    data: {
                        descKor: $("#descKor").val(),
                        pageNo: pageNum,
                        numOfRows: dataPerPage
                    },

                    success: function (data) { //데이터 송,수신에 성공했을 경우의 동작
                        console.log(data);

                        //페이지 넘길때
                        let totalCount = data.body.totalCount;
                        let numOfRows = dataPerPage;
                        let pageNo = data.body.pageNo;

                        let pageCount = 10; //페이징에 나타낼 "페이지" 수

                        let items = data.body.items; // row 요소들을 가져옵니다.


                        let t = "";
                        t += "<caption>식품 영양성분(DB)서비스</caption>";

                        t += "<colgroup>";
                        t += "<col style='width:4%;'>"; // 페이지번호
                        t += "<col style='width:15%;'>"; // 식품이름
                        t += "<col style='width:5%;'>"; // 1회 제공량
                        t += "<col style='width:5%;'>"; // 열량 (kcal)
                        t += "<col style='width:5%;'>"; // 탄수화물 (g)
                        t += "<col style='width:5%;'>"; // 단백질 (g)
                        t += "<col style='width:5%;'>"; // 지방 (g)
                        t += "<col style='width:5%;'>"; // 당류 (g)
                        t += "<col style='width:5%;'>"; // 나트륨 (mg)
                        t += "<col style='width:5%;'>"; // 콜레스트롤 (mg)
                        t += "<col style='width:5%;'>"; // 포화지방산 (g)
                        t += "<col style='width:5%;'>"; // 트랜스지방산 (g)
                        t += "<col style='width:5%;'>"; // 구축년도
                        // t += "<col style='width:15%;'>"; // 가공업체
                        t += "</colgroup>";

                        t += "<thead>";
                        t += "<tr>";
                        t += "<th scope='col'>No</th>";
                        t += "<th scope='col'>식품이름</th>";
                        t += "<th scope='col'>1회제공량</th>";
                        t += "<th scope='col'>열량</th>";
                        t += "<th scope='col'>탄수화물</th>";
                        t += "<th scope='col'>단백질</th>";
                        t += "<th scope='col'>지방</th>";
                        t += "<th scope='col'>당류</th>";
                        t += "<th scope='col'>나트륨</th>";
                        t += "<th scope='col'>콜레스트롤</th>";
                        t += "<th scope='col'>포화지방산</th>";
                        t += "<th scope='col'>트랜스지방산</th>";
                        t += "<th scope='col'>구축년도</th>";
                        // t+= "<th scope='col'>가공업체</th>";
                        t += "</tr>";
                        t += "</thead>";
                        t += "<tbody id='simpleDataBody'>";


                        for (let i = 0; i < items.length; i++) {
                            let item = items[i];

                            // 각 요소에 접근하여 필요한 정보를 추출합니다.
                            let currentCnt = i + 1;
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
                            console.log("--------------------" + currentCnt + "----------------------");
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

                            t += "<tr>";


                            //식품번호 매기기
                            if(pageNo>1){
                                t += "<td>" +((dataPerPage *(pageNo-1))+currentCnt)   + "</td>";
                                //식품목록 2부터는
                                // 셀렉트박스에서 클릭한 목록번호 * ( 클릭한 목록번호-1) + 화면에 보이는 게시글 번호)
                            }else{
                                t += "<td>" + currentCnt + "</td>"; //식품번호
                            }


                            t += "<td>" + descKor + "</td>";
                            t += "<td>" + servingWt + "</td>";
                            t += "<td>" + nutrCont1 + "</td>";
                            t += "<td>" + nutrCont2 + "</td>";
                            t += "<td>" + nutrCont3 + "</td>";
                            t += "<td>" + nutrCont4 + "</td>";
                            t += "<td>" + nutrCont5 + "</td>";
                            t += "<td>" + nutrCont6 + "</td>";
                            t += "<td>" + nutrCont7 + "</td>";
                            t += "<td>" + nutrCont8 + "</td>";
                            t += "<td>" + nutrCont9 + "</td>";
                            t += "<td>" + bgnYear + "</td>";
                            // t+="<td>"+animalPlant+"</td>";
                            t += "</tr>";


                        }
                        t += "</tbody>";

                        $("#foodDBTable").html(t);


                        //first   ,prev    ,next    ,last
                        //처음페이지,이전페이지,다음페이지,마지막페이지
                        //        ,pageNo-1,pageNo+1,pageNo
                        let totalPage = Math.ceil(totalCount / dataPerPage); //총 페이지 수

                        if(totalPage<pageCount){ // 총 페이지수가 10보다 작을경우
                            pageCount=totalPage; // 총 페이지수를 totalPage로
                        }

                        let pageGroup = Math.ceil(pageNum / pageCount); // 페이지 그룹
                        let last = pageGroup * pageCount; //화면에 보여질 마지막 페이지 번호

                        if (last > totalPage) {
                            last = totalPage;
                        }

                        let first = last - (pageCount - 1); //화면에 보여질 첫번째 페이지 번호
                        let next = last + 1;
                        let prev = first - 1;



                        p = "";

                        if (prev > 0) {
                            p += "<li><a href='#' id='prev'> 이전 </a></li>";
                        }





                        for (let i = first; i <= last; i++) {
                            if (pageNo == i) {
                                p += "<li class='on'><a href='#' id='" + i + "'>" + i + "</a></li>";
                            }else{
                                p += "<li><a href='#' id='" + i + "'>" + i + "</a></li>";
                            }

                        }

                        if (last < totalPage) {
                            p += "<li><a href='#' id='next'> 다음 </a></li>";
                        }



                        $("#listCount").html(p);

                        //페이징 번호 클릭 이벤트
                        $("#listCount li a").click(function () {
                            let $id = $(this).attr("id");
                            let selectedPage = $(this).text();

                            if ($id == "next") selectedPage = next;
                            if ($id == "prev") selectedPage = prev;

                            fnSearch(selectedPage, dataPerPage);
                        });


                    },
                    error: function (request, status, error) { // 오류가 발생했을 경우의 동작
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

            //검색버튼 클릭
            $(function(){
                //$("#dataPerPage option:eq(0)").prop("selected", true);


                $('button').click(function(){
                    fnSearch(1,$("#dataPerPage option:selected").val())
                });

                // ID가 message에서 엔터키를 누를 경우
                $("#descKor").keydown(function (key) {
                    if (key.keyCode == 13) {
                        fnSearch(1,$("#dataPerPage option:selected").val());
                    }
                });

                $("#dataPerPage").change(function () {
                    let dataPerPage = $("#dataPerPage option:selected").val();
                    fnSearch(1, dataPerPage);
                });


            });

        });







    </script>

</head>
<body>
<div>
    <input id="descKor"/>
    <button id="btnSearch">검색</button>
    <select id="dataPerPage">  <%-- 한페이지에 나타낼 글 수 --%>
        <option value="10">10</option>
        <option value="15">15</option>
        <option value="20">20</option>
    </select>
</div>

<table id="foodDBTable">
</table>
<!-- 페이징 -->
<ul id="listCount"></ul>
</body>
</html>
