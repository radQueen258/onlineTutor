<!DOCTYPE html>
<html>
<head>
    <title>Aptitude Test Details</title>
</head>
<body>

<br>
<a href="/admin/aptitude-results">← Back to All Results</a>
<br>

<h2>Aptitude Test Details</h2>

<p><strong>User ID:</strong> ${test.userId}</p>
<#if test.score??has_content>
    <p><strong>Score:</strong> ${test.score}</p>
    <#else>
    <p><strong>Score:</strong> 0 </p>
</#if>


<p><strong>Status:</strong> ${test.status}</p>

<#if test.questions?has_content>
    <h3>Questions</h3>
    <table border="1" cellpadding="8" cellspacing="0">
        <tr>
            <th>Question</th>
            <th>User Answer</th>
            <th>Correct Answer</th>
        </tr>
        <#list test.questions as q>
            <tr>
                <td>${q.questionText}</td>
                <td>${q.userAnswer!'-'}</td>
                <td>${q.correctAnswer!'-'}</td>
            </tr>
        </#list>
    </table>
<#else>
    <p>No questions available for this test.</p>
</#if>

</body>
</html>
