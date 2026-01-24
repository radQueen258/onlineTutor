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
<form action="/logout" method="post">
    <button type="submit" style="
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;">
        Logout
    </button>
</form>

<br>

<h2>${article.articleTitle}</h2>

<p>${article.articleContent}</p>

<#--                       AI CHAT TUTOR                          -->
<hr>

<textarea id="aiQuestion" rows="4" maxlength="300"
          placeholder="Ask about this article..."></textarea>

<button onclick="askAi()">Ask AI</button>

<div id="aiAnswer" style="margin-top: 15px;"></div>

<script>
    function askAi() {
        const question = document.getElementById("aiQuestion").value;

        fetch("/articles/${article.id}/ask-ai", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ question })
        })
            .then(r => r.text())
            .then(answer => {
                document.getElementById("aiAnswer").innerText = answer;
            });
    }
</script>


<h3>Quick Quiz</h3>

<form method="post" action="/submit/${plan.id}">
    <#list quiz as q>
        <div class="question-block">
            <p><strong>${q.question}</strong></p>

            <#list q.shuffledAnswers as ans>
                <label>
                    <input type="radio"
                           name="q${q.id}"
                           value="${ans}"
                           required>
                    ${ans}
                </label><br>
            </#list>
        </div>
        <hr>
    </#list>

    <button type="submit">Submit Quiz</button>
</form>

</body>

</html>
