<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Study Plan</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f4f7fa;
            display: flex;
            height: 100vh;
            overflow: hidden;
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

        /* Main Content Styles */
        main {
            flex: 1;
            padding: 60px 80px;
            overflow-y: auto;
            position: relative;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        h1 {
            font-size: 2.2rem;
            font-weight: 700;
            color: #000;
        }

        .globe-icon {
            width: 45px;
            height: 45px;
            border: 2px solid #e6a532;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #e6a532;
            font-size: 1.2rem;
        }

        .progress-section {
            margin-bottom: 60px;
        }

        .progress-label {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            display: block;
        }

        .progress-bar-container {
            width: 300px;
            height: 12px;
            background-color: #f0f0f0;
            border-radius: 6px;
            overflow: hidden;
        }

        .progress-bar-fill {
            height: 100%;
            width: 60%;
            background-color: #f4c430;
            border-radius: 6px;
        }

        .topics-section h2 {
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .topics-card {
            background: white;
            border-radius: 30px;
            padding: 40px 50px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
            max-width: 900px;
        }

        .topic-item {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
        }

        .topic-item:last-child {
            margin-bottom: 0;
        }

        .topic-item i {
            font-size: 2rem;
            margin-right: 25px;
            color: #000;
        }

        .topic-item span {
            font-size: 1.4rem;
            font-weight: 600;
            color: #000;
        }

        .action-container {
            margin-top: 40px;
            display: flex;
            justify-content: flex-end;
            max-width: 900px;
        }

        .continue-btn {
            background-color: #f4c430;
            color: #000;
            border: none;
            padding: 15px 40px;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s, background-color 0.2s;
        }

        .continue-btn:hover {
            background-color: #e6b420;
            transform: translateY(-2px);
        }

        /* Responsive adjustments */
        @media (max-width: 900px) {
            main {
                padding: 40px;
            }
            .topics-card {
                padding: 30px;
            }
        }
    </style>
</head>
<body>

<aside>
    <div class="brand">Website Name</div>

    <nav>
        <a href="/dashboard" class="nav-item">
            <i class="fa-solid fa-house"></i> Dashboard
        </a>
        <a href="/study-plan" class="nav-item active">
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

<main>
    <header>
        <h1>Your Study Plan</h1>
        <div class="globe-icon">
            <i class="fa-solid fa-globe"></i>
        </div>
    </header>

    <#if message??>
        <p>${message}</p>
    </#if>

    <#if plans?? && (plans?size > 0)>
        <section class="topics-section">
            <div class="topics-card">

                <#list plans as p>
                    <div class="topic-item">
                        <i class="fa-regular fa-circle-play"></i>
                        <span>
                            ${p.article.articleTitle}
                            —
                            <#if p.completed>
                                Completed
                            <#else>
                                ${(p.progress * 100)?string["0.##"]}%
                            </#if>
                        </span>
                    </div>
                </#list>

            </div>
        </section>

        <div class="action-container">
            <a href="/study/continue">
                <button class="continue-btn">Continue Plan</button>
            </a>
        </div>

    <#else>
        <p>No study plan available yet.</p>
    </#if>

</main>

</body>
</html>
