<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: kma04
  Date: 2023-06-27
  Time: 오후 1:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>유지보수관리</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');

        #fixedHeader {
            position: sticky;
            top: 0;
            /*stick 적용*/
        }

        #searchCondition {
            background-color: #cccccc;
            border-collapse: collapse;
            width: 100%;
            height: 20%;
            table-layout: fixed;
            margin: auto;





        }

        tr, td{
            border: 1px solid #444444;
            padding: 10px;
            overflow:hidden;
        }

        .td input:focus {
            outline: none;

        }

        input {
            width: 100%;
            border: 0;
            outline: none;
        }

        #fixedVal {
            background-color: #cccccc;
            border-collapse: collapse;
            width: 200%;
            height: 5%;
            table-layout: fixed;
            margin: auto;

            overflow-x:scroll;


        }

        #maintenanceList {
            border-collapse: collapse;
            width: 200%;
            height: 5%;
            table-layout: fixed;
            margin: auto;

            text-overflow: ellipsis;
            white-space: nowrap;

        }

        .section{
            overflow-x:scroll;
        }


    </style>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script><!-- SheetJS CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/FileSaver.js/1.3.8/FileSaver.min.js"></script><!-- FileSaver saveAs CDN -->




</head>
<body>
<script>
    let today = new Date();
    let year = today.getFullYear();
    let month = today.getMonth() + 1;

    //1~9월 앞에 0붙이기
    if (month < 10)
        month = "0" + month.toString();
    else
        month = month;
    let date = today.getDate();

    //1~9일 앞에 0 붙이기
    if (date < 10)
        date = "0" + date.toString();
    else
        date = date;

    let day = today.getDay(); //요일

    let startDefaultDate = year + month + "01"; //시작일
    let endDefaultDate = year + month + date; //종료일

    $(document).ready(function () {
        $("#startPeriod").val(startDefaultDate);
        $("#endPeriod").val(endDefaultDate);

        $(function () {
            $("#startPeriod").datepicker({
                dateFormat: "yymmdd",
                showOn: "button",
                buttonImage: "https://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
                buttonImageOnly: true,
                buttonText: "Select date",
                setDate: startDefaultDate
            });
            $("#startPeriod").datepicker("setDate", startDefaultDate);

            $("#endPeriod").datepicker({
                dateFormat: "yymmdd",
                showOn: "button",
                buttonImage: "https://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
                buttonImageOnly: true,
                buttonText: "Select date",
                setDate: endDefaultDate
            });
            $("#endPeriod").datepicker("setDate", endDefaultDate);

        });


        fnSearch();

        $("#descSearch").keydown(function (key) {
            if (key.keyCode == 13) {
                key.preventDefault(); //기본동작인 개행<br>을 막음
                fnSearch();
            }
        });


    });

    // let startPeriod = document.getElementById("startPeriod").value;
    // let endPeriod = document.getElementById("endPeriod").value;
    //
    // console.log("startPeriod : "+startPeriod);
    // console.log("endPeriod : "+endPeriod);

    function fnSearch() {

        // let startPeriodValue = getCookie("start_period");
        // let endPeriodValue = getCookie("end_period");
        //
        //
        // //쿠키가 저장안돼있을경우, 현재시작일자 들어가야됨
        // let resultStartPeriodValue = startPeriodValue == null || undefined || "" ? startDefaultDate : startPeriodValue;
        // let resultEndPeriodValue = endPeriodValue == null || undefined || "" ? endDefaultDate : endPeriodValue;
        //
        // console.log("resultStartPeriodValue : " + resultStartPeriodValue);
        // console.log("resultEndPeriodValue : " + resultEndPeriodValue);
        //
        // document.getElementById("startPeriod").value = resultStartPeriodValue;
        // document.getElementById("endPeriod").value = resultEndPeriodValue;

        $
            .ajax({
                url: "getMaintenanceList", //요청할 url, 주소:포트(http://localhost:8080)는 일반적으로 생략
                type: "GET", //요청 방식 - GET:조회, POST:입력
                cache: false, //캐쉬 - 임시로 데이터를 저장할지 여부, 거의 false
                dataType: "json", //데이터의 형식, 거의 json
                data: {
                    startPeriod: $("#startPeriod").val(),
                    endPeriod: $("#endPeriod").val(),
                    // startPeriod:resultStartPeriodValue,
                    // endPeriod:resultEndPeriodValue,
                    mngStatus: $("select[name=state]").val(),
                    descSearch: $("#descSearch").text(),
                    mngCompany: $("#mngCompany").text(),
                    mngPerson: $("#mngPerson").text(),
                    mngContact: $("#mngContact").text(),

                    mngSite: $("#mngSite").text(),
                    mngBg: $("#mngBg").text(),
                    mngSystem: $("#mngSystem").text(),
                    mngType: $("#mngType").text()


                },

                success: function (data) { //데이터 송,수신에 성공했을 경우의 동작
                    console.log(data);
                    let t = "";
                    t += "<colgroup>";
                    t += "<col style='width:1%'>";
                    t += "<col style='width:2%'>";
                    t += "<col style='width:1%'>";
                    t += "<col style='width:4%'>";
                    t += "<col style='width:2%'>";
                    t += "<col style='width:2%'>";
                    t += "<col style='width:1%'>";
                    t += "<col style='width:1%'>";
                    t += "<col style='width:1%'>";
                    t += "<col style='width:1%'>";
                    t += "<col style='width:10%'>";
                    t += "<col style='width:10%'>";
                    t += "<col style='width:2%'>";
                    t += "<col style='width:2%'>";
                    t += "<col style='width:2%'>";
                    t += "<col style='width:2%'>";
                    t += "<col style='width:2%'>";
                    t += "</colgroup>";

                    for (let i = 0; i < data.length; i++) {
                        let mngCodeSum = data[i].MNG_CODE_SUM;
                        let stgt = data[i].STGT;
                        let dataNo = data[i].NO;

                        let mngCode = data[i].MNG_CODE;
                        let mngSeq = data[i].MNG_SEQ;
                        let mngCompany = data[i].MNG_COMPANY;
                        let mngPerson = data[i].MNG_PERSON;
                        let mngContact = data[i].MNG_CONTACT;
                        let mngSite = data[i].SITE_DESC;
                        let mngBg = data[i].BG_DESC;
                        let mngSystem = data[i].SYSTEM_DESC;
                        let mngType = data[i].TYPE_DSEC;
                        let mngDescR = data[i].MNG_DESC_R;
                        let mngDescS = data[i].MNG_DESC_S;
                        let mngStatus = data[i].MNG_STATUS;
                        let mngStart = data[i].MNG_START;
                        let mngClose = data[i].MNG_CLOSE;
                        let createDate = data[i].CREATE_DATE;
                        let saveDate = data[i].SAVE_DATE;

                        switch (mngStatus) {
                            case "N":
                                mngStatus = "작성";
                                break;
                            case "R":
                                mngStatus = "접수";
                                break;
                            case "S":
                                mngStatus = "처리중";
                                break;
                            case "Y":
                                mngStatus = "완료";
                                break;
                            case "D":
                                mngStatus = "보류";
                                break;

                        }


                        if (data[i].MNG_CODE_SUM == null) {
                            t += "<tr class='mngData' onClick=\"HighLightTR(this,'#c9cc99','cc3333',"+mngCode+","+ mngSeq +");\" ondblclick=\"managePopup(this," + mngCode + "," + mngSeq + ");\">";
                            t += "<td>" + dataNo + "</td>";
                            t += "<td>" + mngCode + "</td>";
                            t += "<td>" + mngSeq + "</td>";
                            t += "<td>" + mngCompany + "</td>";
                            t += "<td>" + mngPerson + "</td>";
                            t += "<td>" + mngContact + "</td>";
                            t += "<td>" + mngSite + "</td>";
                            t += "<td>" + mngBg + "</td>";
                            t += "<td>" + mngSystem + "</td>";
                            t += "<td>" + mngType + "</td>"; /*요청유형*/
                            t += "<td>" + mngDescR + "</td>";
                            t += "<td>" + mngDescS + "</td>";
                            t += "<td>" + mngStatus + "</td>";/*요청상태*/
                            t += "<td>" + mngStart + "</td>";/*접수자*/
                            t += "<td>" + mngClose + "</td>";/*처리자*/
                            t += "<td>" + createDate + "</td>";/*생성일자*/
                            t += "<td>" + saveDate + "</td>";/*수정일자*/
                            t += "</tr>";
                        } else {
                            t += "<tr class='mngSum'>";
                            if (mngCodeSum == '소계') {
                                t += "<td colspan='4' style=background-color:teal;color:white;text-align:center;>" + mngCodeSum + "</td>";
                                t += "<td colspan='13' style=background-color:gray;color:white;text-align:left;>" + stgt + "건</td>";
                            } else {
                                t += "<td colspan='4' style=background-color:teal;color:white;text-align:center;position:sticky;bottom:0;>" + mngCodeSum + "</td>";
                                t += "<td colspan='13' style=background-color:gray;color:white;text-align:left;position:sticky;bottom:0;>" + stgt + "건</td>";
                            }

                            t += "</tr>";


                        }


                    }
                    $("#maintenanceList").html(t);


                }
                ,
                error: function (request, status, error) { // 오류가 발생했을 경우의 동작
                    alert("code:" + request.status + "\n" + "message:"
                        + request.responseText + "\n" + "error:"
                        + error);
                }
            })

    }

    /*td 클릭시 하이라이트*/
    let orgBColor = '#ffffff';
    let orgTColor = '#000000';

    function HighLightTR(target, backColor, textColor, mngCode, mngSeq) {
        let tbody = target.parentNode;
        let trs = tbody.getElementsByTagName('tr');

        for (let i = 0; i < trs.length; i++) {

            if (trs[i] != target) {
                trs[i].style.backgroundColor = orgBColor;
                trs[i].style.color = orgTColor;
            } else {
                trs[i].style.backgroundColor = backColor;
                trs[i].style.color = textColor;

                //셀 선택 후 엔터 눌렀을때 팝업창
                $(document).keydown(function (key) {
                    if (key.which == 13) {
                        key.preventDefault(); //기본동작인 Enter 을 막음
                        managePopup(target, mngCode, mngSeq);
                    }
                });
            }
        }
    }

    //maintenace.jsp -> maintenanceInfoPopup.jsp
    let openWin;

    function managePopup(target, mngCode, mngSeq) {
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

                openWin = window.open("/maintenanceInfoPopup", "[유지보수관리상세]",
                    'width=' + width + ', height=' + height + ', left=' + xPos + ', top=' + yPos + ', scrollbars=no');

                //브라우저 창크기 고정
                openWin.resizeTo(width, height);
                openWin.onresize = (_ => {
                    openWin.resizeTo(width, height);
                })

                //팝업창에 값보내기
                openWin.onload = function () {
                    setMaintenanceInfoPopupText(mngCode, mngSeq);
                };


                // window.open("/maintenanceInfoPopup", "[유지보수관리상세]",
                //     'width=400, height=600, left=400, top=400, resizable = no');

            }
        }
    }

    function setMaintenanceInfoPopupText(mngCode, mngSeq) {
        openWin.document.getElementById("mng_code").value = mngCode;
        openWin.document.getElementById("mng_seq").value = mngSeq;

    }


