<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Overall Statistics</title>
</head>
<body>

<!-- Sidebar -->
<div style="width:220px;float:left;background:#0f2b4c;color:white;height:100vh;">
    <h3 style="padding:10px;">Website Name</h3>
    <ul style="list-style:none;padding:0;">
        <#--        <li><a href="/admin/dashboard" style="color:white;text-decoration:none;">Tutor Dashboard</a></li>-->
        <li><a href="/admin/workplace" style="color:white;text-decoration:none;">Go to Workplace</a></li>
        <li><a href="/admin/aptitude-results" style="color:white;text-decoration:none;">General Aptitude Results</a></li>
    </ul>

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
</div>

<h1>Overall Statistics</h1>

<#if stats?? && stats?size gt 0>
    <table border="1" cellpadding="8">
        <tr><th>Metric</th><th>Value</th></tr>
        <#list stats?keys as key>
            <tr>
                <td>${key}</td>
                <td>${stats[key]}</td>
            </tr>
        </#list>
    </table>
<#else>
    <p>No statistics available yet.</p>
</#if>

<a href="/admin/dashboard">← Back to Dashboard</a>

</body>
</html>
