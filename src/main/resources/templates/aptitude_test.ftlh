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

<form action="/aptitude-test/submit/${test.id}" method="post">
    <#list test.questions as question>
        <div style="margin-bottom: 20px;">
            <p><strong>Question ${question?index + 1}:</strong> ${question.questionText}</p>
            <#list question.options as option>
                <label>
                    <input type="radio" name="answer_${question.id}" value="${option}" required>
                    ${option}
                </label><br>
            </#list>
        </div>
    </#list>

    <button type="submit">Submit Test</button>
</form>
</body>

</html>
