<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chat with ${chatRoom.student.firstName}</title>

    <link rel="stylesheet" href="/css/dashboard.css">

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>

</head>
<body>

<div class="chat-container">

    <div class="chat-header">
        ${chatRoom.subject} - Student: ${chatRoom.student.firstName}
    </div>

    <div id="messages" class="chat-messages">
        <#list chatRoom.messages as msg>
            <div class="message
                <#if msg.sender.id == currentUser.id>teacher<#else>student</#if>">
                ${msg.sender.firstName}: ${msg.content}
            </div>
        </#list>
    </div>

    <div class="chat-input">
        <input type="text" id="messageInput" placeholder="Reply..."
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
        div.classList.add(isCurrentUser ? "teacher" : "student");

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

    stompClient.subscribe('/topic/chat/' + chatRoomId, function(messageOutput) {
        const msg = JSON.parse(messageOutput.body);

        // Create a message element
        const messageDiv = document.createElement('div');
        messageDiv.className = msg.mine ? 'message-sent' : 'message-received';

        // Show content + time
        const timeString = new Date(msg.timestamp).toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        messageDiv.innerHTML = `<span class="msg-content">${msg.content}</span>
                            <span class="msg-time">${timeString}</span>`;

        document.getElementById('chatMessages').appendChild(messageDiv);

        // Scroll to bottom
        document.getElementById('chatMessages').scrollTop = document.getElementById('chatMessages').scrollHeight;
    });
</script>

</body>
</html>