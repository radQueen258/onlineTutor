<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create Resource</title>
</head>
<body>

<h2>Create New Resource</h2>

<form action="/tutor/resources/save" method="post">

    <label>Curriculum Topic:</label><br>

    <select name="curriculumResourceId" required>
        <option value="" disabled selected>
            Select a topic
        </option>

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
