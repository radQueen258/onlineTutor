<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Teacher Chats</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>


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
        .nav-item {
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
            gap: 8px;
        }

        .nav-item.active {
            background-color: #82613E;
            margin-right: 15px;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
            gap: 8px;
        }

        .nav-item a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-item:hover {
            background-color: #8b6b45;
            border-radius: 10px;
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

        /* MAIN */

        main {
            flex-grow: 1;
            margin-left: 280px;
            padding: 50px 70px;
        }

        .page-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 35px;
        }

        /* CHAT CARD */

        .chat-card {
            background: white;
            border-radius: 14px;
            padding: 22px 26px;
            margin-bottom: 18px;

            display: flex;
            justify-content: space-between;
            align-items: center;

            box-shadow: 0 6px 16px rgba(0,0,0,0.05);

            transition: 0.25s;
        }

        .chat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 22px rgba(0,0,0,0.08);
        }

        /* LEFT SIDE */

        .chat-info {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .chat-subject {
            font-size: 18px;
            font-weight: 600;
        }

        .chat-student {
            font-size: 14px;
            color: #6b7280;
        }

        /* STATUS */

        .chat-status {
            font-size: 13px;
            color: #16a34a;
            font-weight: 500;
        }

        /* OPEN BUTTON */

        .open-chat {
            background: #2563eb;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: 0.2s;
        }

        .open-chat:hover {
            background: #1e40af;
        }

        /* EMPTY STATE */

        .empty-state {
            background: white;
            padding: 60px;
            border-radius: 14px;
            text-align: center;
            box-shadow: 0 6px 16px rgba(0,0,0,0.05);
        }

        .empty-state h3 {
            font-size: 20px;
            margin-bottom: 10px;
        }

        .empty-state p {
            color: #6b7280;
        }

    </style>
</head>

<body>

<aside class="sidebar">
    <div class="sidebar-brand">Online Tutor</div>
    <ul class="nav-menu">
        <li class="nav-item">
            <a href="/tutor/workplace">
                <i class="fa-solid fa-briefcase"></i>
                Workplace
            </a>
        </li>

        <li class="nav-item">
            <a href="/tutor/analytics">
                <i class="fa-solid fa-chart-line"></i>
                View Analytics
            </a>
        </li>

        <li class="nav-item active">
            <a href="/chat/teacher">
                <i class="fa-solid fa-comments"></i>
                Help a Student
            </a>
        </li>
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

                <div class="chat-card">

                    <div class="chat-info">

                        <div class="chat-subject">
                            ${room.subject}
                        </div>

                        <div class="chat-student">
                            Student: ${room.student.firstName} ${room.student.lastName}
                        </div>

                        <div class="chat-status">
                            Active chat
                        </div>

                    </div>

                    <a class="open-chat" href="/chat/teacher/room/${room.id}">
                        Open Chat
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