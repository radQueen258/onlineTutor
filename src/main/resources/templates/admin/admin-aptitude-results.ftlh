<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Aptitude Test Results</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .back-link {
            text-decoration: none;
            color: white;
            background: #0f2b4c;
            padding: 8px 14px;
            border-radius: 6px;
            font-size: 14px;
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
        }

        tr:hover {
            background: #f1f5fb;
        }

        .status {
            font-weight: bold;
            padding: 4px 10px;
            border-radius: 12px;
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
            background: #007bff;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 13px;
        }

        .empty {
            text-align: center;
            padding: 20px;
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
