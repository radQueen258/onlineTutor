<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Videos</title>
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

<h1>Manage Videos</h1>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Uploaded By</th>
<#--        <th>Uploaded On</th>-->
        <th>Actions</th>
    </tr>

    <#list videos as video>
        <tr>
            <td>${video.id}</td>
            <td>${video.videoTitle}</td>
            <td>${video.article.tutorName.firstName}</td>
            <td><a href="/admin/videos/${video.id}">Check Video</a></td>

            <td>
                <form action="/admin/videos/delete/${video.id}" method="post" style="display:inline;" onsubmit="alert('Submitting delete for ${video.id}')">
                    <input type="submit" value="Delete"
                           onclick="return confirm('Are you sure you want to delete this video?');"/>
                </form>
<#--                <a href="/admin/videos/delete/${video.id}"-->
<#--                   onclick="return confirm('Delete this video?');">Delete</a>-->
            </td>
        </tr>
    </#list>
</table>

<a href="/admin/dashboard">← Back to Dashboard</a>

</body>
</html>
