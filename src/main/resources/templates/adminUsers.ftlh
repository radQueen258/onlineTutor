<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registered Users</title>
</head>
<body>

<h1>Registered Users</h1>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Username</th>
        <th>Email</th>
        <th>Role</th>
        <th>Actions</th>
    </tr>

    <#list users as user>
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
