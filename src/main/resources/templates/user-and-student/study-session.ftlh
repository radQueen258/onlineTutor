<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Study Session</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background-color: #f0f4f9;
            display: flex;
            min-height: 100vh;
            color: #333;
        }

        /* Sidebar */
        nav {
            width: 240px;
            background-color: #0F3456;
            color: white;
            padding: 40px 25px;
            display: flex;
            flex-direction: column;
        }

        nav h3 {
            margin-bottom: 40px;
            font-weight: 800;
        }

        nav ul {
            list-style: none;
        }

        nav li {
            margin-bottom: 15px;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        nav a.active {
            color: burlywood;
        }

        .logout-btn {
            margin-top: auto;
            background-color: #dc3545;
            border: none;
            color: white;
            padding: 10px;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 600;
        }

        /* Main content */
        main {
            flex-grow: 1;
            padding: 50px 60px;
            max-width: 1100px;
        }

        h2 {
            font-size: 30px;
            font-weight: 800;
            color: #0f2b4c;
            margin-bottom: 20px;
        }

        .article {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            margin-bottom: 40px;
            line-height: 1.6;
        }

        /* AI Tutor */
        .ai-box {
            background: #ffffff;
            padding: 25px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
            margin-bottom: 40px;
        }

        .ai-box h3 {
            color: #0f2b4c;
            margin-bottom: 15px;
        }

        textarea {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            resize: none;
            font-family: inherit;
        }

        .btn {
            background-color: #0f2b4c;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #123c5e;
        }

        #aiAnswer {
            margin-top: 15px;
            background: #f5f7fa;
            padding: 15px;
            border-radius: 10px;
        }

        /* Quiz */
        .quiz {
            background: white;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.08);
        }

        .quiz h3 {
            margin-bottom: 20px;
            color: #0f2b4c;
        }

        .question-block {
            display: none;
            animation: slideIn 0.4s ease;
        }

        .question-block.active {
            display: block;
        }

        .question-block p {
            font-weight: 600;
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            cursor: pointer;
        }

        .quiz-actions {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<nav>
    <h3>Website Name</h3>

    <ul>
        <li><a href="/dashboard">Dashboard</a></li>
        <li><a href="/study-plan" class="active">Study Plan</a></li>
        <li><a href="/resources">Resources</a></li>
        <li><a href="/exam-trends">Exam Trends</a></li>
    </ul>

    <a href="/profile" style="margin-top:20px;">Profile</a>

    <form action="/logout" method="post">
        <button type="submit" class="logout-btn">Logout</button>
    </form>
</nav>

<!-- MAIN -->
<main>

    <h2>${article.articleTitle}</h2>

    <div class="article">
        ${article.articleContent}
    </div>

    <!-- AI TUTOR -->
    <div class="ai-box">
        <h3>Ask the AI Tutor 🤖</h3>

        <textarea id="aiQuestion" rows="4" maxlength="300"
                  placeholder="Ask about this article..."></textarea>

        <button class="btn" onclick="askAi()">Ask AI</button>

        <div id="aiAnswer"></div>
    </div>

    <!-- QUIZ -->
    <div class="quiz">
        <h3>Quick Quiz</h3>

        <form method="post" action="/submit/${plan.id?c}">
            <#list quiz as q>
                <div class="question-block">
                    <p>${q.question}</p>

                    <#list q.shuffledAnswers as ans>
                        <label>
                            <input type="radio"
                                   name="q${q.id?c}"
                                   value="${ans}"
                                   required>
                            ${ans}
                        </label>
                    </#list>
                </div>
            </#list>

            <div class="quiz-actions">
                <button type="button" class="btn" onclick="prevQuestion()">Previous</button>
                <button type="button" class="btn" onclick="nextQuestion()">Next</button>
                <button type="submit" class="btn">Submit Quiz</button>
            </div>
        </form>
    </div>

</main>

<script>
    function askAi() {
        const question = document.getElementById("aiQuestion").value;

        fetch("/articles/${article.id}/ask-ai", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ question })
        })
            .then(r => r.text())
            .then(answer => {
                document.getElementById("aiAnswer").innerText = answer;
            });
    }

    const questions = document.querySelectorAll(".question-block");
    let current = 0;

    function showQuestion(index) {
        questions.forEach(q => q.classList.remove("active"));
        questions[index].classList.add("active");
    }

    function nextQuestion() {
        if (current < questions.length - 1) {
            current++;
            showQuestion(current);
        }
    }

    function prevQuestion() {
        if (current > 0) {
            current--;
            showQuestion(current);
        }
    }

    showQuestion(0);
</script>

</body>
</html>
