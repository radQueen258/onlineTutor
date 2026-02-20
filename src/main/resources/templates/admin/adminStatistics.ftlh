<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Overall Statistics</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            color: #333;
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            background: #0f2b4c;
            color: white;
            padding: 15px;
        }

        .sidebar h3 {
            margin-top: 0;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            margin: 10px 0;
            font-size: 14px;
        }

        .logout-btn {
            margin-top: 20px;
            background: #dc3545;
            border: none;
            color: white;
            padding: 8px 12px;
            border-radius: 6px;
            cursor: pointer;
            width: 100%;
        }

        /* Main content */
        .content {
            margin-left: 240px;
            padding: 25px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            max-width: 700px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        h1 {
            margin-top: 0;
            color: #0f2b4c;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th {
            background: #0f2b4c;
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            text-decoration: none;
            background: #0f2b4c;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="sidebar">
    <h3>Website Name</h3>

    <a href="/admin/workplace">Go to Workplace</a>
    <a href="/admin/aptitude-results">General Aptitude Results</a>

    <form action="/logout" method="post">
        <button class="logout-btn">Logout</button>
    </form>
</div>

<div class="content">
    <div class="card">
        <h1>Overall Statistics</h1>

        <#if stats?? && stats?size gt 0>
            <table>
                <tr>
                    <th>Metric</th>
                    <th>Value</th>
                </tr>

                <#list stats?keys as key>
                    <tr>
                        <td>${key}</td>
                        <td>
                            <#if stats[key]??>
                                <#if key == "Pass rate (%)">
                                    ${stats[key]?string["0.0"]}%
                                <#else>
                                    ${stats[key]!N/A}
                                </#if>
                            <#else>
                                N/A
                            </#if>
                        </td>
                    </tr>
                </#list>
            </table>

            <div style="margin-top:40px;">
                <canvas id="attemptChart"></canvas>
            </div>

            <div style="margin-top:40px; width:300px;">
                <canvas id="passRateChart"></canvas>
            </div>
        <#else>
            <p>No statistics available yet.</p>
        </#if>

        <a class="back-link" href="/admin/dashboard">← Back to Dashboard</a>
    </div>
</div>


<script>
    const totalAttempts = ${stats["Quiz attempts"]!0};
    const passRate = ${stats["Pass rate (%)"]!0};

    // Bar Chart - Attempts
    new Chart(document.getElementById('attemptChart'), {
        type: 'bar',
        data: {
            labels: ['Quiz Attempts'],
            datasets: [{
                label: 'Total Attempts',
                data: [totalAttempts],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true
        }
    });

    // Doughnut Chart - Pass Rate
    new Chart(document.getElementById('passRateChart'), {
        type: 'doughnut',
        data: {
            labels: ['Passed %', 'Failed %'],
            datasets: [{
                data: [passRate, 100 - passRate]
            }]
        },
        options: {
            responsive: true
        }
    });
</script>
</body>
</html>
