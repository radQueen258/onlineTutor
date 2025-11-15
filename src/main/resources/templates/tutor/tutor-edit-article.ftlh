<!DOCTYPE html>
<html>
<head>
    <title>Edit Article</title>
</head>
<body>
<h2>Edit Article</h2>

<form action="/tutor/article/edit/${article.id}" method="post">
    <label>Title:</label><br>
    <input type="text" name="articleTitle" value="${article.articleTitle}"><br><br>

    <label>Image URL:</label><br>
    <input type="text" name="imageUrl" value="${article.imageUrl!""}"><br><br>

    <label>Content:</label><br>
    <textarea name="articleContent" rows="8" cols="60">${article.articleContent}</textarea><br><br>

    <#list article.questions as q>
        <textarea name="questions[${q?index}].question">${q.question}</textarea>
        <input type="text" name="questions[${q?index}].correctAnswer" value="${q.correctAnswer}">
        <input type="text" name="questions[${q?index}].wrongAnswer1" value="${q.wrongAnswer1}">
        <input type="text" name="questions[${q?index}].wrongAnswer2" value="${q.wrongAnswer2}">
        <input type="text" name="questions[${q?index}].wrongAnswer3" value="${q.wrongAnswer3}">
    </#list>

    <button type="submit">Save Changes</button>
    <a href="/tutor/workplace">Cancel</a>
</form>

</body>
</html>
