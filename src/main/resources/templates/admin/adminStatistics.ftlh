<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Overall Statistics</title>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            display: flex;
            min-height: 100vh;
            background-color: #f0f4f9;
            color: #333;
        }

        /* Sidebar */
        aside {
            width: 260px;
            background-color: #0F3456;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
        }

        .brand {
            padding: 0 40px;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 60px;
        }

        nav {
            flex-grow: 1;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 15px 40px;
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
            gap: 8px;
        }

        .nav-item i {
            width: 26px;
            margin-right: 12px;
        }

        .nav-item:hover {
            background-color: #123c5e;
        }

        .sidebar-footer {
            padding: 0 40px;
        }

        .logout-btn {
            width: 100%;
            background-color: #dc3545;
            border: none;
            padding: 10px;
            border-radius: 10px;
            color: white;
            font-weight: 600;
            cursor: pointer;
        }

        .profile-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        main {
            flex-grow: 1;
            padding: 50px 60px;
        }



        /* Content */
        .content {
            margin-left: 270px;
            padding: 50px 40px;
        }

        .card {
            background: white;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.06);
            max-width: 900px;
        }

        h1 {
            margin-bottom: 30px;
            color: #0f2b4c;
            font-size: 26px;
            font-weight: 700;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
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

        /* Charts */
        .chart-wrapper {
            margin-top: 50px;
        }

        canvas {
            max-height: 320px;
        }

        .back-link {
            display: inline-block;
            margin-top: 40px;
            text-decoration: none;
            background: #0f2b4c;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.2s;
        }

        .back-link:hover {
            background: #123c5e;
        }
    </style>
</head>

<body>

<!-- Sidebar -->
<aside>
    <div class="brand">Website Name</div>

    <nav>
        <a href="/admin/dashboard" class="nav-item active">
            <i class="fa-solid fa-house"></i>Dashboard
        </a>
        <a href="/admin/workplace" class="nav-item">
            <i class="fa-solid fa-briefcase"></i>
            Workplace
        </a>
        <a href="/admin/aptitude-results" class="nav-item">
            <i class="fa-solid fa-chart-line"></i>
            Aptitude Results
        </a>
    </nav>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/admin/profile" class="profile-link">Profile</a>
    </div>
</aside>

<main>
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

            <div class="chart-wrapper">
                <canvas id="attemptChart"></canvas>
            </div>

            <div class="chart-wrapper">
                <canvas id="passRateChart"></canvas>
            </div>
        <#else>
            <p>No statistics available yet.</p>
        </#if>

    </div>
</div>
    </main>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<script>
    const totalAttempts = ${stats["Quiz attempts"]!0?c};
    const passRate = ${stats["Pass rate (%)"]!0?c};

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
