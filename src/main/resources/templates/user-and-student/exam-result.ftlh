<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Exam Results</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #d2c4b5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            color: #000;
        }

        .blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(60px);
            z-index: -1;
            opacity: 0.6;
        }

        .blob-purple {
            top: 15%;
            left: -5%;
            width: 250px;
            height: 250px;
            background-color: #9a9ae0;
        }

        .blob-orange {
            bottom: 15%;
            left: -5%;
            width: 250px;
            height: 250px;
            background-color: #f38d21;
        }

        header {
            margin-bottom: 40px;
        }

        header h2 {
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 0.3em;
            font-size: 1.4rem;
            text-align: center;
        }

        .card {
            background-color: #ffffff;
            width: 90%;
            max-width: 900px;
            padding: 80px 40px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .card h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .score {
            font-size: 3rem;
            font-weight: 900;
            margin-bottom: 20px;
        }

        .pass {
            color: #2e7d32;
        }

        .fail {
            color: #c62828;
        }

        .message {
            font-size: 1.1rem;
            margin-bottom: 40px;
            max-width: 600px;
        }

        .weak-topics {
            margin-top: 20px;
            margin-bottom: 40px;
            text-align: left;
            max-width: 600px;
        }

        .weak-topics h3 {
            margin-bottom: 10px;
        }

        .weak-topics ul {
            padding-left: 20px;
        }

        .btn-dashboard {
            display: inline-block;
            padding: 10px 40px;
            border: 3px solid #000;
            background-color: #fff;
            color: #000;
            text-decoration: none;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .btn-dashboard:hover {
            background-color: #000;
            color: #fff;
        }

        footer {
            margin-top: 40px;
        }

        footer p {
            font-style: italic;
            letter-spacing: 0.3em;
            font-weight: 700;
            font-size: 1.2rem;
        }
    </style>
</head>

<body>

<div class="blob blob-purple"></div>
<div class="blob blob-orange"></div>

<header>
    <h2>Name of the WebApp</h2>
</header>

<main class="card">

    <h1>Exam Completed</h1>

    <div class="score
    <#if score gte 80>pass<#else>fail</#if>">
        ${score?string["0.##"]}%
    </div>

    <div class="message">
        <#if score gte 80>
            Excellent work! You passed the exam and are progressing well.
        <#else>
            You did not reach the required score.
            Review the topics below and try again.
        </#if>
    </div>


    <#if weakTopics?? && weakTopics?size gt 0>
        <div class="weak-topics">
            <h3>Topics to Review:</h3>
            <ul>
                <#list weakTopics as topic>
                    <li>
                        <strong>${topic.topic}</strong>: ${topic.explanation}
                    </li>
                </#list>
            </ul>
        </div>
    </#if>

    <a href="/dashboard" class="btn-dashboard">
        Go to Dashboard
    </a>

    <#-- Retake Button -->
    <form action="/exam/${examId}/retake" method="post" style="margin-top: 20px;">
        <button type="submit" class="continue-btn">Retake Exam</button>
    </form>


</main>

<footer>
    <p>You Got This!</p>
</footer>

</body>
</html>
