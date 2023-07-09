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

        tr, td {
            border-top: 1px solid #444444;
            border-bottom: 1px solid #444444;
            border-left: 1px solid #444444;
            border-right: 1px solid #444444;
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

        #fixedVal {
            background-color: #cccccc;
            border-collapse: collapse;
            width: 200%;
            height: 5%;
            table-layout: fixed;
            margin: auto;

        }

        #maintenanceList {
            border-collapse: collapse;
            width: 200%;
            height: 5%;
            table-layout: fixed;
            margin: auto;
        }

    </style>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


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


    //let endPeriod = document.getElementById("endPeriod").value;

    //console.log("startPeriod : "+startPeriod);
    //console.log("endPeriod : "+endPeriod);

    function fnSearch() {
        $
            .ajax({
                url: "getMaintenanceList", //요청할 url, 주소:포트(http://localhost:8080)는 일반적으로 생략
                type: "GET", //요청 방식 - GET:조회, POST:입력
                cache: false, //캐쉬 - 임시로 데이터를 저장할지 여부, 거의 false
                dataType: "json", //데이터의 형식, 거의 json
                data: {
                    startPeriod: $("#startPeriod").val(),
                    endPeriod: $("#endPeriod").val(),
                    mngStatus: $("select[name=state]").val(),
                    descSearch: $("#descSearch").text()





                    //나머지데이터는 추후에

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
                        let mngSite = data[i].MNG_SITE;
                        let mngBg = data[i].MNG_BG;
                        let mngSystem = data[i].MNG_SYSTEM;
                        let mngType = data[i].MNG_TYPE;
                        let mngDescR = data[i].MNG_DESC_R;
                        let mngDescS = data[i].MNG_DESC_S;
                        let mngStatus = data[i].MNG_STATUS;
                        let mngStart = data[i].MNG_START;
                        let mngClose = data[i].MNG_CLOSE;
                        let createDate = data[i].CREATE_DATE;
                        let saveDate = data[i].SAVE_DATE;




                        if (data[i].MNG_CODE_SUM == null) {
                            t += "<tr onClick=\"HighLightTR(this,'#c9cc99','cc3333');\" ondblclick=\"managePopup(this," + mngCode + "," + mngSeq + ");\">";
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
                            t += "<tr>";
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

    function HighLightTR(target, backColor, textColor) {
        let tbody = target.parentNode;
        let trs = tbody.getElementsByTagName('tr');

        for (let i = 0; i < trs.length; i++) {

            if (trs[i] != target) {
                trs[i].style.backgroundColor = orgBColor;
                trs[i].style.color = orgTColor;
            } else {
                trs[i].style.backgroundColor = backColor;
                trs[i].style.color = textColor;
            }
        }
    }

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
                    setInfoPopupText(mngCode, mngSeq);
                };


                // window.open("/maintenanceInfoPopup", "[유지보수관리상세]",
                //     'width=400, height=600, left=400, top=400, resizable = no');

            }
        }
    }

    function setInfoPopupText(mngCode, mngSeq) {
        openWin.document.getElementById("mngCode").value = mngCode;
        openWin.document.getElementById("mngSeq").value = mngSeq;

    }


</script>
<%--시스템 유지보수 데이터 인터넷--%>
<%--

<div class="header">
    <ul>
        <li><a href="">menu1</a></li>
        <li><a href="">menu2</a></li>
        <li><a href="">menu3</a></li>
    </ul>
</div>

--%>
<div id="fixedHeader">
    <table id="searchCondition">
        <tr>
            <td>기간</td>
            <td colspan="1">
                <input type="text" id="startPeriod" onchange="fnSearch()"
                       oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                       style="border: none; background: transparent; font-size:16px; width:30%;">
            </td>
            <td>
                <input type="text" id="endPeriod" onchange="fnSearch()"
                       oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                       style="border: none; background: transparent; font-size:16px; width:30%;"><%--input 테두리투명, 배경투명--%>
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
            <td id="site" class="rowColumn" contenteditable="false"></td>
            <td></td>
            <td>BG :</td>
            <td id="bg" class="rowColumn" contenteditable="false"></td>
            <td></td>
        </tr>
        <tr>
            <td>System :</td>
            <td id="System" class="rowColumn" contenteditable="false"></td>
            <td></td>
            <td>Type :</td>
            <td id="Type" class="rowColumn" contenteditable="false"></td>
            <td></td>
        </tr>
        <tr>
            <td>상호 :</td>
            <td id="businessName" class="rowColumn" contenteditable="false"></td>
            <td>요청자 :</td>
            <td id="requestName" class="rowColumn" contenteditable="false"></td>
            <td>연락처 :</td>
            <td id="phoneNum" class="rowColumn" contenteditable="false"></td>
        </tr>
        <tr>
            <td>내용검색</td>
            <td colspan="5" id="descSearch" class="rowColumn"
                contenteditable="false"><%--<input type="text" id="descSearch">--%></td>
        </tr>


    </table>
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
</div>
<div id="section">
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


    });


</script>

</body>


</html>
