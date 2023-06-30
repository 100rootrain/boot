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
    <title>maintenance</title>
  <style>
    #searchCondition{
      border-collapse: collapse;
      width:80%;
      height:20%;
      table-layout : fixed;
      margin:auto;
    }
    tr, td {
      border-top: 1px solid #444444;
      border-bottom: 1px solid #444444;
      border-left: 1px solid #444444;
      border-right: 1px solid #444444;
      padding: 10px;
    }

    .td input:focus{
      outline: none;
    }

    input{
      width:100%;
      border: 0;
      outline: none;
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
  let month = today.getMonth()+1;
  if(month <10)
    month='0'+month.toString();
  else
    month= month;
  let date = today.getDate();
  let day = today.getDay(); //요일
  let startDefaultDate = year + month + '01';
  let endDefaultDate = year + month + date;

  console.log(startDefaultDate);
  console.log(endDefaultDate);





  $(document).ready(function () {
    $( function() {
      $( "#startPeriod" ).datepicker({
        dateFormat: "yymmdd",
        showOn: "button",
        buttonImage: "https://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
        buttonImageOnly: true,
        buttonText: "Select date",
        setDate: startDefaultDate
      });
      $("#startPeriod").datepicker('setDate',startDefaultDate);

      $( "#endPeriod" ).datepicker({
        dateFormat: "yymmdd",
        showOn: "button",
        buttonImage: "https://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
        buttonImageOnly: true,
        buttonText: "Select date",
        setDate: endDefaultDate
      });
      $("#endPeriod").datepicker('setDate',endDefaultDate);

    } );



  });






  //let endPeriod = document.getElementById("endPeriod").value;

  //console.log("startPeriod : "+startPeriod);
  //console.log("endPeriod : "+endPeriod);

  function fnSearch(){
    $
            .ajax({
              url : "getMaintenanceList", //요청할 url, 주소:포트(http://localhost:8080)는 일반적으로 생략
              type : "GET", //요청 방식 - GET:조회, POST:입력
              cache : false, //캐쉬 - 임시로 데이터를 저장할지 여부, 거의 false
              dataType : "json", //데이터의 형식, 거의 json
              data : {
                startPeriod : $("#startPeriod").val(),
                endPeriod : $("#endPeriod").val()
                //나머지데이터는 추후에

              },

              success : function(data) { //데이터 송,수신에 성공했을 경우의 동작
                console.log(data);


              },
              error : function(request, status, error) { // 오류가 발생했을 경우의 동작
                alert("code:" + request.status + "\n" + "message:"
                        + request.responseText + "\n" + "error:"
                        + error);
              }
            });
  }

</script>


<table id="searchCondition">
  <tr>
    <td>기간</td>
    <td colspan="1">
      <p>Date: <input type="text" id="startPeriod" value="${startPeriod}" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"></p>
    </td>
    <td>
      <p>Date: <input type="text" id="endPeriod"></p>
    </td>

    <td>상태 : </td>
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
  </tr>
  <tr>
    <td>Site : </td>
    <td>
      <input type="text" id="site">
    </td>
    <td></td>
    <td>BG : </td>
    <td>
      <input type="text" id="bg">
    </td>
    <td></td>
  </tr>
  <tr>
    <td>System : </td>
    <td><input type="text" id="System"></td>
    <td></td>
    <td>Type : </td>
    <td><input type="text" id="Type"></td>
    <td></td>
  </tr>
  <tr>
    <td>상호 : </td>
    <td>
      <input type="text" id="businessName">
    </td>
    <td>요청자 : </td>
    <td>
      <input type="text" id="requestName">
    </td>
    <td>연락처 : </td>
    <td>
      <input type="text" id="phoneNum">
    </td>
  </tr>


</table>
<table id="maintenanceList">

</table>



</body>



</html>
