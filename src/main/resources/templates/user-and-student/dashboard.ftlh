<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            min-height: 100vh;
        }

        /* SIDEBAR */
        aside {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
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
            padding: 0 32px;
            font-size: 18px;
            font-weight: 600;
            font-style: italic;
            margin-bottom: 50px;
        }

        nav {
            flex-grow: 1;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 14px 32px;
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .nav-item i {
            width: 26px;
            font-size: 20px;
            margin-right: 14px;
        }

        .nav-item.active {
            background-color: #82613E;
            margin-right: 16px;
            border-top-right-radius: 12px;
            border-bottom-right-radius: 12px;
        }

        .sidebar-footer {
            padding: 0 32px;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
        }

        .profile-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        /* MAIN CONTENT */
        main {
            margin-left: 260px;
            padding: 60px 70px;
        }

        h1 {
            font-size: 2.4rem;
            margin-bottom: 10px;
        }

        .subtitle {
            color: #444;
            margin-bottom: 50px;
        }

        .dashboard-grid {
            display: flex;
            flex-direction: column;
            gap: 40px;
        }

        .aptitude-warning {
            background-color: #fdecea;
            color: #b42318;
            padding: 16px 20px;
            border-radius: 14px;
            font-weight: 600;
            max-width: 520px;
        }

        .continue-btn {
            background-color: #fbc02d;
            border: none;
            padding: 14px 36px;
            border-radius: 30px;
            font-weight: 700;
            cursor: pointer;
            font-size: 15px;
        }

        /* TOP ROW */
        .top-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: stretch;
        }

        .card {
            background: white;
            border-radius: 28px;
            padding: 36px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .progress-card h2 {
            margin-bottom: 20px;
        }

        .progress-value {
            font-size: 2rem;
            font-weight: 800;
        }

        .continue-box {
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 24px;
            background: white;
            border-radius: 28px;
            padding: 36px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }

        .upcoming {
            font-size: 1rem;
            color: #333;
        }

        /* RESOURCES */
        .resources-card h2 {
            margin-bottom: 30px;
        }

        .resource-item {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 1.1rem;
            margin-bottom: 18px;
        }

        .resource-item i {
            color: #82613E;
        }

        .resource-item a {
            text-decoration: none;
            color: inherit;
        }

        /* RESPONSIVE */
        @media (max-width: 1024px) {
            aside {
                width: 80px;
            }

            .brand,
            .nav-item span {
                display: none;
            }

            main {
                margin-left: 80px;
                padding: 40px;
            }

            .top-row {
                grid-template-columns: 1fr;
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
            <i class="fa-solid fa-house"></i><span>Dashboard</span>
        </a>
        <a href="/study-plan" class="nav-item">
            <i class="fa-solid fa-book-open"></i><span>Study Plan</span>
        </a>
        <a href="/resources" class="nav-item">
            <i class="fa-solid fa-play"></i><span>Resources</span>
        </a>
        <a href="/exam-trends" class="nav-item">
            <i class="fa-solid fa-chart-pie"></i><span>Exam Trends</span>
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
            <div>
                <p class="aptitude-warning">You still need to take your aptitude test!</p>
                <form action="/aptitude-test/start" method="get" style="margin-top: 20px;">
                    <button class="continue-btn">Take Test Now</button>
                </form>
            </div>
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
            <h2>Your Exam History</h2>

            <#if exams?? && exams?size gt 0>
                <#list exams as exam>
                    <div class="exam-card">
                        <h3>${exam.subject} — ${exam.dateTaken}</h3>
                         <p>Score: ${(exam.examScore)!0?string["0.##"]}%</p>

                        <#assign weakTopics = examWeakTopics[exam.id]>
                        <#if weakTopics?? && weakTopics?size gt 0>
                            <h4>Suggested Topics to Review:</h4>
                            <ul>
                                <#list weakTopics as topic>
                                    <li><strong>${topic.topic}</strong>: ${topic.explanation}</li>
                                </#list>
                            </ul>
                        </#if>

                        <form action="/exam/${exam.id}/retake" method="post" style="margin-top: 10px;">
                            <button type="submit" class="continue-btn">Retake Exam</button>
                        </form>
                    </div>
                </#list>
            <#else>
                <p>You haven’t taken any exams yet.</p>
            </#if>

        </div>

<#--            <div class="card resources-card">-->
<#--                <h2>Recommended Articles</h2>-->

<#--                <#assign MAX_TITLE_LENGTH = 50>-->

<#--                <#if recommendations?? && recommendations?size gt 0>-->
<#--                    <ul class="resource-list">-->
<#--                        <#list recommendations as r>-->

<#--                            <#assign fullTitle = r.title>-->
<#--                            <#if fullTitle?length gt MAX_TITLE_LENGTH>-->
<#--                                <#assign shortTitle = fullTitle?substring(0, MAX_TITLE_LENGTH) + "...">-->
<#--                            <#else>-->
<#--                                <#assign shortTitle = fullTitle>-->
<#--                            </#if>-->

<#--                            <li class="resource-item">-->
<#--                                <i class="fa-regular fa-circle-play"></i>-->
<#--                                <a href="/resources/${r.resourceId?c}/article/${r.articleId?c}"-->
<#--                                   title="${fullTitle}">-->
<#--                                    ${shortTitle} – ${r.subject}-->
<#--                                </a>-->
<#--                            </li>-->

<#--                        </#list>-->
<#--                    </ul>-->
<#--                <#else>-->
<#--                    <p>No recommended articles</p>-->
<#--                </#if>-->
<#--            </div>-->
        </#if>

    </div>
</main>

</body>
</html>
