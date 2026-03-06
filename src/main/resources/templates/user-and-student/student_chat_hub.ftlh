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

        @media (max-width: 768px) {
            main {
                padding: 20px;
            }

            .card {
                width: 100%;
            }

            .page-title {
                font-size: 20px;
            }

            select {
                width: 100%;
                margin-bottom: 10px;
            }

            .empty-state {
                width: 100%;
                padding: 20px;
            }
        }

        /* HEADER */

        .page-header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:30px;
        }

        .page-title{
            font-size:26px;
            font-weight:700;
        }

        /* CHAT CARD */

        .chat-card{

            background:white;

            border-radius:14px;

            padding:20px;

            display:flex;

            align-items:center;

            gap:18px;

            margin-bottom:15px;

            box-shadow:0 6px 16px rgba(0,0,0,0.06);

            transition:all 0.25s ease;

        }

        .chat-card:hover{

            transform:translateY(-3px);

            box-shadow:0 12px 28px rgba(0,0,0,0.08);

        }

        /* ICON */

        .chat-icon{

            width:45px;
            height:45px;

            border-radius:10px;

            background:#0F3456;

            display:flex;

            align-items:center;

            justify-content:center;

            color:white;

            font-size:18px;

        }

        /* INFO */

        .chat-info{
            flex:1;
        }

        .chat-subject{
            font-weight:600;
            font-size:16px;
        }

        .chat-meta{
            font-size:13px;
            color:#666;
        }

        /* OPEN BUTTON */

        .chat-open{

            text-decoration:none;

            color:#2563eb;

            font-weight:600;

            display:flex;

            align-items:center;

            gap:6px;

        }

        .chat-open:hover{
            color:#1e40af;
        }

        /* NEW CHAT BUTTON */

        .new-chat-btn{
            display:flex;
            align-items:center;
            gap:6px;
        }

        .empty-icon{
            font-size:36px;
            color:#0F3456;
            margin-bottom:15px;
        }

        main{
            animation:fadeIn 0.35s ease;
        }

        @keyframes fadeIn{
            from{
                opacity:0;
                transform:translateY(10px);
            }
            to{
                opacity:1;
                transform:translateY(0);
            }
        }
    </style>
</head>

<body>

<!-- Hamburger button -->
<div class="hamburger-btn">&#9776;</div>

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

        <div class="page-header">
            <h1 class="page-title">Your Chats</h1>

            <form id="newChatForm" onsubmit="startChat(event)">

                <select id="subjectSelect">
                    <#list subjects as subject>
                        <option value="${subject}">${subject}</option>
                    </#list>
                </select>

                <button type="submit" class="btn btn-primary new-chat-btn">
                    <i class="fa-solid fa-plus"></i> New Chat
                </button>

            </form>
        </div>

        <#if chatRooms?? && chatRooms?size gt 0>

            <#list chatRooms as room>
                <div class="chat-card" data-subject="${room.subject}">

                    <div class="chat-icon">
                        <i class="fa-solid fa-graduation-cap"></i>
                    </div>

                    <div class="chat-info">
                        <div class="chat-subject">${room.subject}</div>
                        <div class="chat-meta">Chat with tutor</div>
                    </div>

                    <a href="/chat/student/${room.subject}" class="chat-open">
                        Open
                        <i class="fa-solid fa-arrow-right"></i>
                    </a>

                </div>
            </#list>

        <#else>

            <div class="empty-state">

                <i class="fa-solid fa-comments empty-icon"></i>

                <h3>No chats yet</h3>

                <p>Start a conversation with a tutor to get help.</p>

                <br>

            </div>

        </#if>

    </div>

    </main>


<script>
    function startChat() {
        event.preventDefault();

        const subject = document.getElementById("subjectSelect").value;
        window.location.href = "/chat/student/" + subject;
    }

    const hamburger = document.querySelector('.hamburger-btn');
    const sidebar = document.querySelector('aside');

    hamburger.addEventListener('click', () => {
        sidebar.classList.toggle('show');
    });


    document.addEventListener("DOMContentLoaded", function () {

        const existingSubjects = [];

        document.querySelectorAll(".chat-card").forEach(card => {
            existingSubjects.push(card.dataset.subject);
        });

        const select = document.getElementById("subjectSelect");

        Array.from(select.options).forEach(option => {

            if (existingSubjects.includes(option.value)) {
                option.disabled = true;
                option.textContent += " (already created)";
            }

        });

    });
</script>

</body>
</html>