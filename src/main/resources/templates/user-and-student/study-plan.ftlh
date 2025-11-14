<!DOCTYPE html>
<html>
<head><title>Study Plan</title></head>
<body>

<!-- NAVIGATION BAR -->
<nav style="width: 200px; background-color: #1f3a5f; color: white; padding: 20px;">
    <h3>Website Name</h3>
    <ul style="list-style: none; padding: 0;">
        <li style="margin-bottom: 10px;">
            <a href="/dashboard" style="color: white; text-decoration: none;">Dashboard</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/study-plan" style="color: burlywood; text-decoration: none;">Study Plan</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/resources" style="color: white; text-decoration: none;">Resources</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/exam-trends" style="color: white; text-decoration: none;">Exam Trends</a>
        </li>
    </ul>

    <div style="margin-top: auto;">
        <a href="/profile" style="color: white;">Profile</a>
    </div>
</nav>

<form action="/logout" method="post">
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
<br>

<h2>Your Study Plan</h2>

<#if message??>
    <p>${message}</p>
</#if>

<#if plans?? && (plans?size > 0)>
    <table border="1" cellpadding="5">
        <tr><th>Topic</th><th>Progress</th><th>Status</th></tr>
        <#list plans as p>
            <tr>
                <td>${p.article.articleTitle}</td>
                <td>${(p.progress * 100)?string["0.##"]}%</td>
                <td><#if p.completed>Completed<#else>Pending</#if></td>
            </tr>
        </#list>
    </table>

    <br>
    <a href="/study/continue">
        <button>Continue Plan</button>
    </a>
<#else>
    <p>No study plan available yet.</p>
</#if>
</body>
</html>
