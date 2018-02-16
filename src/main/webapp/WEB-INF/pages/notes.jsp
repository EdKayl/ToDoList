<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Список задач</title>
    <link rel="stylesheet" type="text/css" href="/style.css">
    <script>
        function sortCol(currcol) {
            if(currcol == '${sortColumn}') {
                direction = ('ASC' == '${sortDirection}') ? 'DESC': 'ASC';
            } else {
                direction = 'ASC';
            }
            top.location = "/?isDone=${isDone}&sortColumn=" + currcol + "&sortDirection=" + direction
        }
    </script>
</head>
<body>
<br/>
<br/>

<h1>Список задач</h1>
<h3>Для сортировки нажмите на заголовок колонки.</h3>

<select id="filterIsDone" onchange="top.location=this.value">
    <option value="#">Выберите фильтр</option>
    <option value="/?isDone=*&sortColumn=${sortColumn}&sortDirection=${sortDirection}">Все</option>
    <option value="/?isDone=true&sortColumn=${sortColumn}&sortDirection=${sortDirection}">Выполненные</option>
    <option value="/?isDone=false&sortColumn=${sortColumn}&sortDirection=${sortDirection}">Невыполненные</option>
</select>
<br>
<br>

<c:url var="firstUrl" value="/?isDone=*&sortColumn=${sortColumn}&sortDirection=${sortDirection}&pageNumber=1" />
<c:url var="lastUrl" value="/?isDone=*&sortColumn=${sortColumn}&sortDirection=${sortDirection}&pageNumber=${totalPages}" />
<c:url var="prevUrl" value="/?isDone=*&sortColumn=${sortColumn}&sortDirection=${sortDirection}&pageNumber=${currentIndex - 1}" />
<c:url var="nextUrl" value="/?isDone=*&sortColumn=${sortColumn}&sortDirection=${sortDirection}&pageNumber=${currentIndex + 1}" />

<div class="pagination">
    <ul>
        <c:choose>
            <c:when test="${currentIndex == 1}">
                <li class="disabled"><a href="#">&lt;&lt;</a></li>
                <li class="disabled"><a href="#">&lt;</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="${firstUrl}">&lt;&lt;</a></li>
                <li><a href="${prevUrl}">&lt;</a></li>
            </c:otherwise>
        </c:choose>
        <c:forEach var="i" begin="${beginIndex}" end="${endIndex}">
            <c:url var="pageUrl" value="/?isDone=*&sortColumn=${sortColumn}&sortDirection=${sortDirection}&pageNumber=${i}" />
            <c:choose>
                <c:when test="${i == currentIndex}">
                    <li class="active"><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageUrl}"><c:out value="${i}" /></a></li>
                </c:otherwise>
            </c:choose>
        </c:forEach>
        <c:choose>
            <c:when test="${currentIndex == totalPages}">
                <li class="disabled"><a href="#">&gt;</a></li>
                <li class="disabled"><a href="#">&gt;&gt;</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="${nextUrl}">&gt;</a></li>
                <li><a href="${lastUrl}">&gt;&gt;</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</div>
<c:if test="${!empty notes}">
<table>
    <tr>
        <td class="table_header" onclick="sortCol('id')">Id</td>
        <td class="table_header" onclick="sortCol('addedDate')">Date</td>
        <td class="table_header" onclick="sortCol('subject')">Subject</td>
        <td class="table_header" onclick="sortCol('description')">Description</td>
        <td class="table_header" onclick="sortCol('done')">Done</td>
        <td>Edit</td>
        <td>Delete</td>
    </tr>
    <c:forEach items="${notes}" var="note">
        <tr>
            <td>${note.id}</td>
            <td>${note.addedDate}</td>
            <td>${note.subject}</td>
            <td>${note.description}</td>
            <td>${note.done}</td>
            <td><a href="/edit/${note.id}">Edit</a></td>
            <td><a href="/delete/${note.id}">Delete</a></td>
        </tr>
    </c:forEach>
</table>
</c:if>
<br>
<br>
<form action="/note/add" name="newNote" method="post" class="addNote">
    <fieldset>
        <legend>Добавить задачу</legend>
        <table>
            <tr>
                <td>Дата:</td>
                <td><input type="date" id="addedDate" name="addedDate"></td>
            </tr>
            <tr>
                <td>Задача:</td>
                <td><textarea cols="20" rows="4" id="subject" name="subject"></textarea></td>
            </tr>
            <tr>
                <td>Описание:</td>
                <td><textarea cols="20" rows="7" id="description" name="description"></textarea></td>
            </tr>
        </table>
    </fieldset>
    <p><input type="submit" value="Добавить"></p>
</form>
</body>
</html>
