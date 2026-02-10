<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Videos</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f6f9;
        }

        .sidebar {
            width: 220px;
            position: fixed;
            height: 100vh;
            background: #0f2b4c;
            color: white;
            padding: 15px;
        }

        .sidebar a {
            display: block;
            color: white;
            text-decoration: none;
            margin: 10px 0;
        }

        .logout-btn {
            margin-top: 20px;
            background: #dc3545;
            border: none;
            color: white;
            padding: 8px;
            border-radius: 6px;
            width: 100%;
        }

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

        .btn-view {
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
        }
    </style>
</head>

<body>

<div class="sidebar">
    <h3>Website Name</h3>
    <a href="/admin/workplace">Go to Workplace</a>
    <a href="/admin/aptitude-results">General Aptitude Results</a>

    <form action="/logout" method="post">
        <button class="logout-btn">Logout</button>
    </form>
</div>

<div class="content">
    <div class="card">
        <h1>Manage Videos</h1>

        <table>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Uploaded By</th>
                <th>Actions</th>
            </tr>

            <#list videos as video>
                <tr>
                    <td>${video.id}</td>
                    <td>${video.videoTitle}</td>
                    <td>${video.article.tutorName.firstName}</td>
                    <td>
                        <a class="btn-view" href="/admin/videos/${video.id}">Check</a>

                        <form action="/admin/videos/delete/${video.id}" method="post" style="display:inline;">
                            <button class="btn-delete"
                                    onclick="return confirm('Are you sure you want to delete this video?');">
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
