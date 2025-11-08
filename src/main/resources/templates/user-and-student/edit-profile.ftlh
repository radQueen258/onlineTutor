<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
</head>
<body>

<h2>Edit Profile</h2>
<p>User: ${user.firstName}</p>

<form method="post" action="/student/update-password">
    <label>New Password:</label>
    <input type="password" name="newPassword" required>
    <button type="submit">Change Password</button>
</form>

<#if canChangeFocus>
    <form method="post" action="/student/update-focus">
        <p>Change Study Focus:</p>
        <label>
            <input type="checkbox" name="focusAreas" value="Math"> Math
        </label>
        <label>
            <input type="checkbox" name="focusAreas" value="Physics"> Physics
        </label>
        <label>
            <input type="checkbox" name="focusAreas" value="Chemistry"> Chemistry
        </label>
        <br>
        <button type="submit">Update Focus</button>
    </form>
<#else>
    <p>You must complete your current study plan before changing your study focus.</p>
</#if>

</body>
</html>
