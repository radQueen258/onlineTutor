<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Aptitude Test Details</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 1100px;
            margin: auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        h2 {
            margin-top: 0;
            color: #0f2b4c;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: white;
            background: #0f2b4c;
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 14px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 15px;
            margin-bottom: 25px;
        }

        .info-box {
            background: #f8f9fc;
            padding: 15px;
            border-radius: 10px;
            border-left: 5px solid #0f2b4c;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th {
            background: #0f2b4c;
            color: white;
            text-align: left;
            padding: 12px;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
            vertical-align: top;
        }

        tr:hover {
            background: #f1f5fb;
        }

        .no-data {
            color: #777;
            margin-top: 15px;
        }
    </style>
</head>

<body>

<div class="container">

    <a class="back-link" href="/admin/aptitude-results">← Back to All Results</a>

    <h2>Aptitude Test Details</h2>

    <div class="info-grid">
        <div class="info-box">
            <strong>User ID</strong>
            <p>${test.userId?c}</p>
        </div>

        <div class="info-box">
            <strong>Score</strong>
            <p>
                <#if test.score?has_content>
                    ${test.score}
                <#else>
                    0
                </#if>
            </p>
        </div>

        <div class="info-box">
            <strong>Status</strong>
            <p>${test.status}</p>
        </div>
    </div>

    <#if test.questions?has_content>
        <h3>Questions & Answers</h3>

        <table>
            <tr>
                <th>Question</th>
                <th>User Answer</th>
                <th>Correct Answer</th>
            </tr>

            <#list test.questions as q>
                <tr>
                    <td>${q.questionText}</td>
                    <td>${q.userAnswer!'-'}</td>
                    <td>${q.correctAnswer!'-'}</td>
                </tr>
            </#list>
        </table>
    <#else>
        <p class="no-data">No questions available for this test.</p>
    </#if>

</div>

</body>
</html>