</script>

    <div id="fixedHeader">
        <table id="searchCondition">
            <tr>
                <td>기간
                    <button <%--onclick="deleteCookie(name);"--%>>init</button>
                </td>
                <td colspan="1">
                    <input type="text" id="startPeriod" onchange="fnSearch()"
                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                           style="border: none; background: transparent; font-size:16px; width:30%;">
                    <input type="hidden" id="start_period">
                </td>
                <td>
                    <input type="text" id="endPeriod" onchange="fnSearch()"
                           oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                           style="border: none; background: transparent; font-size:16px; width:30%;"><%--input 테두리투명, 배경투명--%>
                    <input type="hidden" id="end_period">
                </td>

                <td>상태 :</td>
                <td>
                    <select name="state" onchange="fnSearch()">
                        <option value="ALL">전체</option>
                        <%--전체부분은 stateList에 저장안했기때문에 수동으로 추가--%>
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
            </tr>
            <tr>
                <td>Site :</td>
                <td id="mngSite" class="rowColumn" contenteditable="false"
                    ondblclick="fnCodeList(this.getAttribute('id'))"></td>
                <td id="mngSiteDesc"></td>
                <td>BG :</td>
                <td id="mngBg" class="rowColumn" contenteditable="false"
                    ondblclick="fnCodeList(this.getAttribute('id'))"></td>
                <td id="mngBgDesc"></td>
            </tr>
            <tr>
                <td>System :</td>
                <td id="mngSystem" class="rowColumn" contenteditable="false"
                    ondblclick="fnCodeList(this.getAttribute('id'))"></td>
                <td id="mngSystemDesc"></td>
                <td>Type :</td>
                <td id="mngType" class="rowColumn" contenteditable="false"
                    ondblclick="fnCodeList(this.getAttribute('id'))"></td>
                <td id="mngTypeDesc"></td>
            </tr>
            <tr>
                <td>상호 :</td>
                <td id="mngCompany" class="rowColumn" contenteditable="false"
                    ondblclick="fnPopupCodeList(this.getAttribute('id'))"></td>
                <td>요청자 :</td>
                <td id="mngPerson" class="rowColumn" contenteditable="false"
                    ondblclick="fnPopupCodeList(this.getAttribute('id'))"></td>
                <td>연락처 :</td>
                <td id="mngContact" class="rowColumn" contenteditable="false"
                    ondblclick="fnPopupCodeList(this.getAttribute('id'))"></td>
            </tr>
            <tr>
                <td>내용검색</td>
                <td colspan="5" id="descSearch" class="rowColumn"
                    contenteditable="false"><%--<input type="text" id="descSearch">--%></td>
            </tr>


        </table>

    </div>
    <div class="section">
        <table id="fixedVal">
            <colgroup>
                <col style="width:1%">
                <col style="width:2%">
                <col style="width:1%">
                <col style="width:4%">
                <col style="width:2%">
                <col style="width:2%">
                <col style="width:1%">
                <col style="width:1%">
                <col style="width:1%">
                <col style="width:1%">
                <col style="width:10%">
                <col style="width:10%">
                <col style="width:2%">
                <col style="width:2%">
                <col style="width:2%">
                <col style="width:2%">
                <col style="width:2%">
            </colgroup>
            </colgroup>
            <thead>
            <tr>
                <th>No.</th>
                <th>업무일자</th>
                <th>순번</th>
                <th>상호</th>
                <th>요청자</th>
                <th>연락처</th>
                <th>요청Site</th>
                <th>BG</th>
                <th>요청시스템</th>
                <th>요청유형</th>
                <th>요청내용</th>
                <th>처리내용</th>
                <th>상태</th>
                <th>접수자</th>
                <th>처리자</th>
                <th>생성일자</th>
                <th>수정일자</th>
            </tr>
            </thead>
        </table>
        <table id="maintenanceList">
        </table>
    </div>


