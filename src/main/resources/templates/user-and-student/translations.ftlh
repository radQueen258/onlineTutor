<!DOCTYPE html>
<html>
<head>
    <title>Translations</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <style>

        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        h1 {
            font-size: 2.4rem;
            margin-bottom: 10px;
        }
        h2 {
            font-size:32px;
            margin-bottom:30px;
        }

        table {
            width:100%;
            background:#fff;
            border-radius:16px;
            overflow:hidden;
            box-shadow:0 5px 20px rgba(0,0,0,0.08);
        }

        th, td {
            padding:18px;
            text-align:left;
        }

        th {
            background:#0F3456;
            color:#fff;
        }

        tr:nth-child(even) {
            background:#f9f9f9;
        }

        a {
            color:#0F3456;
            font-weight:600;
            text-decoration:none;
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

        main {
            flex: 1;
            padding: 60px 80px;
            overflow-y: auto;
            position: relative;
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
<aside>

<div class="brand">Online Tutor</div>

    <nav>
        <a href="/dashboard" class="nav-item">
            <i class="fa-solid fa-house"></i> Dashboard
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

        <a href="/articles/translations" class="nav-item active">
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
<h1>Translations</h1>

<table>
    <tr>
        <th>Article</th>
        <th>Subject</th>
        <th>Grade</th>
        <th>Language</th>
        <th>View</th>
    </tr>

    <#list translations as t>
        <tr>
            <td>${t.article.articleTitle}</td>
            <td>${t.article.subject}</td>
            <td>${t.article.resource.curriculumResource.grade}</td>
            <td>${t.language}</td>
            <td>
                <a href="/articles/${t.article.id?c}/translations/${t.language}">
                    Open
                </a>
            </td>
        </tr>
    </#list>

</table>

</main>

</body>
</html>