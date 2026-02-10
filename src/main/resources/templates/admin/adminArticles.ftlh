<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Articles</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            position: fixed;
            height: 100vh;
            background: #0f2b4c;
            color: white;
            padding: 15px;
        }

        .sidebar h3 {
            margin-top: 0;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            margin: 10px 0;
            font-size: 14px;
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
            margin-left: 240px;
            padding: 25px;
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
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
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
<div class="sidebar">
    <h3>Website Name</h3>

    <a href="/admin/workplace">Go to Workplace</a>
    <a href="/admin/aptitude-results">General Aptitude Results</a>

    <form action="/logout" method="post">
        <button class="logout-btn">Logout</button>
    </form>
</div>

<!-- Main Content -->
<div class="content">
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
                    <td>${article.id}</td>
                    <td>${article.articleTitle}</td>
                    <td>${article.tutorName.firstName}</td>
                    <td>
                        <a class="btn-upload"
                           href="/admin/resources/${article.resource.id}/article/${article.id}/upload-video">
                            Upload Video
                        </a>

                        <form action="/admin/articles/delete/${article.id}"
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
</div>

</body>
</html>
