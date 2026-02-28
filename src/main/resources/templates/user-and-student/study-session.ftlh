<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Study Session</title>
    <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        * { margin:0; padding:0; box-sizing:border-box; font-family:'Inter', sans-serif; }

        body {
            background-color: #f0f4f8;
            display: flex;
            min-height: 100vh;
            color: #0f2b4c;
        }

        /* SIDEBAR */
        aside {
            width: 280px;
            background-color: #0F3456;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
        }

        .brand { padding:0 40px; font-size:18px; font-weight:600; font-style:italic; margin-bottom:60px; }

        nav { flex-grow:1; }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 15px 40px;
            font-size:18px;
            font-weight:500;
            color:white;
            text-decoration:none;
            margin-bottom:10px;
            border-radius:8px;
            transition:0.2s;
            gap:8px;
        }

        .nav-item:hover { background-color: #123c5e; }
        .nav-item.active { background-color:#82613E; }

        .nav-item i { width:30px; font-size:22px; }

        .sidebar-footer {
            padding:0 40px;
            display:flex;
            flex-direction:column;
            gap:20px;
        }

        .logout-btn { background-color:#dc3545; color:#fff; border:none; padding:10px 14px; border-radius:10px; font-weight:600; cursor:pointer; width:100%; }
        .logout-btn:hover { background-color:#b52a38; }
        .profile-link { color:white; text-decoration:none; font-weight:500; }

        /* MAIN CONTENT */
        main {
            flex:1;
            padding:60px 80px;
            padding-right: 420px;
            overflow-y:auto;
            position:relative;
            max-width: calc(100% - 420px);
        }

        h2 { font-size:2rem; font-weight:800; margin-bottom:25px; }

        .article {
            background:white;
            padding:30px 35px;
            border-radius:16px;
            box-shadow:0 8px 25px rgba(0,0,0,0.08);
            margin-bottom:40px;
            line-height:1.7;
        }

        /* AI Chat */
        .ai-chat {
            position: fixed;
            right: 20px;
            top: 20px;
            width: 320px;
            height: 90vh;
            background:white;
            border-radius:16px;
            box-shadow:0 8px 25px rgba(0,0,0,0.15);
            display:flex;
            flex-direction:column;
            overflow:hidden;
        }

        .ai-chat h3 {
            font-size:1.3rem;
            font-weight:700;
            padding:15px;
            border-bottom:1px solid #eee;
            margin:0;
            background:#f9f9f9;
        }

        .chat-messages {
            flex-grow:1;
            padding:10px 15px;
            overflow-y:auto;
            display:flex;
            flex-direction:column;
            gap:10px;
        }

        .message.user {
            align-self:flex-end;
            background:#0f3456;
            color:white;
            padding:8px 12px;
            border-radius:12px;
            max-width:85%;
            word-wrap:break-word;
        }

        .message.ai {
            align-self:flex-start;
            background:#f1f3f5;
            color:#0f2b4c;
            padding:8px 12px;
            border-radius:12px;
            max-width:85%;
            word-wrap:break-word;
        }

        .chat-input {
            display:flex;
            gap:8px;
            padding:10px 15px;
            border-top:1px solid #eee;
            background:#fafafa;
        }

        .chat-input textarea {
            flex:1;
            padding:10px;
            border-radius:12px;
            border:1px solid #ccc;
            resize:none;
            font-family:inherit;
        }

        .chat-input .btn {
            padding:8px 15px;
            border-radius:12px;
            border:none;
            background:#0f3456;
            color:white;
            font-weight:600;
            cursor:pointer;
            transition:0.2s;
        }

        .chat-input .btn:hover { background:#123c5e; }

        /* Quiz */
        .quiz {
            background:white;
            padding:30px 35px;
            border-radius:16px;
            box-shadow:0 8px 25px rgba(0,0,0,0.08);
            margin-bottom:60px;
        }

        .quiz h3 { margin-bottom:20px; font-weight:700; font-size:1.5rem; }

        .question-block { display:none; animation:slideIn 0.4s ease; padding:15px 0; border-bottom:1px solid #eee; }
        .question-block.active { display:block; }
        .question-block:last-child { border-bottom:none; }

        .question-block p { font-weight:600; margin-bottom:10px; }

        label { display:block; margin-bottom:10px; cursor:pointer; font-weight:500; }

        .quiz-actions {
            display:flex;
            justify-content:flex-end;
            gap:10px;
            margin-top:20px;
        }

        .quiz-actions .btn {
            background:#0f3456;
            color:white;
            border-radius:12px;
            padding:8px 15px;
            font-weight:600;
            cursor:pointer;
            transition:0.2s;
        }

        .quiz-actions .btn:hover { background:#123c5e; }

        /* Animations */
        @keyframes slideIn {
            from { opacity:0; transform:translateX(30px); }
            to { opacity:1; transform:translateX(0); }
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<aside>
    <div class="brand">Online Tutor</div>

    <nav>
        <a href="/dashboard" class="nav-item active">
            <i class="fa-solid fa-house"></i>Dashboard
        </a>

        <a href="/study-plan" class="nav-item">
            <i class="fa-solid fa-book-open"></i> Study Plan
        </a>

        <a href="/resources" class="nav-item">
            <i class="fa-solid fa-play"></i> Resources
        </a>

        <a href="/chat/student" class="nav-item">
            <i class="fa-solid fa-comments"></i> Contact a Tutor
        </a>

        <a href="/articles/translations" class="nav-item">
            <i class="fa-solid fa-globe"></i> Translations
        </a>
    </nav>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/profile" class="profile-link">Profile</a>
    </div>
</aside>


<!-- MAIN -->
<main>

    <h2>${article.articleTitle}</h2>

    <div class="article">
        ${article.articleContent?no_esc}
    </div>

    <div class="ai-chat">
        <h3>AI Tutor </h3>

        <div id="chatMessages" class="chat-messages"></div>

        <div class="chat-input">
            <textarea id="aiQuestion" rows="2" placeholder="Ask something..."></textarea>
            <button class="btn" onclick="askAi()">Send</button>
        </div>
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
        const input = document.getElementById("aiQuestion");
        const question = input.value.trim();
        if (!question) return;

        const chat = document.getElementById("chatMessages");

        // Add user message
        const userMsg = document.createElement("div");
        userMsg.className = "message user";
        userMsg.innerText = question;
        chat.appendChild(userMsg);

        input.value = "";
        chat.scrollTop = chat.scrollHeight;

        // Typing indicator
        const typingMsg = document.createElement("div");
        typingMsg.className = "message ai";
        typingMsg.id = "typingIndicator";
        typingMsg.innerText = "Typing...";
        chat.appendChild(typingMsg);
        chat.scrollTop = chat.scrollHeight;

        fetch("/articles/${article.id?c}/ask-ai", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ question })
        })
            .then(r => r.text())
            .then(answer => {

                // Remove typing indicator
                typingMsg.remove();

                const aiMsg = document.createElement("div");
                aiMsg.className = "message ai";

                // Convert markdown to HTML
                aiMsg.innerHTML = marked.parse(answer);

                chat.appendChild(aiMsg);
                chat.scrollTop = chat.scrollHeight;
            })
            .catch(() => {
                typingMsg.innerText = "Error. Please try again.";
            });
    }

    document.getElementById("aiQuestion").addEventListener("keydown", function(e) {
        if (e.key === "Enter" && !e.shiftKey) {
            e.preventDefault();
            askAi();
        }
    });

    const questions = document.querySelectorAll(".question-block");
    const prevBtn = document.querySelector(".quiz-actions button:nth-child(1)");
    const nextBtn = document.querySelector(".quiz-actions button:nth-child(2)");
    const submitBtn = document.querySelector(".quiz-actions button:nth-child(3)");

    let current = 0;

    function showQuestion(index) {
        questions.forEach(q => q.classList.remove("active"));
        questions[index].classList.add("active");

        // Hide Previous on first question
        prevBtn.style.display = index === 0 ? "none" : "inline-block";

        // Hide Next on last question
        nextBtn.style.display = index === questions.length - 1 ? "none" : "inline-block";

        // Show Submit only on last question
        submitBtn.style.display = index === questions.length - 1 ? "inline-block" : "none";
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
