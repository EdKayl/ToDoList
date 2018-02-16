<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title>Редактирование записи</title>
</head>
<body>
<h1>Редактирование записи</h1>
<form action="/note/save" name="saveNote" method="post">
    <fieldset>
        <table>
            <tr>
                <td>#</td>
                <td><input type="number" name="id" readonly value=${note.id}></td>
            </tr>
            <tr>
                <td>Дата:</td>
                <td><input type="date" name="addedDate" value=${note.addedDate}></td>
            </tr>
            <tr>
                <td>Задача:</td>
                <td><textarea cols="20" rows="4" name="subject" >${note.subject}</textarea></td>
            </tr>
            <tr>
                <td>Описание:</td>
                <td><textarea cols="20" rows="7" name="description">${note.description}</textarea></td>
            </tr>
            <tr>
                <td>Выполнено:</td>
                <c:if test="${note.done}">
                    <td><input type="checkbox" name="done" checked></td>
                </c:if>
                <c:if test="${!note.done}">
                    <td><input type="checkbox" name="done"></td>
                </c:if>
            </tr>
        </table>
    </fieldset>
    <p><input type="submit" value="Сохранить"></p>
</form>
</body>
</html>