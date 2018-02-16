<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <title>Редактирование записи</title>
</head>
<body>
<h1>Редактирование записи</h1>
<form action="/note/save" name="saveNote" method="post">
    <fieldset>
        <p><label for="id">#</label><input type="number" id="id" name="id" value=${note.id}></p>
        <p><label for="addedDate">Дата:</label><input type="date" id="addedDate" name="addedDate" value=${note.addedDate}></p>
        <p><label for="subject">Задача:</label><input type="text" id="subject" name="subject" value=${note.subject}></p>
        <p><label for="description">Описание:</label><input type="text" id="description" name="description" value=${note.description}></p>
        <p><label for="done">Выполнено:</label><input type="checkbox" id="done" name="done" value=${note.done}></p>
    </fieldset>
    <p><input type="submit" value="Сохранить"></p>
</form>
</body>
</html>