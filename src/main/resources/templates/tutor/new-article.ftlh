<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create New Article</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }

        body {
            background-color: #d7c4ae;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 15px;
            padding: 50px 60px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.15);
            width: 100%;
            max-width: 800px;
            display: flex;
            flex-direction: column;
            gap: 30px;
        }

        h2 {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 20px;
            color: #000;
        }

        h3 {
            font-size: 18px;
            font-weight: 700;
            margin-top: 20px;
            margin-bottom: 12px;
            color: #000;
        }

        label {
            font-weight: 600;
            margin-bottom: 6px;
            display: block;
            color: #000;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 2px solid #ccc;
            font-size: 14px;
            font-family: 'Inter', sans-serif;
        }

        textarea { resize: vertical; }

        fieldset {
            border: 2px solid #ccc;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
        }

        legend {
            font-weight: 700;
            padding: 0 10px;
            color: #000;
        }

        .btn-primary {
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px 25px;
            font-weight: 700;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.2s;
        }

        .btn-primary:hover { background-color: #0056b3; }

        .btn-link {
            margin-left: 15px;
            color: #007bff;
            text-decoration: none;
            font-weight: 600;
        }

        @media (max-width: 768px) {
            .card { padding: 30px 20px; }
            h2 { font-size: 22px; }
            h3 { font-size: 16px; }
        }
    </style>
</head>
<body>

<main class="card">
    <h2>Create a New Article</h2>

    <form action="/tutor/resources/${resourceId}/article/save" method="post">
        <label for="title">Title:</label>
        <input type="text" id="title" name="articleTitle" value="${article.articleTitle!}" placeholder="Enter the article title" required>

        <label for="content">Content:</label>
        <textarea id="content" name="articleContent" rows="8" placeholder="Write your article content here...">${article.articleContent!}</textarea>

        <h3>Multiple Choice Questions (3 required)</h3>

        <#list article.questions as q>
            <fieldset>
                <legend>Question ${q?index + 1}</legend>

                <label>Question Text:</label>
                <textarea name="questions[${q?index}].question" rows="3" required></textarea>

                <label>Correct Answer:</label>
                <input type="text" name="questions[${q?index}].correctAnswer" required>

                <label>Wrong Answer 1:</label>
                <input type="text" name="questions[${q?index}].wrongAnswer1" required>

                <label>Wrong Answer 2:</label>
                <input type="text" name="questions[${q?index}].wrongAnswer2" required>

                <label>Wrong Answer 3:</label>
                <input type="text" name="questions[${q?index}].wrongAnswer3" required>
            </fieldset>
        </#list>

        <div style="margin-top: 20px;">
            <button type="submit" class="btn-primary">Publish Article</button>
            <a href="/tutor/workplace" class="btn-link">Cancel</a>
        </div>
    </form>
</main>

</body>
</html>
