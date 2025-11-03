<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Videos</title>
</head>
<body>

<h1>Manage Videos</h1>

<a href="/admin/videos/create">Upload New Video</a>

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
<#--            <td>${video.uploadedAt?string("yyyy-MM-dd")}</td>-->
            <td>
<#--                <a href="/admin/videos/edit/${video.id}">Edit</a> |-->
                <a href="/admin/videos/delete/${video.id}"
                   onclick="return confirm('Delete this video?');">Delete</a>
            </td>
        </tr>
    </#list>
</table>

<a href="/admin/dashboard">← Back to Dashboard</a>

</body>
</html>
