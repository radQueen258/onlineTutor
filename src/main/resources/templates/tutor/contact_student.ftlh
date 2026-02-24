<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat with ${chatRoom.student.firstName}</title>

    <link rel="stylesheet" href="/css/dashboard.css">

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background-color: #f3f4f6;
        }

        .main-content {
            margin-left: 260px;
            padding: 40px;
        }

        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            width: 260px;
            height: 100vh;
            background-color: #0F3456;
            color: white;
            display: flex;
            flex-direction: column;
            padding-top: 40px;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
        }

        /* Brand */
        .brand {
            padding: 0 30px;
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 40px;
        }

        /* Nav */
        .nav-menu {
            display: flex;
            flex-direction: column;
        }

        .nav-item {
            padding: 14px 30px;
            text-decoration: none;
            color: white;
            font-size: 15px;
            transition: 0.2s ease;
        }

        .nav-item:hover {
            background-color: rgba(255,255,255,0.08);
            padding-left: 36px;
        }

        .nav-item.active {
            background-color: #82613E;
            font-weight: 600;
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
            padding: 20px;
            font-weight: 600;
            border-bottom: 1px solid #eee;
        }

        .chat-messages {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 14px;
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
            padding: 15px;
            border-top: 1px solid #eee;
        }

        .chat-input input {
            flex: 1;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        .chat-input button {
            margin-left: 10px;
            padding: 12px 18px;
            border-radius: 10px;
            border: none;
            background-color: #82613E;
            color: white;
            cursor: pointer;
            font-weight: 600;
        }

        .chat-input button:hover {
            background-color: #6f5032;
        }
    </style>

</head>
<body>


<#-- UNIFIED SIDEBAR -->
<aside class="sidebar">

    <div class="brand">Website Name</div>

    <nav class="nav-menu">

        <#if currentUser.role?string == "STUDENT">
            <a href="/dashboard" class="nav-item">Dashboard</a>
            <a href="/study-plan" class="nav-item">Study Plan</a>
            <a href="/resources" class="nav-item">Resources</a>
            <a href="/chat/student" class="nav-item active">Contact a Tutor</a>
        </#if>

        <#if currentUser.role?string == "TUTOR">
            <a href="/tutor/workplace" class="nav-item">Workplace</a>
            <a href="/chat/teacher" class="nav-item active">Help a Student</a>
        </#if>

    </nav>

</aside>

<div class="main-content">

<div class="chat-container">

    <div class="chat-header">
        ${chatRoom.subject} - Student: ${chatRoom.student.firstName}
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
</script>

</body>
</html>