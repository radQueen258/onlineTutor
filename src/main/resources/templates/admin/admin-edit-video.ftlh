<!DOCTYPE html>
<html>
<head>
    <title>Edit Video</title>
</head>
<body>
<h2>Edit Video</h2>

<form action="/admin/video/edit/${video.id}" method="post">
    <label>Video Title:</label><br>
    <input type="text" name="videoTitle" value="${video.videoTitle}" required><br><br>

    <label>Description:</label><br>
    <textarea name="videoDescription" rows="5" cols="50">${video.videoDescription!""}</textarea><br><br>

    <label>YouTube URL:</label><br>
    <input type="text" name="videoUrl" value="${video.videoUrl}" required><br><br>

    <button type="submit">Save Changes</button>
    <a href="/admin/workplace">Cancel</a>
</form>

</body>
</html>
