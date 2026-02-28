<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Aptitude Test Results</title>
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
            margin: 0;
            color: #0f2b4c;
            font-size: 26px;
            font-weight: 700;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .back-link {
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

        canvas {
            max-height: 300px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
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
        }

        tr:nth-child(even) {
            background: #fafbfd;
        }

        tr:hover {
            background: #f1f5fb;
        }

        .status {
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
        }

        .status.PASSED {
            background: #d4edda;
            color: #155724;
        }

        .status.FAILED {
            background: #f8d7da;
            color: #721c24;
        }

        .btn-view {
            text-decoration: none;
            background: #0f2b4c;
            color: white;
            padding: 6px 14px;
            border-radius: 8px;
            font-size: 13px;
            transition: 0.2s;
        }

        .btn-view:hover {
            background: #123c5e;
        }

        .empty {
            text-align: center;
            padding: 25px;
            color: #777;
        }
    </style>
</head>

<body>

<div class="container">

    <div class="top-bar">
        <h2>Aptitude Test Results</h2>
        <a class="back-link" href="/admin/dashboard">← Back to Dashboard</a>
    </div>

    <div style="margin-bottom:40px;">
        <canvas id="aptitudeChart"></canvas>
    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Score</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>

        <#if tests?has_content>
            <#list tests as test>
                <tr>
                    <td>${test.id?c}</td>
                    <td>${test.userId?c}</td>
                    <td>${test.score!'-'}</td>
                    <td>
                        <span class="status ${test.status}">
                            ${test.status}
                        </span>
                    </td>
                    <td>
                        <a class="btn-view" href="/admin/aptitude-results/${test.id?c}">
                            View Details
                        </a>
                    </td>
                </tr>
            </#list>
        <#else>
            <tr>
                <td colspan="5" class="empty">
                    No test results available
                </td>
            </tr>
        </#if>
    </table>

</div>

<script>
    const statuses = [
        <#list tests as test>
        "${test.status}"<#if test_has_next>,</#if>
        </#list>
    ];

    let passed = 0;
    let failed = 0;

    statuses.forEach(status => {
        if (status === "PASSED") passed++;
        if (status === "FAILED") failed++;
    });

    new Chart(document.getElementById('aptitudeChart'), {
        type: 'pie',
        data: {
            labels: ['Passed', 'Failed'],
            datasets: [{
                data: [passed, failed]
            }]
        },
        options: {
            responsive: true
        }
    });
</script>

</body>
</html>
