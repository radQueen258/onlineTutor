<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f0f4f8;
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar */
        aside {
            width: 280px;
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
            font-weight: 600;
            font-style: italic;
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
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .nav-item i {
            width: 30px;
            font-size: 22px;
            margin-right: 15px;
        }

        .nav-item.active {
            background-color: #82613E;
            margin-right: 15px;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .sidebar-footer {
            padding: 0 40px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: #fff;
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

        .aptitude-warning {
            color: #b42318;
            background-color: #fdecea;
            padding: 12px 16px;
            border-radius: 10px;
            font-weight: 600;
            margin-bottom: 20px;
        }


        /* Main */
        main {
            margin-left: 280px;
            padding: 60px 80px;
            width: 100%;
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        a {
            text-decoration: none;
            color: inherit;
        }

        .subtitle {
            color: #333;
            margin-bottom: 60px;
        }

        .dashboard-grid {
            display: flex;
            flex-direction: column;
            gap: 40px;
        }

        .top-row {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 40px;
        }

        .card {
            background: white;
            border-radius: 30px;
            padding: 40px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .progress-card {
            width: 420px;
        }

        .progress-value {
            font-size: 1.8rem;
            font-weight: 800;
            margin-bottom: 15px;
        }

        .continue-box {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-top: 100px;
        }

        .continue-btn {
            background-color: #fbc02d;
            border: none;
            padding: 15px 40px;
            border-radius: 30px;
            font-weight: 700;
            cursor: pointer;
        }

        .upcoming {
            font-size: 1rem;
            color: #333;
        }

        .resources-card h2 {
            margin-bottom: 30px;
        }

        .resource-item {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 1.2rem;
            margin-bottom: 20px;
        }

        @media (max-width: 1024px) {
            aside {
                width: 80px;
            }
            .brand, .nav-item span {
                display: none;
            }
            main {
                margin-left: 80px;
                padding: 40px;
            }
            .top-row {
                flex-direction: column;
            }
            .continue-box {
                margin-top: 20px;
            }
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<aside>
    <div class="brand">Website Name</div>

    <nav>
        <a href="/dashboard" class="nav-item active">
            <i class="fa-solid fa-house"></i> Dashboard
        </a>
        <a href="/study-plan" class="nav-item">
            <i class="fa-solid fa-book-open"></i> Study Plan
        </a>
        <a href="/resources" class="nav-item">
            <i class="fa-solid fa-play"></i> Resources
        </a>
        <a href="/exam-trends" class="nav-item">
            <i class="fa-solid fa-chart-pie"></i> Exam Trends
        </a>
    </nav>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/profile" class="profile-link">Profile</a>
    </div>
</aside>

<!-- MAIN -->
<main>

    <h1>Welcome, ${firstName}</h1>
    <p class="subtitle">Here's a quick overview of your progress and recommendations.</p>

    <div class="dashboard-grid">

        <#if needsTest>
            <p class="aptitude-warning">You still need to take your aptitude test!</p>
            <form action="/aptitude-test/start" method="get">
                <button class="continue-btn">Take Test Now</button>
            </form>
        </#if>

        <#if progress??>
            <div class="top-row">

                <div class="card progress-card">
                    <h2>Progress</h2>
                    <div class="progress-value">${progress}</div>
                </div>

                <div class="continue-box">
                    <a href="/study-plan">
                        <button class="continue-btn">Continue Plan</button>
                    </a>
                    <div class="upcoming">
                        <strong>Upcoming:</strong> ${upcoming}
                    </div>
                </div>

            </div>

            <div class="card resources-card">
                <h2>Recommended Articles</h2>

                <#assign MAX_TITLE_LENGTH = 50>

                <#if recommendations?? && recommendations?size gt 0>
                    <ul class="resource-list">
                        <#list recommendations as r>

                            <#assign fullTitle = r.title>
                            <#if fullTitle?length gt MAX_TITLE_LENGTH>
                                <#assign shortTitle = fullTitle?substring(0, MAX_TITLE_LENGTH) + "...">
                            <#else>
                                <#assign shortTitle = fullTitle>
                            </#if>

                            <li class="resource-item">
                                <i class="fa-regular fa-circle-play"></i>
                                <a href="/resources/${r.resourceId}/article/${r.articleId}"
                                   title="${fullTitle}">
                                    ${shortTitle} – ${r.subject}
                                </a>
                            </li>

                        </#list>
                    </ul>
                <#else>
                    <p>No recommended articles</p>
                </#if>
            </div>
        </#if>

    </div>
</main>

</body>
</html>
