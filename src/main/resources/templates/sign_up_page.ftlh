<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Sign Up</title>
</head>
<body>
<form action="/signUp" method="post" enctype="multipart/form-data">
    <input name="firstName" type="text" placeholder="FIRSTNAME" required>
    <input name="lastName" type="text" placeholder="LASTNAME" required>

<#--    Choose the school-->
    <select name="schoolName" class="form-select" aria-label="Default select example">
        <option selected>School Name</option>
        <option value="1"> School One</option>
        <option value="2"> School Two</option>
        <option value="3"> School Three</option>
    </select>
<#--    Gender-->
    <label>
        <input type="radio" name="gender" value="FEMALE" required> Female
    </label>
    <label>
        <input type="radio" name="gender" value="MALE" required> Male
    </label>

    <#--    Role-->
    <label>
        <input type="radio" name="role" value="STUDENT" required> Student
    </label>
    <label>
        <input type="radio" name="role" value="TUTOR" required> Tutor
    </label>
<#--    To upload the ID card-->
    <div class="input-group mb-3">
        <input type="file" class="form-control" name="frontImage" required>
        <label class="input-group-text" for="inputGroupFile02">Upload Front Page</label>
    </div>

    <div class="input-group mb-3">
        <input type="file" class="form-control" name="backImage" required>
        <label class="input-group-text" for="inputGroupFile02">Upload Back Page</label>
    </div>

    <input name="email" type="email" placeholder="EMAIL" required>
    <input name="password" type="password" placeholder="PASSWORD" required>

    <input type="submit" value="REGISTER">
</form>
</body>
</html>