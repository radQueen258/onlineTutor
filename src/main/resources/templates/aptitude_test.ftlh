<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Aptitude Test</title>
</head>

<body>
<h1>Aptitude Test</h1>

<form action="/api/aptitude-test/submit/${test.id}" method="post">
    <div th:each="q : ${test.questions}">
        <p th:text="${q.questionText}"></p>
        <div th:each="opt : ${q.options}">
            <label>
                <input type="radio" th:name="${q.id}" th:value="${opt}">
                <span th:text="${opt}"></span>
            </label><br>
        </div>
    </div>

    <button type="submit">Submit Test</button>
</form>
</body>

</html>
