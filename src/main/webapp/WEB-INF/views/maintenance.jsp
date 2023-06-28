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
  <script>
    $( function() {
      $( "#startPeriod" ).datepicker({
        showOn: "button",
        buttonImage: "https://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
        buttonImageOnly: true,
        buttonText: "Select date"
      });
    } );

  </script>

</head>
<body>
<table id="searchCondition">
  <tr>
    <td>기간</td>
    <td colspan="1">
      <p>Date: <input type="text" id="startPeriod"></p>
    </td>
    <td>
      <input type="text" id="endPeriod">
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
    <td></td>
    <td></td>
    <td>Type : </td>
    <td></td>
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



</body>
</html>
