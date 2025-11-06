<!DOCTYPE html>
<html>
<head><title>Exam Trends</title></head>
<body>
<h2>Exam Trends</h2>

<!-- Sidebar -->
<nav style="width: 200px; background-color: #1f3a5f; color: white; padding: 20px;">
    <h3>Website Name</h3>
    <ul style="list-style: none; padding: 0;">
        <li style="margin-bottom: 10px;">
            <a href="/dashboard" style="color: white; text-decoration: none;">Dashboard</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/study-plan" style="color: white; text-decoration: none;">Study Plan</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/resources" style="color: white; text-decoration: none;">Resources</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/exam-trends" style="color: burlywood; text-decoration: none;">Exam Trends</a>
        </li>
    </ul>

    <div style="margin-top: auto;">
        <a href="/profile" style="color: white;">Profile</a>
    </div>
</nav>

<table>
    <tr><th>Topic</th><th>Appearances</th></tr>
    <#list trends as t>
        <tr><td>${t.topicName}</td><td>${t.appearances}</td></tr>
    </#list>
</table>
<#--<button>View Report</button>-->
</body>
</html>
