<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registered Users</title>
</head>
<body>

<!-- Sidebar -->
<div style="width:220px;float:left;background:#0f2b4c;color:white;height:100vh;">
    <h3 style="padding:10px;">Website Name</h3>
    <ul style="list-style:none;padding:0;">
        <#--        <li><a href="/admin/dashboard" style="color:white;text-decoration:none;">Tutor Dashboard</a></li>-->
        <li><a href="/admin/workplace" style="color:white;text-decoration:none;">Go to Workplace</a></li>
        <li><a href="/admin/aptitude-results" style="color:white;text-decoration:none;">General Aptitude Results</a></li>
    </ul>

    <form action="/logout" method="post">
        <button type="submit" style="
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;">
            Logout
        </button>
    </form>
</div>

<h1>Registered Users</h1>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>

    <#list userTutor as user>
        <tr>
            <td>${user.id}</td>
            <td>${user.firstName} ${user.lastName}</td>
            <td>${user.email}</td>
            <td>${user.role}</td>
            <td>
                <form action="/admin/users/delete/${user.id}" method="post" style="display:inline;">
                    <input type="submit" value="Delete"
                           onclick="return confirm('Are you sure you want to delete this user?');"/>
                </form>
            </td>
        </tr>
    </#list>

</table>

<BR>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>

    <#list userStudent as user>
        <tr>
            <td>${user.id}</td>
            <td>${user.firstName} ${user.lastName}</td>
            <td>${user.email}</td>
            <td>${user.role}</td>
            <td>
                <form action="/admin/users/delete/${user.id}" method="post" style="display:inline;">
                    <input type="submit" value="Delete"
                           onclick="return confirm('Are you sure you want to delete this user?');"/>
                </form>
            </td>
        </tr>
    </#list>

</table>

<a href="/admin/dashboard">← Back to Dashboard</a>

</body>
</html>
