<%--
  Created by IntelliJ IDEA.
  User: kma04
  Date: 2023-08-01
  Time: 오후 3:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>[OO]조회팝업</title>
    <style>
        tr, td {
            border: 1px solid #444444;

            padding: 10px;
        }

        .td input:focus {
            outline: none;
        }

        input {
            width: 100%;
            border: none;
            outline: none;
            background: transparent;
        }

        #searchCondition {
            background-color: #cccccc;
            border-collapse: collapse;
            width: 100%;
            height: 5%;
            table-layout: fixed;
            margin: auto;

        }

        #fixedVal {
            background-color: #cccccc;
            border-collapse: collapse;
            width: 100%;
            height: 5%;
            table-layout: fixed;
            margin: auto;

        }

    </style>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        function fnPopupCodeSearch() {
            console.log("===================================");
            let requestData = {};

            const inputIdValue = $("#inputId").val();

            if (inputIdValue === "mngCompany") {
                requestData.mngCompany = $("#descSearch").val();
            } else if (inputIdValue === "mngPerson") {
                requestData.mngPerson = $("#descSearch").val();
            } else if (inputIdValue === "mngContact") {
                requestData.mngContact = $("#descSearch").val();
            }

            $
                .ajax({
                    url: "getMaintenancePopupCodeList", //요청할 url, 주소:포트(http://localhost:8080)는 일반적으로 생략
                    type: "POST", //요청 방식 - GET:조회, POST:입력
                    cache: false, //캐쉬 - 임시로 데이터를 저장할지 여부, 거의 false
                    contentType: "application/json", // JSON 형태로 데이터 전송
                    data: JSON.stringify(requestData), // JSON으로 변환하여 전송

                    success: function (data) { //데이터 송,수신에 성공했을 경우의 동작
                        console.log(data);
                        let dataNo = data.NO;
                        let mngCompany = data.MNG_COMPANY;
                        let mngPerson = data.MNG_PERSON;
                        let mngContact = data.MNG_CONTACT;
                        let mngCode = data.MNG_CODE;

                    },

                    error: function (request, status, error) { // 오류가 발생했을 경우의 동작
                        alert("code:" + request.status + "\n" + "message:"
                            + request.responseText + "\n" + "error:"
                            + error);
                    }
                });

        }
        $(document).ready(function () {

            $("#descSearch").keydown(function (key) {
                if (key.keyCode == 13) {
                    console.log("엔터눌렀다.");
                    key.preventDefault(); //기본동작인 개행<br>을 막음
                    fnPopupCodeSearch();
                }
            });
        });


    </script>
</head>


<body>
<div id="fixedHeader">
    <table id="searchCondition">
        <tr>
            <td>내용검색</td>
            <td colspan="5"><input type="text" id="descSearch"></td>
            <input type="hidden" id="inputId">

        </tr>
    </table>
    <table id="fixedVal">
        <colgroup>
            <col style="width:5%">
            <col style="width:20%">
            <col style="width:10%">
            <col style="width:15%">
            <col style="width:10%">
        </colgroup>
        <thead>
        <tr>
            <th>No.</th>
            <th>상호</th>
            <th>요청자</th>
            <th>연락처</th>
            <th>최종일</th>
        </tr>
        </thead>
    </table>
</div>
</body>

</html>
