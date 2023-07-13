<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: kma04
  Date: 2023-07-06
  Time: 오후 3:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>maintenanceInfoPopup</title>
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
            border: 0;
            outline: none;
        }

        textarea {
            width: 100%;
            height: 10em;
            border: none;
            resize: none;
        }

    </style>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
        $(window).load(function () {
            fnPopupSearch();
        });

        function fnPopupSearch() {
            console.log("mngCode : " + $("#mngCode").val());
            console.log("mngSeq : " + $("#mngSeq").val());

            $
                .ajax({
                    url: "getMaintenanceInfoPopup", //요청할 url, 주소:포트(http://localhost:8080)는 일반적으로 생략
                    type: "GET", //요청 방식 - GET:조회, POST:입력
                    cache: false, //캐쉬 - 임시로 데이터를 저장할지 여부, 거의 false

                    data: {
                        mngCode: $("#mngCode").val(),
                        mngSeq: $("#mngSeq").val()


                    },
                    success: function (data) { //데이터 송,수신에 성공했을 경우의 동작
                        console.log(data);
                        $("#mngSite").text(data.MNG_SITE);
                        $("#mngCompany").val(data.MNG_COMPANY);
                        $("#mngBg").val(data.MNG_BG);
                        $("#mngPerson").val(data.MNG_PERSON);
                        $("#mngSystem").val(data.MNG_SYSTEM);
                        $("#mngContact").val(data.MNG_CONTACT);
                        $("#mngType").val(data.MNG_TYPE);
                        $("#mngDescR").val(data.MNG_DESC_R);
                        $("#mngDescS").val(data.MNG_DESC_S);

                        console.log("data.MNG_TYPE : " + data.MNG_TYPE);
                        console.log("data.MNG_DECS_R : " + data.MNG_DECS_R);


                    },

                    error: function (request, status, error) { // 오류가 발생했을 경우의 동작
                        alert("code:" + request.status + "\n" + "message:"
                            + request.responseText + "\n" + "error:"
                            + error);
                    }
                });

        }

        function fnPopupSave() {
            $.ajax({
                url: "insertMaintenanceInfoPopup",
                type: "POST",
                cache: false,

                data: {
                    mngCode: $("#mngCode").val(),
                    mngSeq: $("#mngSeq").val(),
                    mngBg: $("#mngBg").val(),
                    mngPerson: $("#mngPerson").val(),
                    mngSystem: $("#mngSystem").val(),
                    mngContact: $("#mngContact").val(),
                    mngCompany: $("#mngCompany").val(),
                    mngSite: $("#mngSite").val(),
                    mngType: $("#mngType").val(),
                    mngDescR: $("#mngDescR").val(),
                    mngDescS: $("#mngDescS").val(),
                    mngStatus: $("#mngStatus").val()
                },
                success: function (data) {

                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "message:"
                        + request.responseText + "\n" + "error:"
                        + error);
                }

            });
        }


        function managePopup(target,codeId) {
            let tbody = target.parentNode;
            let trs = tbody.getElementsByTagName('tr');


            //let dataNo = $(target).find("#dataNo").text();
            for (let i = 0; i < trs.length; i++) {

                if (trs[i] != target) {

                } else {
                    //더블클릭 했을때 기존 row의 정보들이 들어가도록 해야된다.

                    //팝업 가운데정렬
                    let width = 1000;
                    let height = 800;
                    let xPos = (document.body.offsetWidth / 2) - (width / 2); // 가운데 정렬
                    xPos += window.screenLeft; // 듀얼 모니터일 때
                    let yPos = (document.body.offsetHeight / 2) - (height / 2);

                    // 이미 열린 팝업이 있는 경우 닫아줍니다.
                    if (openWin && !openWin.closed) {
                        openWin.close();
                    }

                    openWin = window.open("/maintenanceCodeInfoPopup", "[코드조회]",
                        'width=' + width + ', height=' + height + ', left=' + xPos + ', top=' + yPos + ', scrollbars=no');

                    //브라우저 창크기 고정
                    openWin.resizeTo(width, height);
                    openWin.onresize = (_ => {
                        openWin.resizeTo(width, height);
                    })

                    // window.open("/maintenanceInfoPopup", "[유지보수관리상세]",
                    //     'width=400, height=600, left=400, top=400, resizable = no');

                }
            }
        }

    </script>
</head>
<body>
<div>
    <table>
        <colgroup>
            <col style="width:10%">
            <col style="width:20%">
            <col style="width:3%">
            <col style="width:20%">
            <col style="width:12%">
            <col style="width:10%">
            <col style="width:25%">
        </colgroup>
        <tr>
            <td>업무일자:</td>
            <td><input type="text" id="mngCode" readonly></td>
            <td> -</td>
            <td><input type="text" id="mngSeq" readonly></td>
            <td>요청Site:</td>
            <td id="mngSite" contenteditable="false" ondblclick="managePopup(this,this.id)"></td>
            <td colspan="8"></td>


        </tr>
        <tr>
            <td>상호:</td>
            <td colspan="3"><input type="text" id="mngCompany"></td>
            <td>BG:</td>
            <td><input type="text" id="mngBg"></td>
            <td colspan="8">


        </tr>
        <tr>
            <td>요청자:</td>
            <td colspan="3"><input type="text" id="mngPerson"></td>
            <td>요청시스템:</td>
            <td><input type="text" id="mngSystem"></td>
            <td colspan="8">


        </tr>
        <tr>
            <td>연락처:</td>
            <td colspan="3"><input type="text" id="mngContact"></td>
            <td>요청유형:</td>
            <td><input type="text" id="mngType"></td>
            <td colspan="8">


        </tr>
        <tr>
            <td>상태</td>
            <td>selectbox자리</td>
            <td colspan="2"></td>
            <td>
                <button>업무조회</button>
            </td>
            <td colspan="9"></td>

        </tr>
        <tr>
            <td>요청내용:</td>
            <td colspan="13"><textarea id="mngDescR"></textarea></td>

        </tr>
        <tr>
            <td>처리내용:</td>
            <td colspan="13"><textarea id="mngDescS"></textarea></td>


        </tr>


    </table>
</div>
<script>
    contents = document.getElementsByClassName("rowColumn");
    document.addEventListener("DOMContentLoaded", function () {
        Array.from(contents).forEach(function (content) {
            content.addEventListener("dblclick", function (event) {
                //contenteditable 속성이 수정 불가인 경우 실행(false)
                if (content.isContentEditable == false) {

                    //편집 가능 상태로 변경
                    content.contentEditable = true;

                    content.style.border = "5px solid #FE7F9C";

                    content.focus();
                } else {
                    //편집 불가 상태로 변경
                    content.contentEditable = false;
                    content.style.border = "0px";
                }
            });

            //마우스 포인터가 요소에서 벗어나는 순간
            content.addEventListener("mouseout", function (event) {
                content.contentEditable = false;
                content.style.border = "0px";
            });


        })


    });


</script>


</body>
</html>
