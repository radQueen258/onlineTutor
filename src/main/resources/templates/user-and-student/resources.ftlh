<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Major Resources</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<#--    <link rel="stylesheet" href="/static/style/style1.css">-->
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

        /* Hide sidebar on mobile by default */
        @media (max-width: 768px) {
            aside {
                position: fixed;
                left: -280px; /* hide it initially */
                top: 0;
                height: 100%;
                z-index: 1000;
                transition: 0.3s ease;
            }

            aside.show {
                left: 0; /* slide in */
            }

            main {
                margin-left: 0 !important;
                transition: 0.3s ease;
            }
        }

        /* Main */
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

        .topic-name:hover {
            text-decoration: underline;
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

        /* SEARCH BAR */
        .search-form {
            display: flex;
            max-width: 400px;
            gap: 10px;
            margin-bottom: 30px;
        }

        .search-input {
            flex: 1;
            padding: 12px 18px;
            border-radius: 30px;
            border: 1px solid #ccc;
            font-size: 16px;
            outline: none;
            transition: 0.3s;
        }

        .search-input:focus {
            border-color: #3498DB;
            box-shadow: 0 0 8px rgba(52, 152, 219, 0.3);
        }

        .search-btn {
            padding: 12px 20px;
            background-color: #3498DB;
            color: #fff;
            border: none;
            border-radius: 30px;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .search-btn:hover {
            background-color: #2c81c9;
        }

        /* PAGINATION */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
        }

        .pagination {
            flex-wrap: wrap; /* allow links to go to next line */
            gap: 6px;
        }

        .page-link {
            flex: 1 1 auto; /* allow links to shrink */
            min-width: 36px; /* avoid disappearing */
            text-align: center;
        }

        @media (max-width: 400px) {
            .page-link {
                padding: 6px 10px;
                font-size: 14px;
            }
        }

        .page-link {
            padding: 8px 16px;
            border-radius: 8px;
            border: 1px solid #ccc;
            text-decoration: none;
            color: #3498DB;
            font-weight: 500;
            transition: 0.2s;
        }

        .page-link:hover {
            background-color: #3498DB;
            color: #fff;
        }

        .page-link.active {
            background-color: #3498DB;
            color: #fff;
            font-weight: 700;
            border-color: #3498DB;
        }

        /* Make resource list responsive */
        @media (max-width: 1024px) {
            .resources-card {
                width: 90%;
                margin: 0 auto 20px auto;
            }

            .resource-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }
        }

        @media (max-width: 600px) {
            .resources-card {
                width: 100%;
                padding: 15px;
            }

            .resource-row {
                padding: 8px;
            }
        }


        /* Optional: Hamburger toggle button */
        .hamburger-btn {
            display: none;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1100;
            font-size: 24px;
            cursor: pointer;
            background: #0F3456;
            color: white;
            padding: 10px 12px;
            border-radius: 8px;
        }

        @media (max-width:768px) {
            .hamburger-btn {
                display: block;
            }
        }

    </style>
</head>

<body>

<!-- Hamburger Button -->
<div class="hamburger-btn" onclick="toggleSidebar()">
    <i class="fas fa-bars"></i>
</div>

<aside>
    <div class="brand">Online Tutor</div>

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
        <a href="/articles/translations" class="nav-item">
            <i class="fa-solid fa-chart-pie"></i> Translations
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
        <h1>Resources</h1>
    </header>

    <!-- SEARCH BAR -->
    <form method="get" action="/resources" class="search-form">
        <input type="text" name="keyword" value="${keyword!""}"
               placeholder="Search topic..." class="search-input" />
        <button type="submit" class="search-btn">
            <i class="fa-solid fa-magnifying-glass"></i> Search
        </button>
    </form>

    <br>

    <section class="resources-card">
        <div class="table-header">
            <h2>Major Topic</h2>
            <h2>Articles & Videos</h2>
        </div>

        <div class="resource-list">
            <#list resources as resource>
                <div class="resource-row">
                    <p class="topic-name">
                        ${resource.topicName}
                    </p>

                    <a href="/resources/${resource.id?c}/articles-and-videos"
                       class="action-link">
                        Click Here
                    </a>
                </div>
            </#list>
            <br>

            <!-- PAGINATION -->
            <div class="pagination">
                <#if currentPage gt 0>
                    <a href="/resources?page=${currentPage - 1}&keyword=${keyword!""}" class="page-link">Previous</a>
                </#if>

                <#list 0..(totalPages - 1) as i>
                    <a href="/resources?page=${i}&keyword=${keyword!""}"
                       class="page-link<#if i == currentPage> active</#if>">
                        ${i + 1}
                    </a>
                </#list>

                <#if currentPage lt totalPages - 1>
                    <a href="/resources?page=${currentPage + 1}&keyword=${keyword!""}" class="page-link">Next</a>
                </#if>
            </div>

        </div>
    </section>
</main>

<script>
    function toggleSidebar() {
        const sidebar = document.querySelector('aside');
        sidebar.classList.toggle('show');
    }
</script>

</body>
</html>
