<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Overall Statistics</title>
</head>
<body>

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