<script>

    /*

        //header_fixed_on_scroll
        let header = document.querySelector(".header");
        let headerHeight = header.offsetHeight;

        window.onscroll = function () {
            let windowTop = window.scrollY;
            // 스크롤 세로값이 헤더높이보다 크거나 같으면
            // 헤더에 클래스 'drop'을 추가한다
            if (windowTop >= headerHeight) {
                header.classList.add("drop");
            }
            // 아니면 클래스 'drop'을 제거
            else {
                header.classList.remove("drop");
            }
        };

    */

    //단일값만 할경우
    /*

    content = document.querySelector( "[contenteditable]" );
    document.addEventListener("DOMContentLoaded", function() {
        content.addEventListener("dblclick", function(event) {
            // @details contenteditable 속성이 수정 불가인 경우 실행( false )
            if(content.isContentEditable == false) {

                // @details 편집 가능 상태로 변경
                content.contentEditable = true;


                // @details CSS 효과 추가
                content.style.border = "1px solid #FE7F9C";

                content.focus();
            }else{
                // 편집 불가 상태로 변경
                content.contentEditable = false;
                content.style.border = "0px";
            }
        })
    });

    */

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

//         let startPeriodValue = getCookie("start_period");
//         let endPeriodValue = getCookie("end_period");
//
// //        document.getElementById("startPeriod").value = startPeriodValue;
// //        document.getElementById("endPeriod").value = endPeriodValue;
//
//         //쿠키가 저장안돼있을경우, 현재시작일자 들어가야됨
//         let resultStartPeriodValue = startPeriodValue == null || undefined || "" ? startDefaultDate : startPeriodValue;
//         let resultEndPeriodValue = endPeriodValue == null || undefined || "" ? endDefaultDate : endPeriodValue;
//
//         document.getElementById("startPeriod").value = resultStartPeriodValue;
//         document.getElementById("endPeriod").value = resultEndPeriodValue;
//
//         console.log("쿠키갖고오기 ==>")
//         console.log("resultStartPeriodValue : " + resultStartPeriodValue);
//         console.log("resultEndPeriodValue : " + resultEndPeriodValue);
//         console.log("/쿠키갖고오기 ==>")

    });


    // // startPeriod --> start_period, endPeriod --> end_period
    // document.getElementById("startPeriod").onchange = function(){
    //     let startPeriodValue = document.getElementById("startPeriod").value;
    //     document.getElementById("start_period").value = startPeriodValue;
    //     fnSearch();
    //
    //     //쿠키에 값 저장(세션쿠키설정)
    //     let start_period = startPeriodValue;
    //     setCookie("start_period",start_period);
    // };
    // document.getElementById("endPeriod").onchange = function(){
    //     let endPeriodValue = document.getElementById("endPeriod").value;
    //     document.getElementById("end_period").value = endPeriodValue;
    //     fnSearch();
    //
    //     //쿠키에 값 저장(세션쿠키설정)
    //     let end_period = endPeriodValue;
    //     setCookie("end_period",end_period);
    // };


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

    //쿠키삭제
    function deleteCookie(name) {

        location.reload();
    }

    //maintenace.jsp -> maintenancePopupCodeList.jsp
    let openMaintenancePopupCodeList;

    function fnPopupCodeList(inputId) {
        console.log("fnPopupCodeList(inputId) : " + inputId);
        //팝업 가운데정렬
        let width = 1000;
        let height = 800;
        let xPos = (document.body.offsetWidth / 2) - (width / 2); // 가운데 정렬
        xPos += window.screenLeft; // 듀얼 모니터일 때
        let yPos = (document.body.offsetHeight / 2) - (height / 2);

        // 이미 열린 팝업이 있는 경우 닫아줍니다.
        if (openMaintenancePopupCodeList && !openMaintenancePopupCodeList.closed) {
            openMaintenancePopupCodeList.close();
        }
        openMaintenancePopupCodeList = window.open("/maintenancePopupCodeList", "" + inputId + "[조회팝업]",
            'width=' + width + ', height=' + height + ', left=' + xPos + ', top=' + yPos + ', scrollbars=no');


        //브라우저 창크기 고정
        openMaintenancePopupCodeList.resizeTo(width, height);
        openMaintenancePopupCodeList.onresize = (_ => {
            openMaintenancePopupCodeList.resizeTo(width, height);
        })

        //팝업창에 값보내기
        openMaintenancePopupCodeList.onload = function () {
            setMaintenancePopupCodeListText(inputId);
        };


    }

    //

    function setMaintenancePopupCodeListText(inputId) {
        console.log("setMaintenancePopupCodeListText(inputId) : " + inputId);

        openMaintenancePopupCodeList.document.getElementById("inputId").value = inputId;
        openMaintenancePopupCodeList.document.getElementById("popupGb").value = "maintenance"

            //<--miantenancePopupCodeList title-->
            let titleValue = "";
            switch (inputId) {

                case inputId = "mngCompany":
                    titleValue = "상호";
                    break;

                case inputId = "mngPerson":
                    titleValue = "요청자";
                    break;

                case inputId = "mngContact":
                    titleValue = "연락처";
                    break;

            }


            let titleElement = openMaintenancePopupCodeList.document.getElementById("titleId");
            let currentTitle = titleElement.innerText;
            let newTitle = currentTitle.replace('[OO]', '[' + titleValue + ']');
            titleElement.innerText = newTitle

            //<--miantenancePopupCodeList [내용]검색-->
            let descTitleValue = "";
            switch (inputId) {
                case inputId = "mngCompany":
                    descTitleValue = "[상호]";
                    break;

                case inputId = "mngPerson":
                    descTitleValue = "[요청자]";
                    break;

                case inputId = "mngContact":
                    descTitleValue = "[연락처]";
                    break;

            }


            let descTitleElement = openMaintenancePopupCodeList.document.getElementById("descTitle");
            let currentDescTitle = descTitleElement.innerText;
            let newDescTitle = currentDescTitle.replace('내용', descTitleValue);
            descTitleElement.innerText = newDescTitle

    }

    //maintenace.jsp -> maintenanceCodeList.jsp
    let openMaintenanceCodeList
    function fnCodeList(inputId){
        console.log("fnCodeList(inputId) : " + inputId);
        //팝업 가운데정렬
        let width = 1000;
        let height = 800;
        let xPos = (document.body.offsetWidth / 2) - (width / 2); // 가운데 정렬
        xPos += window.screenLeft; // 듀얼 모니터일 때
        let yPos = (document.body.offsetHeight / 2) - (height / 2);

        // 이미 열린 팝업이 있는 경우 닫아줍니다.
        if (openMaintenanceCodeList && !openMaintenanceCodeList.closed) {
            openMaintenanceCodeList.close();
        }

        openMaintenanceCodeList = window.open("/maintenanceCodeList", "" + inputId + "[조회팝업]",
            'width=' + width + ', height=' + height + ', left=' + xPos + ', top=' + yPos + ', scrollbars=no');


        //브라우저 창크기 고정
        openMaintenanceCodeList.resizeTo(width, height);
        openMaintenanceCodeList.onresize = (_ => {
            openMaintenanceCodeList.resizeTo(width, height);
        })

        //팝업창에 값보내기
        openMaintenanceCodeList.onload = function () {
            setMaintenanceCodeListSelect(inputId);
        };
    }

    function setMaintenanceCodeListSelect(inputId){

        openMaintenanceCodeList.document.getElementById("popupGb").value = "maintenance";
        openMaintenanceCodeList.document.getElementById("codeType").disabled = "disabled";
        openMaintenanceCodeList.document.getElementById("inputId").value= inputId;

        switch (inputId) {
            case inputId = "mngSite":
                openMaintenanceCodeList.document.querySelector("select[name='codeType']").value="SITE";
                //Jquery -> openMaintenanceCodeList.$("select[name=codeType]").val("SITE");
                break;
            case inputId = "mngBg":
                openMaintenanceCodeList.document.querySelector("select[name='codeType']").value="BG";
                break;
            case inputId = "mngSystem":
                openMaintenanceCodeList.document.querySelector("select[name='codeType']").value="SYSTEM";
                break;
            case inputId = "mngType":
                openMaintenanceCodeList.document.querySelector("select[name='codeType']").value="TYPE";
                break;
        }
        openMaintenanceCodeList.parent.fnCodeSearch();
    }

    let newWin;
    let newMngCode;
    let newMngSeq;

    //신규 추가함수
    function fnPopupNew(){
        $.ajax({
            url: "getNew",
            type: "GET",
            cache: false,

            success: function (data) {
                console.log(data);
                newMngCode =  data.MNG_CODE;
                newMngSeq =  data.MNG_SEQ;

                //팝업 가운데정렬
                let width = 1000;
                let height = 800;
                let xPos = (document.body.offsetWidth / 2) - (width / 2); // 가운데 정렬
                xPos += window.screenLeft; // 듀얼 모니터일 때
                let yPos = (document.body.offsetHeight / 2) - (height / 2);

                // 이미 열린 팝업이 있는 경우 닫아줍니다.
                if (newWin && !newWin.closed) {
                    newWin.close();
                }



                newWin = window.open("/maintenanceInfoPopup", "[유지보수관리상세_삽입]",
                    'width=' + width + ', height=' + height + ', left=' + xPos + ', top=' + yPos + ', scrollbars=no');

                //브라우저 창크기 고정
                newWin.resizeTo(width, height);
                newWin.onresize = (_ => {
                    newWin.resizeTo(width, height);
                })

                //팝업창에 값보내기
                newWin.onload = function () {
                    setMaintenanceNewInfoPopupText(newMngCode,newMngSeq)
                };

            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:"
                    + request.response.status + "\n" + "error:"
                    + error);
            }

        });

    }

    function setMaintenanceNewInfoPopupText(newMngCode,newMngSeq){
        newWin.document.getElementById("mng_code").value = newMngCode;
        newWin.document.getElementById("mng_seq").value = newMngSeq;
    }


    $(document).keydown(function (key) {
        if (key.which == 114) {
            key.preventDefault(); //기본동작인 <F3>을 막음
            fnPopupNew();
            //신규추가함수
        }
        if (key.which == 115) {
            key.preventDefault(); //기본동작인 <F4>을 막음
            //삭제함수
        }
        if (key.which == 118) {
            key.preventDefault(); //기본동작인 <F7>을 막음
            //엑셀저장함수
            exportExcel();
        }
        if (key.which == 119) {
            key.preventDefault(); //기본동작인 <F8>을 막음
            //조회함수
        }

    });



  //공통
    // 참고 출처 : https://redstapler.co/sheetjs-tutorial-create-xlsx/
    function s2ab(s) {
        let buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
        let view = new Uint8Array(buf);  //create uint8array as viewer
        for (let i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet

        return buf;
    }

    function exportExcel(){
        // step 1. workbook 생성
        let wb = XLSX.utils.book_new();
        console.log(wb);

        // step 2. 시트 만들기
        let newWorksheet = excelHandler.getWorksheet();

        // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.
        XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

        // step 4. 엑셀 파일 만들기
        let wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

        // step 5. 엑셀 파일 내보내기
        saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
    }

    let excelHandler = {
        getExcelFileName : function(){
            return 'HD현대_유지보수현황.xlsx';
        },
        getSheetName : function(){
            return 'HD현대_유지보수현황';
        },
        getFixedValTable: function () {
            return document.getElementById('fixedVal');
        },
        getMaintenanceListTable: function () {
            return document.getElementById('maintenanceList');
        },
/*
        getWorksheet : function(){
            return XLSX.utils.table_to_sheet(this.getExcelData());
        }
*/
        getCombinedData: function () {
            let fixedValData = this.getFixedValTableData(this.getFixedValTable());
            let maintenanceListData = this.getMaintenanceListTableData(this.getMaintenanceListTable());

            // 데이터 병합
            let combinedData = fixedValData.concat(maintenanceListData);

            return combinedData;
        },
        getMaintenanceListTableData: function (table) {
            let data = [];
            let rows = table.querySelectorAll('tr.mngData'); //소계값은 출력이되면 안돼서

            for (let row of rows) {
                let rowData = [];
                let cells = row.querySelectorAll('td');

                for (let cell of cells) {
                    rowData.push(cell.textContent);
                }

                data.push(rowData);
            }

            return data;
        },
        getFixedValTableData: function (table) {
            let data = [];
            let rows = table.querySelectorAll('tr');

            for (let row of rows) {
                let rowData = [];
                let cells = row.querySelectorAll('th');

                for (let cell of cells) {
                    rowData.push(cell.textContent);
                }

                data.push(rowData);
            }

            return data;
        },

        getWorksheet: function () {
            let combinedData = this.getCombinedData();

            // JSON 데이터를 워크시트로 변환
            let worksheet = XLSX.utils.json_to_sheet(combinedData);
            //console.log("worksheet : " + JSON.stringify(worksheet));

            return worksheet;
        }


    }


</script>

<jsp:include page="footer.jsp"></jsp:include>
</body>


</html>
