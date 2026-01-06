<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>

    <script>
        function toggleRole(role) {
            const school = document.getElementById("schoolBlock");
            const subject = document.getElementById("subjectBlock");

            const schoolSelect = school.querySelector("select");
            const subjectSelect = subject.querySelector("select");

            if (role === 'STUDENT') {
                school.style.display = 'block';
                schoolSelect.disabled = false;

                subject.style.display = 'none';
                subjectSelect.disabled = true;
                subjectSelect.value = "";
            }

            if (role === 'TUTOR') {
                subject.style.display = 'block';
                subjectSelect.disabled = false;

                school.style.display = 'none';
                schoolSelect.disabled = true;
                schoolSelect.value = "";
            }
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
        <select name="schoolName">
            <option value="" disabled selected>School Name</option>
            <option value="School One">School One</option>
            <option value="School Two">School Two</option>
            <option value="School Three">School Three</option>
        </select>
    </div>

    <!-- Subject (TUTOR only) -->
    <div id="subjectBlock" style="display:none">
        <select name="preferredSubjects">
            <option value="" disabled selected>Subject you teach</option>
            <#list subjects as subject>
                <option value="${subject}">
                    ${subject}
                </option>
            </#list>
        </select>
    </div>

    <br><br>

    <#-- To upload the ID card-->
    <div class="input-group mb-3">
        <input type="file" class="form-control" name="frontImage" required>
        <label class="input-group-text" for="inputGroupFile02">Upload Front Page</label>
    </div>
    <div class="input-group mb-3">
        <input type="file" class="form-control" name="backImage" required>
        <label class="input-group-text" for="inputGroupFile02">Upload Back Page</label>
    </div>

    <br>

    <input name="email" type="email" placeholder="EMAIL" required>
    <input name="password" type="password" placeholder="PASSWORD" required>

    <br><br>

    <input type="submit" value="REGISTER">

</form>

</body>
</html>
