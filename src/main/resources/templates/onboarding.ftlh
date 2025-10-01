<!doctype html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Onboarding</title>
</head>
<body>
<h1>Onboarding</h1>

<form action="/setGoals" method="post">
    <label>Exam Level:</label>
    <select name="examLevel" required>
        <option value="GRADE_10">Grade 10 National Exam</option>
        <option value="GRADE_12">Grade 12 National Exam</option>
    </select><br>

    <label>Subjects (hold Ctrl to select multiple):</label>
    <select name="subjects" multiple required>
        <option value="Math">Math</option>
        <option value="Physics">Physics</option>
        <option value="Chemistry">Chemistry</option>
        <option value="Biology">Biology</option>
        <option value="English">English</option>
        <option value="Portuguese">Portuguese</option>
        <option value="French">French</option>
    </select><br>

    <button type="submit">Continue</button>
</form>

</body>
</html>
