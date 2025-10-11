<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Dashboard</title>
</head>

<body>
<h1>Welcome,${firstName}</h1>
<p>User ID: ${userId}</p>

<#if needsTest>
    <p style="color:red;">⚠️ You still need to take your aptitude test!</p>
    <form action="/aptitude-test/start" method="get">
        <button type="submit">Take Test Now</button>
    </form>
</#if>


<section>
    <h2>Progress</h2>
    <p>${progress}</p>
</section>

<section>
    <h2>Upcoming</h2>
    <p>${upcoming}</p>
</section>

<br>

<p>
    <a href="/profile">
        <button>Profile</button>
    </a>
</p>
</body>

</html>
