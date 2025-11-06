<!DOCTYPE html>
<html>
<head>
    <title>Edit Article</title>
</head>
<body>
<h2>Edit Article</h2>

<form action="/admin/article/edit/${article.id}" method="post">
    <label>Title:</label><br>
    <input type="text" name="articleTitle" value="${article.articleTitle}"><br><br>

    <label>Image URL:</label><br>
    <input type="text" name="imageUrl" value="${article.imageUrl!""}"><br><br>

    <label>Content:</label><br>
    <textarea name="articleContent" rows="8" cols="60">${article.articleContent}</textarea><br><br>

    <button type="submit">Save Changes</button>
    <a href="/admin/workplace">Cancel</a>
</form>

</body>
</html>
