<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Chats</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <style>
        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
        }

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background-color: #111827;
            color: white;
            padding: 20px;
        }

        .sidebar h2 {
            margin-bottom: 30px;
        }

        .sidebar a {
            display: block;
            color: #d1d5db;
            text-decoration: none;
            padding: 10px 0;
        }

        .sidebar a:hover {
            color: white;
        }

        .main-content {
            flex: 1;
            padding: 40px;
        }

        .page-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: 0.2s;
        }

        .card:hover {
            transform: translateY(-3px);
        }

        .empty-state {
            background: white;
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
    </style>
</head>

<body>

<div class="dashboard-container">

    <div class="sidebar">
        <h2>Teacher Panel</h2>
        <a href="/teacher/dashboard">Dashboard</a>
        <a href="/chat/teacher">Chats</a>
        <a href="/logout">Logout</a>
    </div>

    <div class="main-content">

        <div class="page-title">Student Chats</div>

        <#if chatRooms?? && chatRooms?size gt 0>

            <#list chatRooms as room>
                <div class="card">
                    <strong>${room.subject}</strong><br>
                    Student: ${room.student.firstName} ${room.student.lastName}
                    <br><br>
                    <a href="/chat/teacher/room/${room.id}">
                        Open Chat →
                    </a>
                </div>
            </#list>

        <#else>

            <div class="empty-state">
                <h3>No active chats yet</h3>
                <p>When students contact you, their chats will appear here.</p>
            </div>

        </#if>

    </div>
</div>

</body>
</html>