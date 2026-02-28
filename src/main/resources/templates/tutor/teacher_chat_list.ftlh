<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Chats</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">

    <style>

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }

        body {
            background-color: #f0f4f9;
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
            position: relative;
        }

        /* Sidebar */
        aside.sidebar {
            width: 280px;
            background-color: #113255;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            position: fixed;
            height: 100vh;
            left: 0;
            top: 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            z-index: 100;
        }

        .sidebar-brand { padding: 0 30px; font-size: 18px; font-weight: 700; margin-bottom: 60px; }

        .nav-menu { list-style: none; flex-grow: 1; }
        .nav-item { padding: 15px 30px; font-size: 16px; font-weight: 500; margin-bottom: 10px; cursor: pointer; gap: 8px;}
        .nav-item a { color: white; text-decoration: none; gap: 8px;}
        .nav-item:hover { background-color: #8b6b45; border-radius: 10px; }

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

        .dashboard-container {
            display: flex;
            min-height: 100vh;
        }

        main {
            flex-grow: 1;
            margin-left: 280px;
            padding: 40px 60px;
            position: relative;
            max-width: 1200px;
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

<aside class="sidebar">
    <div class="sidebar-brand">Website Name</div>
    <ul class="nav-menu">
        <li class="nav-item"><a href="/tutor/workplace">Workplace</a></li>
        <li class="nav-item"><a href="/tutor/analytics">View Analytics</a></li>
        <li class="nav-item active"><a href="/chat/teacher">Help a Student</a></li>
    </ul>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/tutor/profile" class="profile-link">Profile</a>
    </div>
</aside>

<main>
<div class="dashboard-container">

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
</main>

</body>
</html>