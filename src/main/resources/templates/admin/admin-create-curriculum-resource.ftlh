<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Curriculum Resource</title>
</head>
<body>

<h2>Create Curriculum Resource</h2>

<form action="/admin/curriculum-resources/save" method="post">

    <label>Topic Name:</label><br>
    <input type="text" name="topicName" required><br><br>

    <label>Subject:</label><br>
    <select name="subject" required>
        <#list subjects as subject>
            <option value="${subject}">${subject}</option>
        </#list>
    </select><br><br>

    <label>Grade:</label><br>
    <select name="grade" required>
        <#list grades as grade>
            <option value="${grade}">${grade}</option>
        </#list>
    </select><br><br>

    <button type="submit">Create Curriculum Resource</button>
</form>

</body>
</html>
