<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Teacher - ${chatRoom.subject}</title>

    <link rel="stylesheet" href="/css/dashboard.css">

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>

    <style>
        .chat-container {
            width: 100%;
            max-width: 900px;
            margin: 40px auto;
            background: #ffffff;
            border-radius: 12px;
            display: flex;
            flex-direction: column;
            height: 70vh;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }

        .chat-header {
            padding: 15px 20px;
            background: #1f2937;
            color: white;
            font-weight: bold;
            border-top-left-radius: 12px;
            border-top-right-radius: 12px;
        }

        .chat-messages {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            background: #f9fafb;
        }

        .message {
            margin-bottom: 15px;
            padding: 10px 14px;
            border-radius: 8px;
            max-width: 70%;
        }

        .student {
            background: #2563eb;
            color: white;
            margin-left: auto;
        }

        .teacher {
            background: #e5e7eb;
            color: black;
        }

        .chat-input {
            display: flex;
            padding: 15px;
            border-top: 1px solid #ddd;
        }

        .chat-input input {
            flex: 1;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }

        .chat-input button {
            margin-left: 10px;
            padding: 10px 18px;
            border-radius: 8px;
            border: none;
            background: #2563eb;
            color: white;
            cursor: pointer;
        }

        .typing {
            font-size: 12px;
            color: gray;
            padding-left: 20px;
        }
    </style>
</head>
<body>

<div class="chat-container">

    <div class="chat-header">
        Chat with ${chatRoom.subject} Teachers
    </div>

    <div id="messages" class="chat-messages">
        <#if chatRoom.messages?? && chatRoom.messages?size gt 0>
        <#list chatRoom.messages as msg>
            <div class="message
                <#if msg.sender.id == currentUser.id>student<#else>tutor</#if>">
                ${msg.sender.firstName}: ${msg.content}
            </div>
        </#list>
        </#if>
    </div>

    <div class="typing" id="typingIndicator"></div>

    <div class="chat-input">
        <input type="text" id="messageInput" placeholder="Type your message..."
               onkeypress="handleKey(event)">
        <button onclick="sendMessage()">Send</button>
    </div>

</div>

<script>
    let stompClient = null;
    const chatRoomId = ${chatRoom.id};

    function connect() {
        const socket = new SockJS('/chat');
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function () {

            stompClient.subscribe('/topic/chat/' + chatRoomId, function (message) {
                const msg = JSON.parse(message.body);
                showMessage(msg);
            });

        });
    }

    function showMessage(msg) {
        const messagesDiv = document.getElementById("messages");
        const div = document.createElement("div");

        const isCurrentUser = msg.sender.id === ${currentUser.id};

        div.classList.add("message");
        div.classList.add(isCurrentUser ? "student" : "teacher");

        div.innerHTML = msg.sender.firstName + ": " + msg.content;

        messagesDiv.appendChild(div);
        messagesDiv.scrollTop = messagesDiv.scrollHeight;
    }

    function sendMessage() {
        const input = document.getElementById("messageInput");
        const content = input.value.trim();

        if (content === "") return;

        stompClient.send("/app/chat.send", {}, JSON.stringify({
            chatRoomId: chatRoomId,
            content: content
        }));

        input.value = "";
    }

    function handleKey(event) {
        if (event.key === "Enter") {
            sendMessage();
        }
    }

    connect();
</script>

</body>
</html>