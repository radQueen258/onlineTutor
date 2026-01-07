<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Articles</title>
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

<h1>Manage Articles</h1>

<a href="/admin/article/new">Create New Article</a>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Author</th>
<#--        <th>Created At</th>-->
        <th>Actions</th>
    </tr>

    <#list articles as article>
        <tr>
            <td>${article.id}</td>
            <td>${article.articleTitle}</td>
            <td>${article.tutorName.firstName}</td>
<#--            <td>${article.createdAt?string("yyyy-MM-dd")}</td>-->
            <td>
                <a href="/admin/resources/${article.resource.id}/article/${article.id}/upload-video">Upload</a> |

                <form action="/admin/articles/delete/${article.id}" method="post" style="display:inline;">
                    <input type="submit" value="Delete"
                           onclick="return confirm('Are you sure you want to delete this article?');"/>
                </form>
            </td>
        </tr>
    </#list>

</table>

<a href="/admin/dashboard">← Back to Dashboard</a>

</body>
</html>
