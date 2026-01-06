<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>

    <script>
        function toggleRole(role) {
            document.getElementById("schoolBlock").style.display =
                role === 'STUDENT' ? 'block' : 'none';

            document.getElementById("subjectBlock").style.display =
                role === 'TUTOR' ? 'block' : 'none';
        }
    </script>
</head>
<body>

<form action="/signUp" method="post" enctype="multipart/form-data">

    <input name="firstName" type="text" placeholder="FIRST NAME" required>
    <input name="lastName" type="text" placeholder="LAST NAME" required>

    <!-- Gender -->
    <label>
        <input type="radio" name="gender" value="FEMALE" required> Female
    </label>
    <label>
        <input type="radio" name="gender" value="MALE" required> Male
    </label>

    <br><br>

    <!-- Role -->
    <label>
        <input type="radio" name="role" value="STUDENT"
               onclick="toggleRole('STUDENT')" required> Student
    </label>
    <label>
        <input type="radio" name="role" value="TUTOR"
               onclick="toggleRole('TUTOR')" required> Tutor
    </label>

    <br><br>

    <!-- School (STUDENT only) -->
    <div id="schoolBlock" style="display:none">
        <select name="schoolName" required>
            <option value="" disabled selected>School Name</option>
            <option value="School One">School One</option>
            <option value="School Two">School Two</option>
            <option value="School Three">School Three</option>
        </select>
    </div>

    <!-- Subject (TUTOR only) -->
    <div id="subjectBlock" style="display:none">
        <select name="preferredSubjects" required>
            <option value="" disabled selected>Subject you teach</option>
            <#list subjects as subject>
                <option value="${subject}">
                    ${subject}
                </option>
            </#list>
        </select>
    </div>

    <br><br>

    <!-- ID Upload -->
    <div>
        <input type="file" name="frontImage" required>
        <label>Upload ID – Front</label>
    </div>

    <div>
        <input type="file" name="backImage" required>
        <label>Upload ID – Back</label>
    </div>

    <br>

    <input name="email" type="email" placeholder="EMAIL" required>
    <input name="password" type="password" placeholder="PASSWORD" required>

    <br><br>

    <input type="submit" value="REGISTER">

</form>

</body>
</html>
