<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Analytics</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f0f4f9;
            color: #1f2d3d;
            min-height: 100vh;
        }

        /* Main container */
        main {
            max-width: 1200px;
            margin: 60px auto;
            padding: 0 30px;
        }

        /* Card */
        .card {
            background-color: #ffffff;
            border-radius: 18px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            padding: 45px;
        }

        .card-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 40px;
            color: #0f2b4c;
        }

        /* Empty state */
        .empty {
            font-size: 16px;
            color: #666;
            text-align: center;
            padding: 60px 0;
        }

        /* Chart */
        .chart-wrapper {
            margin-bottom: 50px;
        }

        canvas {
            max-height: 380px;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 14px;
            overflow: hidden;
        }

        thead {
            background-color: #0f2b4c;
        }

        th {
            text-align: left;
            padding: 16px;
            font-size: 14px;
            font-weight: 600;
            color: white;
        }

        td {
            padding: 18px 16px;
            border-bottom: 1px solid #eaeaea;
            font-size: 14px;
            vertical-align: top;
        }

        tr:nth-child(even) {
            background: #fafbfd;
        }

        tr:hover {
            background: #f1f5fb;
        }

        /* Lists */
        td ul {
            padding-left: 18px;
        }

        td li {
            margin-bottom: 6px;
        }

        /* Back link */
        .back-link {
            margin-top: 40px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            background: #0f2b4c;
            color: white;
            padding: 8px 18px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            transition: 0.2s;
        }

        .back-link:hover {
            background: #123c5e;
        }
    </style>
</head>

<body>

<#--<header>-->
<#--    <h1>Admin Analytics</h1>-->
<#--</header>-->

<main>
    <div class="card">

        <h2 class="card-title">Admin Performance Overview</h2>

        <#if stats?size == 0>
            <div class="empty">
                No quiz data available yet.
            </div>
        <#else>
            <div class="chart-wrapper">
                <canvas id="articleChart"></canvas>
            </div>
            <table>
                <thead>
                <tr>
                    <th>Article</th>
                    <th>Students Passed</th>
                    <th>Students Failed</th>
                    <th>Common Mistakes</th>
                </tr>
                </thead>
                <tbody>
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
                            <#else>
                                No data yet
                            </#if>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#if>

        <a href="/admin/workplace" class="back-link">
            <i class="fa-solid fa-arrow-left"></i>
            Back to Workplace
        </a>

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
