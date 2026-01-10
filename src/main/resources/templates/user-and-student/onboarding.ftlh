<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Onboarding</title>
</head>
<body>
<h1>Onboarding</h1>

<form action="/setGoals" method="post">
    <label>Exam Level:</label>
    <select name="examLevel" required>
        <option value="${examLevel10}">Grade 10 National Exam</option>
        <option value="${examLevel12}">Grade 12 National Exam</option>
    </select><br>

    <label>Subjects (hold Ctrl to select multiple):</label>
    <select name="subjects" multiple required>
        <#list subjects as subject>
            <option value="${subject}">${subject}</option>
        </#list>
    </select><br>

    <button type="submit">Continue</button>
</form>
0
</body>
</html>
