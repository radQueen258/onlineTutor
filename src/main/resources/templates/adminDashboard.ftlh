<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
</head>
<body>

<!-- Sidebar -->
<div style="width:220px;float:left;background:#0f2b4c;color:white;height:100vh;">
    <h3 style="padding:10px;">Website Name</h3>
    <ul style="list-style:none;padding:0;">
<#--        <li><a href="/admin/dashboard" style="color:white;text-decoration:none;">Tutor Dashboard</a></li>-->
        <li><a href="/admin/article/new" style="color:white;text-decoration:none;">Create New Article</a></li>
        <li><a href="/admin/aptitude-results" style="color:white;text-decoration:none;">General Aptitude Results</a></li>
<#--        <li><a href="/admin/statistics" style="color:white;text-decoration:none;">General Statistics</a></li>-->
<#--        <li><a href="/admin/users" style="color:white;text-decoration:none;">Registered Users</a></li>-->
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
</div>

<!-- Main Content -->
<div style="margin-left:240px;padding:20px;">
    <h1>Hello, ${adminName}</h1>
    <p>Here’s a quick overview of what’s going on in the system.</p>

    <div>
        <h3>Registered Users</h3>
        <p>Total: ${totalUsers}</p>
        <a href="/admin/users">Manage Users</a>
    </div>

    <div>
        <h3>Articles</h3>
        <p>Total: ${totalArticles}</p>
        <a href="/admin/articles">Manage Articles</a>
    </div>

    <div>
        <h3>Videos</h3>
        <p>Total: ${totalVideos}</p>
        <a href="/admin/videos">Manage Videos</a>
    </div>

    <div>
        <h3>Overall Statistics</h3>
        <#if statistics??>
            <ul>
                <#list statistics?keys as key>
                    <li>${key}: ${statistics[key]}</li>
                </#list>
            </ul>
        <#else>
            <p>No statistics available.</p>
        </#if>
        <a href="/admin/statistics">View Detailed Stats</a>
    </div>
</div>

</body>
</html>
