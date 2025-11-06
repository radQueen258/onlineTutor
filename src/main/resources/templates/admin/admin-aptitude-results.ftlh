<!DOCTYPE html>
<html>
<head>
    <title>Aptitude Test Results</title>
</head>
<body>
<h2>Aptitude Test Results</h2>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>User ID</th>
        <th>Score</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>

    <#if tests?has_content>
        <#list tests as test>
            <tr>
                <td>${test.id}</td>
                <td>${test.userId}</td>
                <td>${test.score!'-'}</td>
                <td>${test.status}</td>
                <td>
                    <a href="/admin/aptitude-results/${test.id}">View</a>
                </td>
            </tr>
        </#list>
    <#else>
        <tr><td colspan="5">No test results available</td></tr>
    </#if>
</table>

<br>
<a href="/admin/dashboard">Back to Dashboard</a>
</body>
</html>
