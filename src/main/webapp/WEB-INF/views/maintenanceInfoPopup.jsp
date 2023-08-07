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

        // 쿠키에서 값을 가져오는 함수
        function getCookie(name) {
            let value = "; " + document.cookie;
            let parts = value.split("; " + name + "=");
            if (parts.length === 2) return parts.pop().split(";").shift();
        }

        // 쿠키를 설정하는 함수
        function setCookie(name, value) {
            document.cookie = name + "=" + (value || "") + "; path=/";
        }


        function fnPopupSearch() {
            // 쿠키에 값을 저장 (세션 쿠키로 설정)
            let mngCodeValue = $("#mng_code").val();
            let mngSeqValue = $("#mng_seq").val();
            setCookie("mng_code", mngCodeValue);
            setCookie("mng_seq", mngSeqValue);

            $
                .ajax({
                    url: "getMaintenanceInfoPopup", //요청할 url, 주소:포트(http://localhost:8080)는 일반적으로 생략
                    type: "GET", //요청 방식 - GET:조회, POST:입력
                    cache: false, //캐쉬 - 임시로 데이터를 저장할지 여부, 거의 false

                    data: {
                        mngCode: $("#mng_code").val(),
                        mngSeq: $("#mng_seq").val()


                    },
                    success: function (data) { //데이터 송,수신에 성공했을 경우의 동작
                        console.log(data);
                        $("#mng_code").val(data.MNG_CODE);
                        $("#mng_seq").val(data.MNG_SEQ);

                        $("#mngCode").val(data.MNG_CODE);
                        $("#mngSeq").val(data.MNG_SEQ);
                        $("#mngSite").text(data.MNG_SITE);
                        $("#siteDesc").text(data.SITE_DESC);
                        $("#mngCompany").val(data.MNG_COMPANY);
                        $("#mngBg").val(data.MNG_BG);
                        $("#bgDesc").text(data.BG_DESC);
                        $("#mngPerson").val(data.MNG_PERSON);
                        $("#mngSystem").val(data.MNG_SYSTEM);
                        $("#systemDesc").text(data.SYSTEM_DESC);
                        $("#mngContact").val(data.MNG_CONTACT);
                        $("#mngType").val(data.MNG_TYPE);
                        $("#typeDesc").text(data.TYPE_DESC);
                        $("select[name=state]").val(data.MNG_STATUS);
                        $("#mngDescR").val(data.MNG_DESC_R);
                        $("#mngDescS").val(data.MNG_DESC_S);

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
                    mngCode: $("#mng_code").val(),
                    mngSeq: $("#mng_seq").val(),
                    mngBg: $("#mngBg").val(),
                    mngPerson: $("#mngPerson").val(),
                    mngSystem: $("#mngSystem").val(),
                    mngContact: $("#mngContact").val(),
                    mngCompany: $("#mngCompany").val(),
                    mngSite: $("#mngSite").val(),
                    mngType: $("#mngType").val(),
                    mngDescR: $("#mngDescR").val(),
                    mngDescS: $("#mngDescS").val(),
                    mngStatus: $("select[name=state]").val()
                },
                success: function (data) {
                    fnPopupSearch();
                    console.log("재조회");
                },
                error: function (request, status, error) {
                    alert("code:" + request.status + "\n" + "message:"
                        + request.responseText + "\n" + "error:"
                        + error);
                }

            });
        }


        function managePopup(target, codeId) {
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
        let openWin;

        function fnPopupCodeList(inputId) {
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

            openWin = window.open("/maintenancePopupCodeList", "" + inputId + "[조회팝업]",
                'width=' + width + ', height=' + height + ', left=' + xPos + ', top=' + yPos + ', scrollbars=no');

            //브라우저 창크기 고정
            openWin.resizeTo(width, height);
            openWin.onresize = (_ => {
                openWin.resizeTo(width, height);
            })

            //팝업창에 값보내기
            openWin.onload = function () {
                setInfoPopupText(inputId);
            };


        }

        function setInfoPopupText(inputId) {
            console.log("inputId : " + inputId);
            openWin.document.getElementById("inputId").value = inputId;

            //<--miantenancePopupCodeList title-->
            let titleValue="";
            switch(inputId){
                case inputId="mngCompany":
                    titleValue = "상호";
                    break;

                case inputId="mngPerson":
                    titleValue = "요청자";
                    break;

                case inputId="mngContact":
                    titleValue = "연락처";
                    break;

            }


            let titleElement = openWin.document.getElementById("titleId");
            let currentTitle = titleElement.innerText;
            let newTitle = currentTitle.replace('[OO]','['+titleValue+']');
            titleElement.innerText = newTitle

            //<--miantenancePopupCodeList [내용]검색-->
            let descTitleValue="";
            switch(inputId){
                case inputId="mngCompany":
                    descTitleValue = "[상호]";
                    break;

                case inputId="mngPerson":
                    descTitleValue = "[요청자]";
                    break;

                case inputId="mngContact":
                    descTitleValue = "[연락처]";
                    break;

            }


            let descTitleElement = openWin.document.getElementById("descTitle");
            let currentDescTitle = descTitleElement.innerText;
            let newDescTitle = currentDescTitle.replace('내용',descTitleValue);
            descTitleElement.innerText = newDescTitle


            document.querySelector('.popupfooter').setAttribute("id", "edit_Project");
            openWin.document.querySelector("descSearch").setAttribute("id",inputId);
        }

        $(document).keydown(function (key) {
            if (key.ctrlKey && key.which == 83) {
                key.preventDefault(); //기본동작인 저장<ctrl+s>을 막음
                fnPopupSave();
            }
            if (key.ctrlKey && key.which == 77) {
                key.preventDefault(); //기본동작인 저장<ctrl+n>을 막음 , n이안돼서 m으로 임시
                fnPopupCodeList();
            }

        });


    </script>
</head>
<body>
<div>
    <input type="hidden" id="mng_code">
    <input type="hidden" id="mng_seq">
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
            <td id="siteDesc" colspan="8"></td>


        </tr>
        <tr>
            <td>상호:</td>
            <td colspan="3"><input type="text" id="mngCompany" ondblclick="fnPopupCodeList(this.getAttribute('id'))"></td>
            <td>BG:</td>
            <td><input type="text" id="mngBg"></td>
            <td id="bgDesc" colspan="8"></td>


        </tr>
        <tr>
            <td>요청자:</td>
            <td colspan="3"><input type="text" id="mngPerson" ondblclick="fnPopupCodeList(this.getAttribute('id'))"></td>
            <td>요청시스템:</td>
            <td><input type="text" id="mngSystem"></td>
            <td id=systemDesc colspan="8"></td>


        </tr>
        <tr>
            <td>연락처:</td>
            <td colspan="3"><input type="text" id="mngContact" ondblclick="fnPopupCodeList(this.getAttribute('id'))"></td>
            <td>요청유형:</td>
            <td><input type="text" id="mngType"></td>
            <td id="typeDesc" colspan="8"></td>


        </tr>
        <tr>
            <td>상태</td>
            <td>
                <select name="state">
                    <c:forEach var="stateName" items="${stateList}">
                        <c:choose>
                            <c:when test="${stateName.COD_DESC eq '작성'}">
                                <option value="N">
                            </c:when>
                            <c:when test="${stateName.COD_DESC eq '접수'}">
                                <option value="R">
                            </c:when>
                            <c:when test="${stateName.COD_DESC eq '처리중'}">
                                <option value="S">
                            </c:when>
                            <c:when test="${stateName.COD_DESC eq '완료'}">
                                <option value="Y">
                            </c:when>
                            <c:when test="${stateName.COD_DESC eq '보류'}">
                                <option value="D">
                            </c:when>
                        </c:choose>
                        ${stateName.COD_DESC}</option>
                    </c:forEach>
                </select>
            </td>

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
        // 쿠키에서 값을 가져와서 hidden input에 설정
        let mngCodeValue = getCookie("mng_code");
        let mngSeqValue = getCookie("mng_seq");

        document.getElementById("mng_code").value = mngCodeValue;
        document.getElementById("mng_seq").value = mngSeqValue;

    });


</script>


</body>
</html>
