# boot
SpringBoot + myBatis + jsp 세팅연습

## 🖥️ 프로젝트 소개

<br>

## 🕰️ 개발 기간
* ~ 

### 🧑‍🤝‍🧑 맴버구성
* 백근우

### ⚙️ 개발 환경
- `Java 17`
- `JDK 17`
- **IDE** : intellij, DataGrip 
- **Framework** : Spring boot 3.1.0
- **Database** : ORACLE

## 📌 주요 기능
## 
  


## 📌 오류 발생 & 해결 
****오류1****

**foodNutritionInfo.jsp**
//한페이지에 나타낼 글 수가 10 초과할경우 오류가있음.
```
if (pageNo == 1) {
    realPageNo = currentCnt;
    t += "<td>" + realPageNo + "</td>"; //1~9
} else {
    if (currentCnt == 10) { //화면상 No의 마지막 10일경우
        realPageNo = Number((pageNo + 1).toString() + (0).toString());
        t += "<td>" + realPageNo + "</td>";

    } else { // 화면상 No가 20, 30, ...100. 의경우
        realPageNo = Number(pageNo.toString() + currentCnt.toString());
        t += "<td>" + realPageNo + "</td>";
    }
}
```
![image](https://github.com/100rootrain/boot/assets/126217303/86f6089e-56ca-414c-ac8a-c4d81d106232)


Ajax로 불러올때 식품이름 번호를 붙일때 첫화면의 번호가 초과할경우 1~10이 고정인것을 해결하기 위해서 
짠코드. 억지로 그릴려다보니 셀렉트박스에서 15, 20을 선택하면 번호가 두번째화면부터 다음번호로 진행이안되는 오류가 생김 

**해결1**
```
if(pageNo>1){
    t += "<td>" +((dataPerPage *(pageNo-1))+currentCnt)   + "</td>";
    //페이징 2부터는 클릭한 목록번호 * ( 클릭한 목록번호-1) + 화면에 보이는 게시글 번호)
}else{
    t += "<td>" + currentCnt + "</td>"; //식품번호
}
```
![image](https://github.com/100rootrain/boot/assets/126217303/a585bed7-5516-42d3-8cac-8fc2ff90e365)


****오류2****

