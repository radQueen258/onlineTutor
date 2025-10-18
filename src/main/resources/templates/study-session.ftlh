<!DOCTYPE html>
<html>
<head><title>Study Session</title></head>
<body>

<!-- NAVIGATION BAR -->
<nav style="width: 200px; background-color: #1f3a5f; color: white; padding: 20px;">
    <h3>Website Name</h3>
    <ul style="list-style: none; padding: 0;">
        <li style="margin-bottom: 10px;">
            <a href="/dashboard" style="color: white; text-decoration: none;">Dashboard</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/study-plan" style="color: burlywood; text-decoration: none;">Study Plan</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/resources" style="color: white; text-decoration: none;">Resources</a>
        </li>
        <li style="margin-bottom: 10px;">
            <a href="/exam-trends" style="color: white; text-decoration: none;">Exam Trends</a>
        </li>
    </ul>

    <div style="margin-top: auto;">
        <a href="/profile" style="color: white;">Profile</a>
    </div>
</nav>

<h2>${article.articleTitle}</h2>

<p>${article.articleContent}</p>


<h3>Quick Quiz</h3>
<form method="post" action="/study/submit/${plan.id}">
    <#list quiz as q>
        <p>${q.question}</p>
        <label><input type="radio" name="q${q.id}" value="A"> ${q.optionA}</label><br>
        <label><input type="radio" name="q${q.id}" value="B"> ${q.optionB}</label><br>
        <label><input type="radio" name="q${q.id}" value="C"> ${q.optionC}</label><br>
        <hr>
    </#list>
    <button type="submit">Submit Quiz</button>
</form>

</body>
</html>
