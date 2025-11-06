<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
</head>
<body>

<h2>${user.firstName}</h2>
<p>${user.schoolName}</p>

<p><strong>Email:</strong> ${user.email}</p>
<p><strong>Grade:</strong> ${user.examLevel}</p>

<p><strong>Focus Areas:</strong>
    <#list user.preferredSubjects as focus>
        ${focus}<#if focus_has_next>, </#if>
    </#list>
</p>

<br>

<p>
    <a href="/dashboard">
        <button>Go to dashboard</button>
    </a>
</p>

<#--<form action="/change-password" method="get">-->
<#--    <button type="submit">Change Password</button>-->
<#--</form>-->

<#--<form action="/study-focus" method="get">-->
<#--    <button type="submit">Study Focus</button>-->
<#--</form>-->

</body>
</html>
