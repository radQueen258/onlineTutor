<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registered Users</title>

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
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        h1, h2 {
            color: #0f2b4c;
            margin-top: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th {
            background: #0f2b4c;
            color: white;
            padding: 10px;
            text-align: left;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
        }

        .delete-btn {
            background: #dc3545;
            border: none;
            color: white;
            padding: 6px 10px;
            border-radius: 6px;
            cursor: pointer;
        }

        .back-link {
            text-decoration: none;
            background: #0f2b4c;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
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
    <h1>Registered Students</h1>

    <div class="card">
        <h2>Students</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Actions</th>
            </tr>

            <#list userStudent as user>
                <tr>
                    <td>${user.id}</td>
                    <td>${user.firstName} ${user.lastName}</td>
                    <td>${user.email}</td>
                    <td>${user.role}</td>
                    <td>
                        <form action="/admin/users/delete/${user.id}" method="post">
                            <button class="delete-btn"
                                    onclick="return confirm('Are you sure you want to delete this user?');">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
            </#list>
        </table>
    </div>

    <a class="back-link" href="/admin/dashboard">← Back to Dashboard</a>
</div>

</body>
</html>
