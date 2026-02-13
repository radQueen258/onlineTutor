<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Articles</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">


    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Inter', system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
            display: flex;
            min-height: 100vh;
            background-color: #f0f4f9;
            color: #333;
        }

        aside {
            width: 260px;
            background-color: #0F3456;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 30px 0;
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
            margin-top: 20px;
            background: #dc3545;
            border: none;
            color: white;
            padding: 8px;
            border-radius: 6px;
            width: 100%;
            cursor: pointer;
        }

        /* Content */
        .content {
            flex-grow: 1;
            padding: 50px 60px;
        }

        .card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        h1 {
            margin-top: 0;
            color: #0f2b4c;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th {
            background: #0f2b4c;
            color: white;
            padding: 12px;
            text-align: left;
            line-height: 1.4;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
            line-height: 1.4;
        }

        .btn-upload {
            background: #007bff;
            color: white;
            padding: 6px 10px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 13px;
        }

        .btn-delete {
            background: #dc3545;
            border: none;
            color: white;
            padding: 6px 10px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 13px;
            margin-left: 6px;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            background: #0f2b4c;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 14px;
        }
    </style>
</head>

<body>

<!-- Sidebar -->
<aside>
    <div class="brand">Website Name</div>

    <nav>
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
            <button class="logout-btn">Logout</button>
        </form>
    </div>
</aside>

<!-- Main Content -->
<main class="content">
    <div class="card">
        <h1>Manage Articles</h1>

        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Actions</th>
            </tr>

            <#list articles as article>
                <tr>
                    <td>${article.id?c}</td>
                    <td>${article.articleTitle}</td>
                    <td>${article.tutorName.firstName}</td>
                    <td>
                        <a class="btn-upload"
                           href="/admin/resources/${article.resource.id?c}/article/${article.id?c}/upload-video">
                            Upload Video
                        </a>

                        <form action="/admin/articles/delete/${article.id?c}"
                              method="post"
                              style="display:inline;">
                            <button class="btn-delete"
                                    onclick="return confirm('Are you sure you want to delete this article?');">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
            </#list>
        </table>

        <a class="back-link" href="/admin/dashboard">← Back to Dashboard</a>
    </div>
</main>

</body>
</html>
