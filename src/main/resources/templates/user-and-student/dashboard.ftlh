<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
            display: flex;
        }

        /* SIDEBAR */
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
            transition: 0.2s ease;
            gap: 8px;
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
            gap: 8px;
        }

        .sidebar-footer {
            padding: 0 40px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
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

        /* MAIN CONTENT */
        main {
            flex: 1;
            padding: 60px 80px;
            overflow-y: auto;
            position: relative;
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

        /* EXAM DROPDOWN */
        .exam-dropdown {
            position: relative;
            display: inline-block;
        }

        .exam-main-btn {
            background: linear-gradient(135deg, #0F3456, #1c5d91);
            color: white;
            border: none;
            padding: 14px 36px;
            border-radius: 30px;
            font-weight: 700;
            font-size: 15px;
            cursor: pointer;
            transition: 0.3s ease;
        }

        .exam-main-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .exam-dropdown-content {
            position: absolute;
            top: 60px;
            left: 0;
            background: white;
            min-width: 220px;
            border-radius: 18px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.15);
            display: none;
            padding: 15px;
            z-index: 10;
        }

        .exam-dropdown:hover .exam-dropdown-content {
            display: block;
        }

        .exam-option {
            width: 100%;
            background: none;
            border: none;
            padding: 10px;
            text-align: left;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .exam-option:hover {
            background-color: #f0f4f8;
        }


        .average-card {
            text-align: center;
        }

        .average-value {
            font-size: 3rem;
            font-weight: 800;
            color: #0F3456;
        }

        .topics-section {
            margin-top: 20px;
        }

        .topics-section h4 {
            margin-bottom: 15px;
            font-weight: 600;
        }

        .topics-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .topic-pill {
            background-color: #f0f4f8;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            color: #0F3456;
            transition: 0.2s ease;
        }

        .topic-pill:hover {
            background-color: #82613E;
            color: white;
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<aside>
    <div class="brand">Online Tutor</div>

    <nav>
        <a href="/dashboard" class="nav-item active">
            <i class="fa-solid fa-house"></i>Dashboard
        </a>

        <a href="/study-plan" class="nav-item">
            <i class="fa-solid fa-book-open"></i> Study Plan
        </a>

        <a href="/resources" class="nav-item">
            <i class="fa-solid fa-play"></i> Resources
        </a>

        <a href="/chat/student" class="nav-item">
            <i class="fa-solid fa-comments"></i> Contact a Tutor
        </a>

        <a href="/articles/translations" class="nav-item">
            <i class="fa-solid fa-globe"></i> Translations
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
                    <div class="exam-dropdown">
                        <button class="exam-main-btn">
                            Take Exam <i class="fa-solid fa-chevron-down"></i>
                        </button>

                        <div class="exam-dropdown-content">
                            <#list selectedSubjects as subject>
                                <form method="get" action="/exam/start">
                                    <input type="hidden" name="userId" value="${user.id?c}">
                                    <input type="hidden" name="subject" value="${subject}">
                                    <button type="submit" class="exam-option">
                                        ${subject}
                                    </button>
                                </form>
                            </#list>
                        </div>
                    </div>
                    <div class="upcoming">
                        <strong>Your Study Plan Upcoming:</strong> ${upcoming}
                    </div>
                </div>

            </div>

<#--        <div class="card resources-card">-->
            <div class="card average-card">
                <h2>Average Score</h2>
                <div class="average-value">
                    <#assign total = 0>
                    <#list exams as exam>
                        <#assign total = total + (exam.score)!0>
                    </#list>
                    <#if exams?size gt 0>
                        ${(total / exams?size)?string["0.##"]}%
                    <#else>
                        0%
                    </#if>
                </div>
            </div>

            <br>

            <div class="card analytics-card">
                <h2>Performance Overview</h2>
                <canvas id="performanceChart" height="120"></canvas>
            </div>

            <br>

            <h2>Your Exam History</h2>

            <#if exams?? && exams?size gt 0>
                <#list exams as exam>
                    <div class="exam-card">
                        <h3>${exam.subject} — ${exam.dateTaken}</h3>

                        <p>
                            Score:
                            <span style="
                            <#if exam.score gte 70>
                                    color: #2e7d32;
                            <#elseif exam.score gte 50>
                                    color: #f9a825;
                            <#else>
                                    color: #c62828;
                            </#if>
                                    font-weight: 700;
                                    ">
        ${(exam.score)!0?string["0.##"]}%
    </span>
                        </p>

                        <#assign weakTopics = examWeakTopics[exam.id?string]>
                        <#if weakTopics?? && weakTopics?size gt 0>
                            <div class="topics-section">
                                <h4>Suggested Topics to Review</h4>
                                <div class="topics-container">
                                    <#list weakTopics as resource>
                                        <div class="topic-pill">
                                            ${resource.topicName}
                                        </div>
                                    </#list>
                                </div>
                            </div>
                        </#if>
                    </div>

                    <br>
                </#list>
            <#else>
                <p>You haven’t taken any exams yet.</p>
            </#if>

<#--        </div>-->

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

<script>
    const subjects = [
        <#list exams as exam>
        "${exam.subject}"<#if exam_has_next>,</#if>
        </#list>
    ];

    const scores = [
        <#list exams as exam>
        ${(exam.score)!0?c}<#if exam_has_next>,</#if>
        </#list>
    ];

    const ctx = document.getElementById('performanceChart').getContext('2d');

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: subjects,
            datasets: [{
                label: 'Score (%)',
                data: scores,
                borderRadius: 8
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 100
                }
            }
        }
    });

    window.addEventListener("load", () => {
        document.querySelectorAll(".score-bar").forEach(bar => {
            const width = bar.getAttribute("data-width");
            bar.style.width = width + "%";
        });
    });
</script>

</body>
</html>
