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

<h3>Quick Quiz</h3>
<form method="post" action="/submit/${plan.id}">
    <#list quiz as q>
        <div class="question-block" data-question-id="${q.id}">
            <p>${q.question}</p>

            <div class="answers"
                 data-correct="${q.correctAnswer}"
                 data-w1="${q.wrongAnswer1}"
                 data-w2="${q.wrongAnswer2}"
                 data-w3="${q.wrongAnswer3}">
            </div>

        </div>
        <hr>
    </#list>

    <button type="submit">Submit Quiz</button>
</form>


</body>

<script>
    document.addEventListener("DOMContentLoaded", () => {

        function shuffle(array) {
            for (let i = array.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [array[i], array[j]] = [array[j], array[i]];
            }
        }

        document.querySelectorAll(".answers").forEach(answerDiv => {
            const qId = answerDiv.closest(".question-block").dataset.questionId;

            // Collect answers
            let answers = [
                { text: answerDiv.dataset.correct, value: "correct" },
                { text: answerDiv.dataset.w1, value: "wrong1" },
                { text: answerDiv.dataset.w2, value: "wrong2" },
                { text: answerDiv.dataset.w3, value: "wrong3" }
            ];

            // Shuffle
            shuffle(answers);

            // Render randomized answers
            answers.forEach(ans => {
                answerDiv.innerHTML += `
                    <label>
                        <input type="radio" name="q${qId}" value="${ans.value}">
                        ${ans.text}
                    </label><br>
                `;
            });
        });
    });
</script>

</html>
