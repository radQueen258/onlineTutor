<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tutor Analytics</title>
</head>
<body>

<h2>Your Article Performance</h2>

<#if stats?size == 0>
    <p>No quiz data available yet.</p>
<#else>
    <table border="1" cellpadding="5">
        <tr>
            <th>Article</th>
            <th>Students Passed</th>
            <th>Students Failed</th>
            <th>Common Mistakes</th>
        </tr>

        <#list stats as item>
            <tr>
                <td>${item.articleTitle}</td>
                <td>${item.studentsPassed}</td>
                <td>${item.studentsFailed}</td>
                <td>
                    <#if item.commonMistakes?? && (item.commonMistakes?size > 0)>
                        <ul>
                            <#list item.commonMistakes?keys as question>
                                <li>${question}: ${item.commonMistakes[question]}</li>
                            </#list>
                        </ul>
                    <#else>
                        No data yet
                    </#if>

                </td>
            </tr>
        </#list>
    </table>
</#if>

<p><a href="/admin/workplace">← Back to Workplace</a></p>

</body>
</html>
