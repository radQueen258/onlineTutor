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
<div style="display: flex; height: 100vh;">

    <!-- NAVIGATION BAR -->
    <nav style="width: 200px; background-color: #1f3a5f; color: white; padding: 20px;">
        <h3>Website Name</h3>
        <ul style="list-style: none; padding: 0;">
            <li style="margin-bottom: 10px;">
                <a href="/dashboard" style="color: burlywood; text-decoration: none;">Dashboard</a>
            </li>
            <li style="margin-bottom: 10px;">
                <a href="/study-plan" style="color: white; text-decoration: none;">Study Plan</a>
            </li>
            <li style="margin-bottom: 10px;">
                <a href="/resources" style="color: white; text-decoration: none;">Resources</a>
            </li>
            <li style="margin-bottom: 10px;">
                <a href="/exam-trends" style="color: white; text-decoration: none;">Exam Trends</a>
            </li>
        </ul>

        <form action="/logout" method="post">
<#--            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">-->
            <button type="submit" style="
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;">
                Logout
            </button>
        </form>

        <div style="margin-top: auto;">
            <a href="/profile" style="color: white;">Profile</a>
        </div>
    </nav>

    <!-- MAIN CONTENT -->
    <main style="flex: 1; padding: 30px;">
        <h1>Welcome, ${firstName}</h1>
        <p>User ID: ${userId}</p>

        <#if needsTest>
            <p style="color:red;">⚠️ You still need to take your aptitude test!</p>
            <form action="/aptitude-test/start" method="get">
                <button type="submit">Take Test Now</button>
            </form>
        </#if>
        <#if progress ??>
            <section style="margin-top: 30px;">
                <h2>Progress</h2>
                <p>${progress}</p>
            </section>

            <section style="margin-top: 20px;">
                <h2>Upcoming</h2>
                <p>${upcoming}</p>
            </section>
        </#if>

        <br>

        <a href="/profile">
            <button>Profile</button>
        </a>
    </main>
</div>
</body>
</html>
