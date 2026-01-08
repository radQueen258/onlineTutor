<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create New Article</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 40px;">

<h2>Create a New Article</h2>

<form action="/admin/resources/${resourceId}/article/save" method="post" style="max-width: 600px;">
    <label for="title"><strong>Title:</strong></label><br>
    <input type="text" id="title" name="articleTitle" value="${article.articleTitle!}"
           placeholder="Enter the article title" required
           style="width: 100%; padding: 8px; margin: 8px 0;"><br>

    <label for="content"><strong>Content:</strong></label><br>
    <textarea id="content" name="articleContent" rows="8" placeholder="Write your article content here..."
              style="width: 100%; padding: 8px; margin: 8px 0;">${article.articleContent!}</textarea><br>

    <h3>Multiple Choice Questions (3 required)</h3>

    <#list article.questions as q>
        <fieldset style="border:1px solid #aaa; padding:10px; margin-bottom:12px;">
            <legend>Question ${q?index + 1}</legend>

            <label>Question Text:</label><br>
            <textarea name="questions[${q?index}].question" rows="3" cols="75" required></textarea><br><br>

            <label>Correct Answer:</label><br>
            <input type="text" name="questions[${q?index}].correctAnswer" required><br><br>

            <label>Wrong Answer 1:</label><br>
            <input type="text" name="questions[${q?index}].wrongAnswer1" required><br><br>

            <label>Wrong Answer 2:</label><br>
            <input type="text" name="questions[${q?index}].wrongAnswer2" required><br><br>

            <label>Wrong Answer 3:</label><br>
            <input type="text" name="questions[${q?index}].wrongAnswer3" required><br>
        </fieldset>
    </#list>

    <button type="submit"
            style="padding: 10px 18px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;">
        Publish Article
    </button>

    <a href="/admin/workplace"
       style="margin-left: 15px; color: #007bff; text-decoration: none;">Cancel</a>
</form>

</body>
</html>
