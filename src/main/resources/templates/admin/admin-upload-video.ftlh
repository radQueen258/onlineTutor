<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload YouTube Video</title>
</head>
<body>

<h2>Add a Video to Article: ${article.articleTitle}</h2>

<form action="/admin/resources/${resourceId}/article/${article.id}/upload-video/save" method="post">
    <p>
        <label>Video Title:</label><br>
        <input type="text" name="videoTitle" required>
    </p>

    <p>
        <label>Description:</label><br>
        <textarea name="videoDescription" rows="3" cols="40"></textarea>
    </p>

    <p>
        <label>YouTube URL:</label><br>
        <input type="url" name="videoUrl" placeholder="https://www.youtube.com/watch?v=..." required>
    </p>


    <p>
        <button type="submit">Save Video</button>
    </p>
</form>

<p><a href="/admin/videos">← Back to Videos</a></p>

</body>
</html>
