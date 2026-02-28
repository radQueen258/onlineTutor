<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Chats</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>

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

        /* MAIN CONTENT */
        main {
            flex: 1;
            padding: 60px 80px;
            overflow-y: auto;
            position: relative;
        }

        .main-content {
            flex: 1;
            /*padding: 40px;*/
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
        }

        .btn {
            padding: 10px 16px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 500;
        }

        .btn-primary {
            background-color: #2563eb;
            color: white;
        }

        .btn-primary:hover {
            background-color: #1e40af;
        }

        select {
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-right: 10px;
        }

        .empty-state {
            background: white;
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
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

<#--<m class="dashboard-container">-->

    <!-- SIDEBAR -->
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

            <a href="/chat/student" class="nav-item active">
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

    <div class="main-content">

        <div class="page-title">Your Chats</div>

        <#if chatRooms?? && chatRooms?size gt 0>

            <#list chatRooms as room>
                <div class="card">
                    <strong>${room.subject}</strong><br>
                    <a href="/chat/student/${room.subject}">
                        Open Chat →
                    </a>
                </div>
            </#list>

        <#else>

            <div class="empty-state">
                <h3>No chats yet</h3>
                <p>You can start a new conversation with a teacher.</p>

                <br>

                <form id="newChatForm">
                    <select id="subjectSelect">
                        <#list subjects as subject>
                            <option value="${subject}">${subject}</option>
                        </#list>
                    </select>

                    <button type="button" class="btn btn-primary" onclick="startChat()">
                        Start New Chat
                    </button>
                </form>
            </div>

        </#if>

    </div>

    </main>


<script>
    function startChat() {
        const subject = document.getElementById("subjectSelect").value;
        window.location.href = "/chat/student/" + subject;
    }
</script>

</body>
</html>