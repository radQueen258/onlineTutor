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
                        <#assign mistakeKeys = item.commonMistakes?keys>
                        <#assign max = (mistakeKeys?size > 3)?then(3, mistakeKeys?size)>

                        <ul>
                            <#list mistakeKeys[0..max-1] as question>
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
