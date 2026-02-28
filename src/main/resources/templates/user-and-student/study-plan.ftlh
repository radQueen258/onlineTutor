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

        /* Topics Card Enhancements */
        .topics-card {
            background: #fff;
            border-radius: 30px;
            padding: 40px 50px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
            max-width: 900px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .topic-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 20px;
            border-radius: 20px;
            transition: 0.2s;
            cursor: pointer;
            background-color: #f9fbff;
        }

        .topic-item:hover {
            background-color: #e6f0ff;
            transform: translateY(-2px);
        }

        .topic-item i {
            font-size: 1.8rem;
            margin-right: 20px;
            color: #3498DB;
        }

        .topic-item span {
            font-size: 1.2rem;
            font-weight: 600;
            color: #0F3456;
        }

        /* Fixed Continue Button */
        .action-container {
            position: fixed;
            bottom: 30px;
            right: 50px;
            z-index: 100;
        }

        .continue-btn {
            background-color: #f4c430;
            color: #000;
            border: none;
            padding: 15px 40px;
            border-radius: 25px;
            font-size: 1.1rem;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s, background-color 0.2s, box-shadow 0.2s;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .continue-btn:hover {
            background-color: #e6b420;
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.2);
        }

        /* Responsive Adjustments */
        @media (max-width: 900px) {
            main {
                padding: 40px 20px;
            }
            .topics-card {
                padding: 30px;
            }
            .action-container {
                right: 20px;
                bottom: 20px;
            }
        }


        /* Collapsible Subject Styles */
        .subject-section {
            margin-bottom: 30px;
        }

        .subject-header {
            background-color: #f4c43033;
            padding: 15px 20px;
            border-radius: 20px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 700;
            font-size: 1.2rem;
            transition: background-color 0.2s;
        }

        .subject-header:hover {
            background-color: #f4c43055;
        }

        .subject-header i {
            transition: transform 0.3s;
        }

        .subject-header.collapsed i {
            transform: rotate(-90deg);
        }

        /* Collapsible Topics Container */
        .topics-collapsible {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
            margin-top: 10px;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        /* Individual Topic Items */
        .topic-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 18px;
            border-radius: 20px;
            background-color: #f9fbff;
            transition: background-color 0.2s, transform 0.2s;
            cursor: default;
        }

        .topic-item:hover {
            background-color: #e6f0ff;
            transform: translateY(-1px);
        }

        .topic-item i {
            font-size: 1.5rem;
            margin-right: 15px;
            color: #3498DB;
        }

        .topic-item span {
            font-weight: 600;
            color: #0F3456;
        }

        /* Fixed Continue Button */
        .action-container {
            position: fixed;
            bottom: 30px;
            right: 50px;
            z-index: 100;
        }


    </style>
</head>
<body>

<!-- SIDEBAR -->
<aside>
    <div class="brand">Online Tutor</div>

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

<main>
    <header>
        <h1>Your Study Plan</h1>
    </header>

    <#if message??>
        <p>${message}</p>
    </#if>

    <#if plans?? && (plans?size > 0)>
        <section class="topics-section">

            <#list plansBySubject as subjectName, topics>
                <div class="subject-section">

                    <!-- Collapsible Header -->
                    <div class="subject-header collapsed" onclick="toggleTopics(this)">
                        <span>${subjectName}</span>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>

                    <!-- Collapsible Topics -->
                    <div class="topics-collapsible">
                        <#list topics as p>
                            <div class="topic-item">
                                <div class="topic-left">
                                    <i class="fa-regular fa-circle-play"></i>
                                    <span>${p.article.articleTitle}</span>
                                </div>
                                <div class="topic-right">
                                    <#if p.completed>
                                        Completed
                                    <#else>
                                        ${(p.progress * 100)?string["0.##"]}%
                                    </#if>
                                </div>
                            </div>
                        </#list>
                    </div>
                </div>
            </#list>

        </section>

        <div class="action-container">
            <a href="/study/continue">
                <button class="continue-btn">Continue Plan</button>
            </a>
        </div>

        <div class="action-container">
            <a href="/study/continue">
                <button class="continue-btn">Continue Plan</button>
            </a>
        </div>

<#--        <div class="action-container">-->
<#--            <a href="/study/continue">-->
<#--                <button class="continue-btn">Continue Plan</button>-->
<#--            </a>-->
<#--        </div>-->

    <#else>
        <p>No study plan available yet.</p>
    </#if>

</main>

<script>
    function toggleTopics(header) {
        const container = header.nextElementSibling;
        const icon = header.querySelector('i');

        if (container.style.maxHeight && container.style.maxHeight !== "0px") {
            container.style.maxHeight = "0";
            header.classList.add("collapsed");
        } else {
            container.style.maxHeight = container.scrollHeight + "px";
            header.classList.remove("collapsed");
        }
    }
</script>

</body>
</html>
