<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Resource</title>
</head>
<body>

<h2>Create Resource from Curriculum</h2>

<form action="/admin/resources/save" method="post">

    <label>Select Curriculum Topic:</label><br>
    <select name="curriculumResourceId" required>
        <#list curriculumResources as cr>
            <option value="${cr.id}">
                ${cr.topicName} (${cr.subject}, ${cr.grade})
            </option>
        </#list>
    </select>

    <br><br>
    <button type="submit">Create Resource</button>
</form>

</body>
</html>
