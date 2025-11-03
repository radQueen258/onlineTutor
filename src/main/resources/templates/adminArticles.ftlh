<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Articles</title>
</head>
<body>

<h1>Manage Articles</h1>

<a href="/admin/articles/create">Create New Article</a>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Author</th>
        <th>Created At</th>
        <th>Actions</th>
    </tr>

    <#list articles as article>
        <tr>
            <td>${article.id}</td>
            <td>${article.articleTitle}</td>
            <td>${article.tutorName.firstName}</td>
<#--            <td>${article.createdAt?string("yyyy-MM-dd")}</td>-->
            <td>
<#--                <a href="/admin/articles/edit/${article.id}">Edit</a>-->
                |
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
