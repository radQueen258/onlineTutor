<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Resource</title>
</head>
<body>

<h2>Create New Resource</h2>

<form action="/admin/resources/save" method="post">

    <label>Topic Name:</label><br>
    <input type="text" name="topicName" required><br><br>

    <label>Subject:</label><br>
    <select name="subject" required>
        <#list subjects as subject>
            <option value="${subject}">${subject}</option>
        </#list>
    </select><br><br>

    <label>Optional: Link to Curriculum Resource</label><br>
    <select name="curriculumResourceId">
        <option value="">None</option>
        <#list curriculumResources as cr>
            <option value="${cr.id}">
                ${cr.topicName} (${cr.grade})
            </option>
        </#list>
    </select>
    <br><br>

    <button type="submit">Create Resource</button>
</form>

</body>
</html>
