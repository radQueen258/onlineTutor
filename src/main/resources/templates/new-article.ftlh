<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Article</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">

<h2>Create a New Article</h2>

<form action="/tutor/resources/${resourceId}article/save" method="post" style="max-width: 600px;">
    <label for="title"><strong>Title:</strong></label><br>
    <input type="text" id="title" name="articleTitle" value="${article.articleTitle!}"
           placeholder="Enter the article title" required
           style="width: 100%; padding: 8px; margin: 8px 0;"><br>

    <label for="content"><strong>Content:</strong></label><br>
    <textarea id="content" name="articleContent" rows="8" placeholder="Write your article content here..."
              style="width: 100%; padding: 8px; margin: 8px 0;">${article.articleContent!}</textarea><br>

    <button type="submit"
            style="padding: 10px 18px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;">
        Publish Article
    </button>

    <a href="/tutor/workplace"
       style="margin-left: 15px; color: #007bff; text-decoration: none;">Cancel</a>
</form>

</body>
</html>
