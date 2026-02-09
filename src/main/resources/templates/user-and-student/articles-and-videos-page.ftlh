<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resources</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            display: flex;
            height: 100vh;
            background-color: #F4F7FA;
            overflow: hidden;
        }

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

        main {
            flex-grow: 1;
            padding: 60px 80px;
            overflow-y: auto;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 60px;
        }

        h1 {
            font-size: 36px;
            font-weight: 700;
        }

        .resources-card {
            background-color: #F9FBFF;
            border: 1px solid #E0E7FF;
            border-radius: 12px;
            padding: 40px 60px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.02);
        }

        .table-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 40px;
        }

        .table-header h2 {
            font-size: 24px;
            font-weight: 700;
        }

        .resource-list {
            display: flex;
            flex-direction: column;
            gap: 35px;
        }

        .resource-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .topic-name {
            font-size: 18px;
            font-weight: 600;
            color: #000;
            text-decoration: none;
        }

        .action-link {
            color: #3498DB;
            text-decoration: none;
            font-weight: 600;
            font-size: 18px;
        }

        .action-link:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
<div style="display: flex; height: 100vh;">

    <!-- Sidebar -->
    <aside>
        <div class="brand">Website Name</div>

        <nav>
            <a href="/dashboard" class="nav-item">
                <i class="fa-solid fa-house"></i> Dashboard
            </a>
            <a href="/study-plan" class="nav-item">
                <i class="fa-solid fa-book-open"></i> Study Plan
            </a>
            <a href="/resources" class="nav-item active">
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

    <!-- Main Content -->
    <main>

        <header>
            <#list resourceName as name>
                <h1>Resources – ${name.topicName}</h1>
            </#list>
        </header>

        <section class="resources-card">

            <div class="table-header">
                <h2>Article</h2>
                <h2>Video</h2>
            </div>

            <div class="resource-list">
                <#list articleList as article>
                    <div class="resource-row">
                        <a href="/resources/${resourceId}/article/${article.id}"
                           class="topic-name">
                            ${article.articleTitle}
                        </a>

                        <#if article.video??>
                            <a href="/resources/${resourceId}/video/${article.video.id}"
                               class="action-link">
                                Click Here
                            </a>
                        <#else>
                            <span style="color: gray; font-weight: 500;">
                                No video available
                            </span>
                        </#if>
                    </div>
                </#list>
            </div>

        </section>
    </main>

</div>
</body>
</html>
