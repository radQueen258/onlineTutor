<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Teacher - ${chatRoom.subject}</title>

    <link rel="stylesheet" href="/css/dashboard.css">

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>
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

        /* Hide sidebar on mobile by default */
        @media (max-width: 768px) {
            aside {
                position: fixed;
                left: -280px; /* hide it initially */
                top: 0;
                height: 100%;
                z-index: 1000;
                transition: 0.3s ease;
            }

            aside.show {
                left: 0; /* slide in */
            }

            main {
                margin-left: 0 !important;
                transition: 0.3s ease;
            }
        }

        /* MAIN CONTENT */
        main {
            flex: 1;
            padding: 60px 80px;
            overflow-y: auto;
            position: relative;
        }

        .chat-container {
            max-width: 900px;
            margin: auto;
            background: white;
            border-radius: 18px;
            display: flex;
            flex-direction: column;
            height: 80vh;
            box-shadow: 0 12px 30px rgba(0,0,0,0.08);
            overflow: hidden;
        }

        .chat-header {
            padding: 20px 24px;
            font-weight: 600;
            font-size: 16px;
            border-bottom: 1px solid #eee;
            background: #fafbfd;
        }

        .chat-messages {
            flex: 1;
            padding: 24px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 14px;
            background: #f8fafc;
        }

        .chat-bubble {
            max-width: 70%;
            padding: 14px 16px;
            border-radius: 16px;
            display: flex;
            flex-direction: column;
        }

        /* My messages */
        .chat-bubble.mine {
            align-self: flex-end;
            background-color: #0F3456;
            color: white;
            border-bottom-right-radius: 4px;
        }

        /* Other user */
        .chat-bubble.theirs {
            align-self: flex-start;
            background-color: #e5e7eb;
            color: #333;
            border-bottom-left-radius: 4px;
        }

        .sender-name {
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .bubble-content {
            font-size: 14px;
        }

        .bubble-time {
            font-size: 11px;
            margin-top: 6px;
            opacity: 0.7;
            align-self: flex-end;
        }

        .chat-input {
            display: flex;
            padding: 16px;
            border-top: 1px solid #eee;
            background: white;
        }

        .chat-input input {
            flex: 1;
            padding: 12px 14px;
            border-radius: 12px;
            border: 1px solid #ddd;
            font-size: 14px;
            outline: none;
            transition: border 0.2s ease;
        }

        .chat-input input:focus {
            border-color: #82613E;
        }

        .chat-input button {
            margin-left: 10px;
            padding: 12px 20px;
            border-radius: 12px;
            border: none;
            background-color: #82613E;
            color: white;
            cursor: pointer;
            font-weight: 600;
            transition: 0.2s;
        }

        .chat-input button:hover {
            background-color: #6f5032;
            transform: translateY(-1px);
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

        /* Make chat container responsive */
        @media (max-width: 1024px) {
            .chat-container {
                width: 90%;
                margin: 0 auto;
            }

            .chat-input input {
                width: 80%;
            }

            .chat-input button {
                width: 18%;
            }
        }

        @media (max-width: 600px) {
            .chat-container {
                width: 100%;
                height: 70vh;
            }

            .chat-input {
                flex-direction: column;
                gap: 8px;
            }

            .chat-input input, .chat-input button {
                width: 100%;
            }
        }

        @media (max-width: 768px) {
            aside {
                width: 280px; /* full width when shown */
                left: -280px; /* hidden by default */
                top: 0;
                height: 100%;
                padding: 40px 20px; /* make room inside */
                background-color: #0F3456; /* ensure blue background */
                border-top-right-radius: 20px;
                border-bottom-right-radius: 20px;
                transition: 0.3s ease;
                z-index: 1000;
            }

            aside.show {
                left: 0;
            }

            .brand,
            .nav-item span {
                display: inline; /* show letters */
            }

            main {
                margin-left: 0 !important;
                padding: 20px;
                transition: 0.3s ease;
            }
        }



        /* Optional: Hamburger toggle button */
        .hamburger-btn {
            display: none;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1100;
            font-size: 24px;
            cursor: pointer;
            background: #0F3456;
            color: white;
            padding: 10px 12px;
            border-radius: 8px;
        }

        @media (max-width:768px) {
            .hamburger-btn {
                display: block;
            }
        }
    </style>

</head>
<body>

<!-- Hamburger Button -->
<div class="hamburger-btn" onclick="toggleSidebar()">
    <i class="fas fa-bars"></i>
</div>


<#-- UNIFIED SIDEBAR -->

<aside>
    <div class="brand">Website Name</div>

    <nav>
        <#if currentUser.role?string == "STUDENT">
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
        </#if>

        <#if currentUser.role?string == "TUTOR">
            <a href="/tutor/workplace" class="nav-item">
                <i class="fa-solid fa-briefcase"></i> Workplace
            </a>

            <a href="/chat/teacher" class="nav-item active">
                <i class="fa-solid fa-comments"></i> Help a Student
            </a>
        </#if>
    </nav>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/profile" class="profile-link">Profile</a>
    </div>
</aside>

<main>

<div class="chat-container">

    <div class="chat-header">
        Chat with ${chatRoom.subject} Teachers
    </div>

    <div id="messages" class="chat-messages">
        <#-- Render existing messages -->
        <#if messages?? && messages?size gt 0>
            <#list messages as msg>
                <div class="chat-bubble ${msg.mine?then('mine','theirs')}">
                    <div class="sender-name">${msg.senderName}</div>
                    <div class="bubble-content">${msg.content}</div>
                    <div class="bubble-time">${msg.time}</div>
                </div>
            </#list>
        </#if>
    </div>

    <div class="chat-input">
        <input type="text" id="messageInput" placeholder="Type your message..." onkeypress="handleKey(event)">
        <button onclick="sendMessage()">Send</button>
    </div>

</div>
</main>

<script>
    const currentUserId = ${currentUser.id};
    const chatRoomId = ${chatRoom.id};
    let stompClient = null;
    let lastSentMessage = null;

    function connect() {
        const socket = new SockJS('/chat');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function() {

            stompClient.subscribe('/topic/chat/' + chatRoomId, function(messageOutput) {
                const msg = JSON.parse(messageOutput.body);

                // Ignore duplicate of last sent message
                if(msg.mine && msg.content === lastSentMessage) {
                    lastSentMessage = null; // reset tracker
                    return;
                }

                renderMessage(msg.senderName, msg.content, msg.time, msg.mine);
            });

        });
    }

    // Function to render a message in the chat container
    function renderMessage(senderName, content, time, mine) {
        const messageDiv = document.createElement('div');
        messageDiv.className = 'chat-bubble ' + (mine ? 'mine' : 'theirs');

        const nameDiv = document.createElement('div');
        nameDiv.className = 'sender-name';
        nameDiv.textContent = senderName;

        const contentDiv = document.createElement('div');
        contentDiv.className = 'bubble-content';
        contentDiv.textContent = content;

        const timeDiv = document.createElement('div');
        timeDiv.className = 'bubble-time';
        timeDiv.textContent = time;

        messageDiv.appendChild(nameDiv);
        messageDiv.appendChild(contentDiv);
        messageDiv.appendChild(timeDiv);

        const messagesDiv = document.getElementById('messages');
        messagesDiv.appendChild(messageDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }

    function sendMessage() {
        const input = document.getElementById("messageInput");
        const content = input.value.trim();
        if(!content) return;

        const now = new Date();
        const timeString = now.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});

        // Render locally instantly
        renderMessage("You", content, timeString, true);

        // Track this message to avoid duplicate when server echoes it
        lastSentMessage = content;

        // Send to server
        stompClient.send("/app/chat.send", {}, JSON.stringify({
            chatRoomId: chatRoomId,
            content: content
        }));

        input.value = "";
    }

    function handleKey(event) {
        if(event.key === "Enter") sendMessage();
    }

    connect();

    // Scroll to bottom on load
    window.onload = function() {
        const messagesDiv = document.getElementById('messages');
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    };

    function toggleSidebar() {
        const sidebar = document.querySelector('aside');
        sidebar.classList.toggle('show');
    }
</script>
</body>
</html>