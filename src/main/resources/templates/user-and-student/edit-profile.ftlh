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
    <form id="changeFocusForm" method="post" action="/student/update-focus">
        <p>Change Study Focus:</p>

        <label>Choose Grade:</label><br>
        <select name="grade" required>
            <#list grades as g>
                <option value="${g}">${g}</option>
            </#list>
        </select>

        <p>Select Subjects:</p>
        <#list subjects as s>
            <label>
                <input type="checkbox" name="focusAreas" value="${s}"> ${s}
            </label>
        </#list>

        <br><br>
        <button type="submit">Update Focus</button>
    </form>

    <script>
        document.getElementById("changeFocusForm").addEventListener("submit", function(e) {
            const confirmed = confirm("Are you sure you want to change your study focus? This will reset your current study plan and aptitude test.");
            if (!confirmed) {
                e.preventDefault(); // stop form submission
            }
        });
    </script>
<#else>
    <p>You must complete your current study plan before changing your study focus.</p>
</#if>


</body>
</html>
