<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Resource</title>
</head>
<body>

<h2>Create New Resource</h2>

<form action="/tutor/resources" method="post">
    <label>Topic Name:</label><br>
    <input type="text" name="topicName" required><br><br>

    <label>Subject:</label><br>
    <textarea name="subject" rows="4" cols="50"></textarea><br><br>

    <button type="submit">Create Resource</button>
</form>

</body>
</html>
