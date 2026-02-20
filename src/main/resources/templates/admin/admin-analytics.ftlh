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
            color: #333;
            min-height: 100vh;
        }

        /* Header */
        header {
            background-color: #0F3456;
            height: 260px;
            border-bottom-left-radius: 40px;
            border-bottom-right-radius: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        header h1 {
            color: #fff;
            font-size: 32px;
            font-weight: 800;
            letter-spacing: 1px;
        }

        /* Main container */
        main {
            max-width: 1100px;
            margin: -130px auto 60px;
            padding: 0 30px;
        }

        /* Card */
        .card {
            background-color: #ffffff;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            padding: 40px;
        }

        .card-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 30px;
            color: #123c5e;
        }

        /* Empty state */
        .empty {
            font-size: 16px;
            color: #666;
            text-align: center;
            padding: 40px 0;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        thead {
            background-color: #f8fafc;
        }

        th {
            text-align: left;
            padding: 14px 16px;
            font-size: 14px;
            font-weight: 700;
            color: #123c5e;
            border-bottom: 2px solid #e3e8ef;
        }

        td {
            padding: 16px;
            vertical-align: top;
            border-bottom: 1px solid #e3e8ef;
            font-size: 14px;
        }

        tr:last-child td {
            border-bottom: none;
        }

        /* Lists inside table */
        td ul {
            padding-left: 18px;
        }

        td li {
            margin-bottom: 6px;
        }

        /* Back link */
        .back-link {
            margin-top: 30px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            color: #123c5e;
            font-weight: 600;
            font-size: 15px;
        }

        .back-link i {
            font-size: 14px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            main {
                margin-top: -100px;
                padding: 0 20px;
            }

            .card {
                padding: 30px 20px;
            }

            table {
                font-size: 13px;
            }
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
            <div style="margin-bottom:40px;">
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
