<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OnBoarding - Name of the WebApp</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>

    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }

        body {
            background-color: #d2c1ae;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            padding: 20px;
        }

        .circle { position: absolute; border-radius: 50%; filter: blur(40px); z-index: 0; opacity: 0.6; }
        .circle-purple { width: 150px; height: 150px; background-color: #9489c7; top: 15%; left: 5%; }
        .circle-orange { width: 120px; height: 120px; background-color: #e67e22; bottom: 15%; left: 5%; }

        header { z-index: 1; margin-bottom: 40px; }
        header h1 { font-size: 24px; font-weight: 800; letter-spacing: 4px; text-transform: uppercase; color: #000; text-align: center; }

        .card {
            background-color: #ffffff;
            width: 100%;
            max-width: 900px;
            min-height: 500px;
            padding: 60px 80px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            z-index: 1;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .card h2 { font-size: 32px; font-weight: 800; margin-bottom: 60px; color: #000; }

        .form-container { display: flex; justify-content: space-between; gap: 40px; flex-wrap: wrap; }
        .section { flex: 1; min-width: 250px; }
        .section-title { font-size: 14px; font-weight: 700; margin-bottom: 25px; text-transform: uppercase; color: #000; }

        .option-group { display: flex; flex-direction: column; gap: 15px; }
        .option-row { display: flex; align-items: center; gap: 12px; cursor: pointer; }

        .custom-input { width: 18px; height: 18px; border: 2px solid #888; border-radius: 50%; display: inline-block; position: relative; transition: border-color 0.2s; }
        input[type="radio"], input[type="checkbox"] { display: none; }
        input[type="radio"]:checked + .custom-input, input[type="checkbox"]:checked + .custom-input { border-color: #000; }
        input[type="radio"]:checked + .custom-input::after, input[type="checkbox"]:checked + .custom-input::after {
            content: '';
            width: 10px;
            height: 10px;
            background-color: #000;
            border-radius: 50%;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .option-label { font-size: 14px; font-weight: 600; color: #000; }

        .subjects-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px 30px; }
        .submit-container { margin-top: auto; display: flex; justify-content: center; padding-top: 60px; }

        .submit-btn { background-color: #fff; border: 3px solid #000; padding: 12px 50px; font-size: 16px; font-weight: 700; cursor: pointer; transition: background-color 0.2s, color 0.2s; }
        .submit-btn:hover { background-color: #000; color: #fff; }

        footer { margin-top: 40px; z-index: 1; }
        footer p { font-size: 20px; font-style: italic; font-weight: 600; letter-spacing: 4px; color: #000; }

        @media (max-width: 768px) {
            .card { padding: 40px 30px; }
            .subjects-grid { grid-template-columns: 1fr; }
            header h1 { font-size: 18px; }
            footer p { font-size: 16px; }
        }
    </style>
</head>

<body>

<div class="circle circle-purple"></div>
<div class="circle circle-orange"></div>

<header>
    <h1>Name of the WebApp</h1>
</header>

<main class="card">
    <h2>OnBoarding</h2>

    <form action="/setGoals" method="post">
        <div class="form-container">
            <!-- Exam Level Section -->
            <div class="section">
                <h3 class="section-title">EXAM LEVEL</h3>
                <div class="option-group">
                    <#-- Freemarker variables -->
                    <label class="option-row">
                        <input type="radio" name="examLevel" value="${examLevel10}">
                        <span class="custom-input"></span>
                        <span class="option-label">Grade 10 National Exam</span>
                    </label>
                    <label class="option-row">
                        <input type="radio" name="examLevel" value="${examLevel12}">
                        <span class="custom-input"></span>
                        <span class="option-label">Grade 12 National Exam</span>
                    </label>
                </div>
            </div>

            <!-- Subjects Section -->
            <div class="section">
<#--                <h3 class="section-title">SUBJECTS (hold Ctrl to select multiple):</h3>-->
                <div class="subjects-grid">
                    <#list subjects as subject>
                        <label class="option-row">
                            <input type="checkbox" name="subjects" value="${subject}">
                            <span class="custom-input"></span>
                            <span class="option-label">${subject}</span>
                        </label>
                    </#list>
                </div>
            </div>
        </div>

        <div class="submit-container">
            <button type="submit" class="submit-btn">Continue</button>
        </div>
    </form>
</main>

<footer>
    <p>Almost There...</p>
</footer>

</body>
</html>
