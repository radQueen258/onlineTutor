<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Demo Exam</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>

    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #d7c4ae;
            font-family: 'Inter', sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        .circle-purple {
            position: absolute;
            top: 15%;
            left: -20px;
            width: 180px;
            height: 180px;
            background-color: #9b9bd7;
            border-radius: 50%;
            filter: blur(60px);
            opacity: 0.7;
        }

        .circle-orange {
            position: absolute;
            bottom: 15%;
            left: -10px;
            width: 150px;
            height: 150px;
            background-color: #e68a2e;
            border-radius: 50%;
            filter: blur(50px);
            opacity: 0.8;
        }

        header {
            margin-bottom: 30px;
        }

        header h1 {
            font-weight: 900;
            font-size: 24px;
            letter-spacing: 4px;
            text-transform: uppercase;
            margin: 0;
        }

        .container {
            background-color: white;
            width: 90%;
            max-width: 1000px;
            padding: 60px 80px;
            box-shadow: 15px 15px 40px rgba(0, 0, 0, 0.15);
            display: flex;
            flex-direction: column;
        }

        .top-row h2 {
            font-size: 32px;
            font-weight: 900;
            margin-bottom: 40px;
        }

        .question-block {
            display: none;
        }

        .question-block.active {
            display: block;
        }

        .content-area {
            display: flex;
            gap: 40px;
            margin-bottom: 40px;
        }

        .question-text {
            flex: 1.2;
            font-size: 18px;
            line-height: 1.5;
        }

        .illustration {
            flex: 0.8;
            display: flex;
            justify-content: center;
        }

        .options-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-bottom: 40px;
        }

        .option {
            display: flex;
            align-items: center;
            gap: 15px;
            cursor: pointer;
            font-weight: 700;
            font-size: 18px;
        }

        .option input[type="radio"] {
            appearance: none;
            width: 18px;
            height: 18px;
            border: 2px solid #888;
            border-radius: 50%;
            cursor: pointer;
        }

        .option input[type="radio"]:checked {
            border-color: #000;
        }

        .option input[type="radio"]:checked::after {
            content: '';
            width: 10px;
            height: 10px;
            background-color: #000;
            border-radius: 50%;
            display: block;
            margin: auto;
        }

        .footer-row {
            display: flex;
            justify-content: flex-end;
        }

        .next-btn {
            background-color: white;
            border: 4px solid #000;
            padding: 10px 50px;
            font-size: 18px;
            font-weight: 900;
            cursor: pointer;
        }

        .next-btn:disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }
    </style>
</head>

<body>

<div class="circle-purple"></div>
<div class="circle-orange"></div>

<header>
    <h1>Online Tutor</h1>
</header>

<form action="/exam/submit" method="post">
<#--    <input type="hidden" name="status" value="COMPLETED">-->
    <input type="hidden" name="examId" value="${exam.examId?c}">
    <input type="hidden" name="userId" value="${userId?c}">
    <input type="hidden" name="subject" value="${subject}">


    <main class="container">
        <div class="top-row">
            <h2>Demo Exam</h2>
        </div>

        <#list exam.questions as question>
            <div class="question-block <#if question?index == 0>active</#if>">

                <div class="content-area">
                    <div class="question-text">
                        <strong>Question ${question?index + 1}:</strong><br>
                        ${question.questionText}
                    </div>

                    <div class="illustration">
                        <img src="https://placehold.co/300x200/ffffff/000000?text=Illustration"
                             alt="Illustration">
                    </div>
                </div>

                <div class="options-container">
                    <#list question.options as option>
                        <label class="option">
                            <input type="radio"
                                   name="answer_${question.id?c}"
                                   value="${option?index}">
                            ${option?index + 1}. ${option}
                        </label>
                    </#list>
                </div>
            </div>
        </#list>

        <div class="footer-row">
            <button type="button" class="next-btn" id="nextBtn" disabled>Next</button>
            <button type="submit" class="next-btn" id="submitBtn" style="display:none;">
                Submit Test
            </button>
        </div>
    </main>
</form>

<script>
    const questions = document.querySelectorAll('.question-block');
    const nextBtn = document.getElementById('nextBtn');
    const submitBtn = document.getElementById('submitBtn');

    let currentIndex = 0;

    function updateButtons() {
        const radios = questions[currentIndex].querySelectorAll('input[type="radio"]');
        nextBtn.disabled = !Array.from(radios).some(r => r.checked);
    }

    questions.forEach((q, index) => {
        q.addEventListener('change', () => {
            if (index === currentIndex) {
                updateButtons();
            }
        });
    });

    nextBtn.addEventListener('click', () => {
        questions[currentIndex].classList.remove('active');
        currentIndex++;

        questions[currentIndex].classList.add('active');
        nextBtn.disabled = true;

        if (currentIndex === questions.length - 1) {
            nextBtn.style.display = 'none';
            submitBtn.style.display = 'inline-block';
        }
    });

    window.addEventListener("beforeunload", function () {
        navigator.sendBeacon("/exam/abandon", [[${examId}]]);
    });
</script>

</body>
</html>
