<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Chats</title>
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
    </style>
</head>

<body>

<div class="dashboard-container">

    <div class="sidebar">
        <h2>Student Panel</h2>
        <a href="/student/dashboard">Dashboard</a>
        <a href="/chat/student">Chats</a>
        <a href="/logout">Logout</a>
    </div>

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
</div>

<script>
    function startChat() {
        const subject = document.getElementById("subjectSelect").value;
        window.location.href = "/chat/student/" + subject;
    }
</script>

</body>
</html>