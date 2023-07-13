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
    table{
        table-layout: fixed;
        width:100%;
        border-collapse: collapse;
    }

    th{
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
    $(document).ready(function(){
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
                    t += `<td contenteditable='false' class='rowColumn codCode' ondblclick='getContentEditable();'>\${data[i].COD_CODE}</td>`;
                    t += `<td contenteditable='false' class='rowColumn codDesc' ondblclick='getContentEditable();'>\${data[i].COD_DESC}</td>`;
                    t += `<td id='saveDate'>\${data[i].SAVE_DATE}</td>`;
                    t += `<tr>`;
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

        console.log("codType:"+$("select[name=codeType]").val());
        console.log("codCode:"+$(".codCode").text());
        console.log("codDesc:"+$(".codDesc").text());
        console.log("saveDate:"+$("#saveDate").text());




        $.ajax({
            url: "insertMaintenanceCodeList",

            type: "POST",
            cache: false,
            dataType: "json",

            data: {
                codType: $("select[name=codeType]").val(),
                codCode: $(".codCode").text(),
                codDesc: $(".codDesc").text(),
                saveDate: $("#saveDate").text()
            },
            success: function (data) {
                console.log(data);
                fnCodeSearch();

            },
            error: function (request, status, error) {
                console.log(request);
            }

        });

    }

    $(document).keydown(function (key) {
        if (key.ctrlKey && key.which == 83) {
            key.preventDefault(); //기본동작인 저장<ctrl+s>을 막음
            fnCodeInsert();
        }
    });

function getContentEditable() {
        let contents = document.getElementsByClassName("rowColumn");
        Array.from(contents).forEach(function (content) {
            content.addEventListener("dblclick", function (event) {
                //contenteditable 속성이 수정 불가인 경우 실행(false)
                if (content.isContentEditable == false) {

                    //편집 가능 상태로 변경
                    content.contentEditable = true;

                    content.style.border = "5px solid #FE7F9C";

                    content.focus();

                    //마우스 포인터가 요소에서 벗어나는 순간
                    content.addEventListener("mouseout", function (event) {
                        content.contentEditable = false;
                        content.style.border = "1px solid";
                    });

                } else {
                    //편집 불가 상태로 변경
                    content.contentEditable = false;
                     content.style.border = "1px solid";
                }
            });

        })



}


</script>
</html>
