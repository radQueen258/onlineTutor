<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Aptitude Test Details</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        body {
            font-family: 'Inter', sans-serif;
            background: #f4f6f9;
            margin: 0;
            padding: 40px 20px;
            color: #1f2d3d;
        }

        .container {
            max-width: 1100px;
            margin: auto;
            background: white;
            padding: 35px 40px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.06);
        }

        h2 {
            margin-top: 0;
            margin-bottom: 25px;
            color: #0f2b4c;
            font-size: 26px;
            font-weight: 700;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 25px;
            text-decoration: none;
            color: white;
            background: #0f2b4c;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.2s;
        }

        .back-link:hover {
            background: #123c5e;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 35px;
        }

        .info-box {
            background: #f8f9fc;
            padding: 18px;
            border-radius: 12px;
            border-left: 5px solid #0f2b4c;
        }

        .info-box strong {
            font-size: 14px;
            color: #6c757d;
        }

        .info-box p {
            margin-top: 8px;
            font-size: 18px;
            font-weight: 600;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .status-badge.PASSED {
            background: #d4edda;
            color: #155724;
        }

        .status-badge.FAILED {
            background: #f8d7da;
            color: #721c24;
        }

        h3 {
            margin-bottom: 15px;
            color: #0f2b4c;
            font-weight: 600;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            border-radius: 12px;
            overflow: hidden;
        }

        th {
            background: #0f2b4c;
            color: white;
            padding: 14px;
            font-weight: 600;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #eaeaea;
            vertical-align: top;
        }

        tr:nth-child(even) {
            background: #fafbfd;
        }

        tr:hover {
            background: #f1f5fb;
        }

        .no-data {
            color: #777;
            margin-top: 20px;
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
            <p>
    <span class="status-badge ${test.status}">
        ${test.status}
    </span>
            </p>
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
