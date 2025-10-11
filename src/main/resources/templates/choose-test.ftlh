<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Aptitude Test Choice</title>
</head>
<body>
<h1>Aptitude Test</h1>
<p>Here is the aptitude test. It will take about 1 hour. Please ensure you have a stable internet connection.</p>

<form action="/aptitude-test/start" method="get">
<#--    <input type="hidden" name="status" value="IN_PROGRESS">-->
    <button type="submit">Take Test Now</button>
</form>

<form action="/dashboard" method="get">
    <input type="hidden" name="status" value="NOT_STARTED">
    <button type="submit">Take Test Later</button>
</form>

</body>
</html>
