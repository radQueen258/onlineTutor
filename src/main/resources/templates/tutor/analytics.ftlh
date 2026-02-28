<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Analytics - Name of the WebApp</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }

        body {
            background-color: #f0f4f9;
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
            position: relative;
        }

        /* Sidebar */
        aside.sidebar {
            width: 280px;
            background-color: #113255;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            position: fixed;
            height: 100vh;
            left: 0;
            top: 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            z-index: 100;
        }

        .sidebar-brand { padding: 0 30px; font-size: 18px; font-weight: 700; margin-bottom: 60px; }

        .nav-menu { list-style: none; flex-grow: 1; }
        .nav-item {
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
            gap: 8px;
        }

        .nav-item a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-item:hover {
            background-color: #8b6b45;
            border-radius: 10px;
        }

        .sidebar-footer {
            padding: 0 40px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 14px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
        }

        .profile-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        /* Main Content */
        main.content {
            flex-grow: 1;
            margin-left: 280px;
            padding: 40px 60px;
            position: relative;
            max-width: 1200px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 15px;
            padding: 40px 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        header.page-header {
            margin-bottom: 30px;
        }

        header.page-header h2 {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 20px;
            color: #000;
        }

        /* Table styles like resources page */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            font-size: 16px;
            border-bottom: 1px solid #eee;
        }

        th {
            font-weight: 700;
            color: #333;
            background-color: transparent;
        }

        td a { color: #007bff; text-decoration: none; }
        td a:hover { text-decoration: underline; }

        .back-btn {
            display: inline-block;
            margin-top: 20px;
            background-color: #f1b981;
            color: #000;
            padding: 10px 25px;
            border-radius: 30px;
            font-weight: 700;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .back-btn:hover { background-color: #e0a95f; }

        @media (max-width: 1024px) {
            main.content { margin-left: 0; padding: 20px; }
            aside.sidebar { display: none; }
        }
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-brand">Website Name</div>
    <ul class="nav-menu">
        <li class="nav-item active">
            <a href="/tutor/workplace">
                <i class="fa-solid fa-briefcase"></i>
                Workplace
            </a>
        </li>

        <li class="nav-item">
            <a href="/tutor/analytics">
                <i class="fa-solid fa-chart-line"></i>
                View Analytics
            </a>
        </li>

        <li class="nav-item">
            <a href="/chat/teacher">
                <i class="fa-solid fa-comments"></i>
                Help a Student
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/tutor/profile" class="profile-link">Profile</a>
    </div>
</aside>

<main class="content">
    <div class="card">
        <header class="page-header">
            <h2>Your Article Performance</h2>
        </header>

        <#if stats?size == 0>
            <p>No quiz data available yet.</p>
        <#else>
            <div style="margin-bottom:40px;">
                <canvas id="articleChart"></canvas>
            </div>
            <table>
                <tr>
                    <th>Article</th>
                    <th>Students Passed</th>
                    <th>Students Failed</th>
                    <th>Common Mistakes</th>
                </tr>

                <#list stats as item>
                    <tr>
                        <td>${item.articleTitle}</td>
                        <td>${item.studentsPassed}</td>
                        <td>${item.studentsFailed}</td>
                        <td>
                            <#if item.commonMistakes?? && (item.commonMistakes?size > 0)>
                                <#assign mistakeKeys = item.commonMistakes?keys>
                                <#assign max = (mistakeKeys?size > 3)?then(3, mistakeKeys?size)>
                                <ul>
                                    <#list mistakeKeys[0..max-1] as question>
                                        <li>${question}: ${item.commonMistakes[question]}</li>
                                    </#list>
                                </ul>
                            <#else>No data yet</#if>
                        </td>
                    </tr>
                </#list>
            </table>
        </#if>

<#--        <a href="/tutor/workplace" class="back-btn">← Back to Workplace</a>-->
    </div>
</main>

<script>
    const articleLabels = [
        <#list stats as item>
        "${item.articleTitle}"<#if item_has_next>,</#if>
        </#list>
    ];

    const passedData = [
        <#list stats as item>
        ${item.studentsPassed}<#if item_has_next>,</#if>
        </#list>
    ];

    const failedData = [
        <#list stats as item>
        ${item.studentsFailed}<#if item_has_next>,</#if>
        </#list>
    ];

    new Chart(document.getElementById('articleChart'), {
        type: 'bar',
        data: {
            labels: articleLabels,
            datasets: [
                {
                    label: 'Passed',
                    data: passedData
                },
                {
                    label: 'Failed',
                    data: failedData
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                x: { stacked: true },
                y: { stacked: true }
            }
        }
    });
</script>

</body>
</html>
