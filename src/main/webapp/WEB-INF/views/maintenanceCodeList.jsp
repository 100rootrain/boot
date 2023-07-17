<%--
  Created by IntelliJ IDEA.
  User: kma04
  Date: 2023-07-11
  Time: 오전 9:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>maintenanceCodeList</title>
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

    tr, td {
        border: 1px solid #444444;
        padding: 10px;
    }

/*    td:focus{
        border: 5px solid #FE7F9C;
    }*/

    table {
        table-layout: fixed;
        width: 100%;
        border-collapse: collapse;
    }

    th {
        background-color: #cccccc;
        border-collapse: collapse;

        border: 1px solid #444444;

        height: 20%;
        margin: auto;
    }
</style>
<body>


<div>조회조건</div>
<div>
    구분:
    <select name="codeType" onchange="fnCodeSearch()">
        <option value="SITE">요청SITE</option>
        <option value="BG">요청BG</option>
        <option value="SYSTEM">요청시스템</option>
        <option value="TYPE">요청유형</option>
    </select>
</div>
<table id="maintenanceCodeList">
    <colgroup>
        <col style="width:5%">
        <col style="width:10%">
        <col style="width:75%">
        <col style="width:10%">
    </colgroup>
    <thead>
    <tr>
        <th>No.</th>
        <th>Code</th>
        <th>Desc.</th>
        <th>저장일자</th>
    </tr>
    </thead>
    <tbody id="codeBody">
    </tbody>


</table>
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    let tabIdx = 1; // 첫번째 셀부터 실행하기 위해서 1로 지정

    $(document).ready(function () {
        fnCodeSearch();


    });

    function fnCodeSearch() {

        $.ajax({
            url: "getMaintenanceCodeList",
            type: "GET",
            cache: false,

            data: {
                codeType: $(`select[name=codeType]`).val(),
            },
            success: function (data) {
                console.log(data);
                let t = ``;

                for (let i = 0; i < data.length; i++) {

                    t += `<tr>`;
                    t += `<td>\${data[i].NO}</td>`;
                    t += `<td contenteditable='true' class='rowColumn codCode' onclick='getContentEditable();' tabindex='\${tabIdx++}'>\${data[i].COD_CODE}</td>`;
                    t += `<td contenteditable='true' class='rowColumn codDesc' onclick='getContentEditable();' tabindex='\${tabIdx++}'>\${data[i].COD_DESC}</td>`;
                    t += `<td class='saveDate'>\${data[i].SAVE_DATE}</td>`;
                    t += `</tr>`;
                    //</tr>로 안닫아주면 <tr></tr> 공란으로 또생김


                }
                $("#codeBody").html(t);

            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:"
                    + request.response.status + "\n" + "error:"
                    + error);
            }

        });

    }

    function fnCodeInsert() {
        let updateData = [];

        console.log("codType:" + $("select[name=codeType]").val());
        console.log("codCode:" + $(".codCode").text());
        console.log("codDesc:" + $(".codDesc").text());
        console.log("saveDate:" + $(".saveDate").text());

        let table = document.getElementById('maintenanceCodeList');


        // tbody의 모든 tr 요소에 대해 반복
        let rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');
        for (let i = 0; i < rows.length; i++) {
            console.log("rows.length" + rows.length)

            let cells = rows[i].getElementsByTagName('td');

            // 각 행의 첫 번째 td 요소는 No.이므로 건너뜁니다.
            let codType1 = $("select[name=codeType]").val();
            let codCode2 = cells[1].innerHTML;
            let codDesc3 = cells[2].innerHTML;
            let codDate4 = cells[3].innerHTML;

            console.log("codType : " + codType1);
            console.log("codCode : " + codCode2);
            console.log("codDesc : " + codDesc3);
            console.log("codDate : " + codDate4);

            updateData.push({codType: codType1, codCode: codCode2, codDesc: codDesc3, saveDate: codDate4});
        }

        console.log("JSON.stringify(updateData) : " + JSON.stringify(updateData));


        $.ajax({
            url: "insertMaintenanceCodeList",
            type: "POST",
            data:
                JSON.stringify(updateData),
            //dataType: "json", // 서버->화면 반환데이터
            // async: true ,
            cache: false,
            contentType: "application/json;charset=utf-8", //전송데이터


            success: function (data) {
                console.log(data);
                fnCodeSearch();

            },
            error: function (request, status, error) {
                console.log(request);
            }

        });

    }

    function getToday() {
        var date = new Date();
        var year = date.getFullYear();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);

        return year + "-" + month + "-" + day;
    }

    function fnCodeRowNew() {
        let t = ``;
        let noPlus = Number($('tbody tr:last-child td:first-child').text()) + 1;

        t += `<tr>`;
        t += `<td>\${noPlus}</td>`;
        t += `<td contenteditable='true' class='rowColumn codCode' ondblclick='getContentEditable();'></td>`;
        t += `<td contenteditable='true' class='rowColumn codDesc' ondblclick='getContentEditable();'></td>`;
        t += `<td class='saveDate'>\${getToday()}</td>`;
        t += `</tr>`;

        $("#codeBody").append(t);

    }

    $(document).keydown(function (key) {
        if (key.ctrlKey && key.which == 83) {
            key.preventDefault(); //기본동작인 저장<ctrl+s>을 막음
            fnCodeInsert();
        }
        if (key.ctrlKey && key.which == 77) {
            key.preventDefault(); //기본동작인 저장<ctrl+n>을 막음 , n이안돼서 m으로 임시
            fnCodeRowNew();
        }

    });

    function getContentEditable() {
        let contents = document.getElementsByClassName("rowColumn");
        console.log("contents : " + JSON.tcontents);
        Array.from(contents).forEach(function (content) {


            //마우스 포인터가 요소에 들어올경우
            content.addEventListener("mouseover", function (event) {
                content.contentEditable = true;
                content.style.border = "5px solid #FE7F9C";
                content.focus();
            });

            //마우스 포인터가 요소에서 벗어나는 순간
            content.addEventListener("mouseout", function (event) {
                content.contentEditable = false;
                content.style.border = "1px solid #444444";
            });
        })
    }


</script>
</html>
