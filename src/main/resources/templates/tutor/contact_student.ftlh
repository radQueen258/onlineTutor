<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat with ${chatRoom.student.firstName}</title>

<#--    <link rel="stylesheet" href="/css/dashboard.css">-->

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>


    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

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

        /* MAIN CONTENT */
        main {
            flex: 1;
            padding: 60px 80px;
            overflow-y: auto;
            position: relative;
        }

        .main-content {
            margin-left: 300px;
        }

        .chat-container {
            max-width: 900px;
            margin: auto;
            background: white;
            border-radius: 16px;
            display: flex;
            flex-direction: column;
            height: 80vh;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }

        .chat-header {
            padding: 20px 24px;
            font-weight: 600;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 15px;
        }

        .chat-avatar {
            width: 40px;
            height: 40px;
            background: #113255;
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        .chat-subtitle {
            font-size: 13px;
            color: #666;
        }

        .chat-messages {
            flex: 1;
            padding: 26px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .chat-bubble {
            max-width: 65%;
            padding: 14px 18px;
            border-radius: 16px;
            display: flex;
            flex-direction: column;
            line-height: 1.4;
            animation: fadeIn 0.2s ease;
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
            padding: 18px 20px;
            border-top: 1px solid #eee;
            gap: 10px;
        }

        .chat-input input {
            flex: 1;
            padding: 13px 14px;
            border-radius: 12px;
            border: 1px solid #ddd;
            font-size: 14px;
            outline: none;
        }

        .chat-input input:focus {
            border-color: #113255;
        }

        .chat-input button {
            padding: 12px 20px;
            border-radius: 12px;
            border: none;
            background-color: #82613E;
            color: white;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.15s ease;
        }

        .chat-input button:hover {
            background-color: #6f5032;
            transform: translateY(-1px);
        }

        @keyframes fadeIn {
            from {opacity:0; transform: translateY(4px);}
            to {opacity:1; transform: translateY(0);}
        }
    </style>

</head>
<body>


<#-- UNIFIED SIDEBAR -->
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

<div class="main-content">

<div class="chat-container">

    <div class="chat-header">

        <div class="chat-avatar">
            ${chatRoom.student.firstName?substring(0,1)}
        </div>

        <div>
            <div>${chatRoom.subject}</div>
            <div class="chat-subtitle">
                Student: ${chatRoom.student.firstName}
            </div>
        </div>

    </div>

    <div id="messages" class="chat-messages">
        <#-- Render existing messages -->
        <#if chatRoom.messages?? && chatRoom.messages?size gt 0>
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
        <input type="text" id="messageInput" placeholder="Reply..." onkeypress="handleKey(event)">
        <button onclick="sendMessage()">Send</button>
    </div>

</div>

</div>

    </main>


<script>
    const currentUserId = ${currentUser.id};
    const chatRoomId = ${chatRoom.id};
    let stompClient = null;

    function connect() {
        const socket = new SockJS('/chat');
        stompClient = Stomp.over(socket);

        stompClient.subscribe('/topic/chat/' + chatRoomId, function(messageOutput) {
            const msg = JSON.parse(messageOutput.body);

            const messageDiv = document.createElement('div');
            messageDiv.className = msg.mine ? 'message-sent' : 'message-received';

            const contentSpan = document.createElement('span');
            contentSpan.className = 'msg-content';
            contentSpan.textContent = msg.content;

            const timeSpan = document.createElement('span');
            timeSpan.className = 'msg-time';
            timeSpan.textContent = msg.time;

            messageDiv.appendChild(contentSpan);
            messageDiv.appendChild(timeSpan);

            const messagesDiv = document.getElementById('messages');
            messagesDiv.appendChild(messageDiv);
            messagesDiv.scrollTop = messagesDiv.scrollHeight;
        });
    }

    function sendMessage() {
        const input = document.getElementById("messageInput");
        const content = input.value.trim();
        if(!content) return;

        const now = new Date();
        const timeString = now.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});

        // CREATE MESSAGE LOCALLY (instant display)
        const messageDiv = document.createElement('div');
        messageDiv.className = 'chat-bubble mine';

        const nameDiv = document.createElement('div');
        nameDiv.className = 'sender-name';
        nameDiv.textContent = "You";

        const contentDiv = document.createElement('div');
        contentDiv.className = 'bubble-content';
        contentDiv.textContent = content;

        const timeDiv = document.createElement('div');
        timeDiv.className = 'bubble-time';
        timeDiv.textContent = timeString;

        messageDiv.appendChild(nameDiv);
        messageDiv.appendChild(contentDiv);
        messageDiv.appendChild(timeDiv);

        const messagesDiv = document.getElementById('messages');
        messagesDiv.appendChild(messageDiv);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;

        // SEND TO SERVER
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


    window.onload = () => {
        const messagesDiv = document.getElementById('messages');
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    };
</script>

</body>
</html>