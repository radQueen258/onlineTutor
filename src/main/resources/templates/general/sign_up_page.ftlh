<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration - ONLINE TUTOR</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:ital,wght@1,600&display=swap');

        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            background-color: #ffffff;
            color: #000000;
            overflow-x: hidden;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
        }

        .bg-circle {
            position: absolute;
            border-radius: 50%;
            filter: blur(40px);
            z-index: -1;
            opacity: 0.6;
        }
        .circle-purple { width: 150px; height: 150px; background-color: #a29bfe; top: 10%; left: 5%; }
        .circle-red { width: 120px; height: 120px; background-color: #ff4d4d; top: 20%; left: 40%; }
        .circle-green { width: 60px; height: 60px; background-color: #2ecc71; top: 45%; left: 18%; }
        .circle-orange { width: 180px; height: 180px; background-color: #f39c12; bottom: 10%; left: 5%; }
        .circle-yellow { width: 80px; height: 80px; background-color: #f1c40f; bottom: 30%; left: 30%; }
        .circle-blue { width: 70px; height: 70px; background-color: #3498db; bottom: 10%; left: 32%; }

        header {
            display: flex;
            justify-content: center;
            padding: 20px;
        }

        .nav-bar {
            background-color: #f4d03f;
            display: flex;
            align-items: center;
            padding: 8px 30px;
            border-radius: 50px;
            gap: 40px;
        }

        .nav-links {
            display: flex;
            gap: 30px;
        }

        .nav-links a {
            text-decoration: none;
            color: #000;
            font-weight: 600;
            font-size: 16px;
        }

        .nav-buttons {
            display: flex;
            gap: 15px;
        }

        .btn-login {
            background-color: #0d3b66;
            color: #fff;
            border: none;
            padding: 10px 30px;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            font-size: 16px;
        }

        .btn-register-nav {
            background-color: #fff;
            color: #000;
            border: none;
            padding: 10px 30px;
            border-radius: 25px;
            font-weight: 600;
            cursor: pointer;
            font-size: 16px;
        }

        .globe-icon-container {
            position: absolute;
            right: 50px;
            width: 45px;
            height: 45px;
            border: 2px solid #f08c2d;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #000;
            font-size: 18px;
            cursor: pointer;
        }

        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 10%;
            gap: 100px;
        }

        .hero-text {
            font-family: 'Playfair Display', serif;
            font-style: italic;
            font-size: 42px;
            font-weight: 600;
            white-space: nowrap;
        }

        .registration-form {
            width: 100%;
            max-width: 500px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .form-row {
            display: flex;
            gap: 20px;
        }

        .input-group {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            padding: 12px 15px;
            border: 2px solid #000;
            font-size: 16px;
            outline: none;
            width: 100%;
            box-sizing: border-box;
        }

        .radio-group-container {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 18px;
            font-weight: 500;
        }

        .radio-options {
            display: flex;
            gap: 30px;
        }

        .radio-option {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
        }

        .radio-option input[type="radio"] {
            appearance: none;
            width: 18px;
            height: 18px;
            border: 2px solid #000;
            border-radius: 50%;
            cursor: pointer;
            position: relative;
        }

        .radio-option input[type="radio"]:checked::after {
            content: "";
            width: 10px;
            height: 10px;
            background-color: #000;
            border-radius: 50%;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .file-upload {
            position: relative;
        }

        .btn-register-form {
            background-color: #fff;
            color: #000;
            border: 3px solid #000;
            padding: 10px 40px;
            font-weight: 700;
            font-size: 18px;
            cursor: pointer;
            box-shadow: 0 0 15px rgba(0,0,0,0.3);
        }

        footer {
            padding: 40px 10%;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            font-size: 14px;
            line-height: 1.8;
        }

        .footer-left, .footer-right {
            display: flex;
            flex-direction: column;
        }

        .footer-right {
            text-align: right;
        }
    </style>

    <script>
        function toggleRole(role) {
            const school = document.getElementById("schoolBlock");
            const subject = document.getElementById("subjectBlock");

            if (role === 'STUDENT') {
                school.style.display = 'block';
                subject.style.display = 'none';
            } else {
                subject.style.display = 'block';
                school.style.display = 'none';
            }
        }
    </script>
</head>

<body>

<div class="bg-circle circle-purple"></div>
<div class="bg-circle circle-red"></div>
<div class="bg-circle circle-green"></div>
<div class="bg-circle circle-orange"></div>
<div class="bg-circle circle-yellow"></div>
<div class="bg-circle circle-blue"></div>

<!-- ===== NAVBAR ===== -->
<header>
    <nav class="nav-bar">
        <div class="nav-links">
            <a href="/">Home</a>
            <a href="/about">About</a>
            <a href="/features">Features</a>
            <a href="/contact">Contact Us</a>
        </div>
        <div class="nav-buttons">
            <a href="/signIn"><button class="btn-login">Login</button></a>
            <a href="/signUp"><button class="btn-register-nav">Register</button></a>
        </div>
    </nav>

    <div class="globe-icon-container">
        <i class="fa-solid fa-globe"></i>
    </div>
</header>

<main>
    <div class="hero-text">One Step Away...</div>

    <form class="registration-form"
          action="/signUp"
          method="post"
          enctype="multipart/form-data">

        <!-- Names -->
        <div class="form-row">
            <input name="firstName" type="text" placeholder="First Name*" required>
            <input name="lastName" type="text" placeholder="Last Name*" required>
        </div>

        <!-- Role -->
        <div class="radio-group-container">
            <span>Role:</span>
            <div class="radio-options">
                <label class="radio-option">
                    <input type="radio" name="role" value="STUDENT"
                           onclick="toggleRole('STUDENT')" required>
                    <span>Student</span>
                </label>
                <label class="radio-option">
                    <input type="radio" name="role" value="TUTOR"
                           onclick="toggleRole('TUTOR')" required>
                    <span>Tutor</span>
                </label>
            </div>
        </div>

        <div id="schoolBlock">
            <select name="schoolId" required>
                <option value="" disabled selected>Choose your school</option>
                <#list schools as school>
                    <option value="${school.id?c}">${school.name}</option>
                </#list>
            </select>
        </div>

        <!-- Subjects -->
        <div id="subjectBlock" style="display:none">
            <select name="preferredSubjects">
                <option value="" disabled selected>Subject you teach</option>
                <#list subjects as subject>
                    <option value="${subject}">${subject}</option>
                </#list>
            </select>
        </div>

        <!-- Gender -->
        <div class="radio-group-container">
            <span>Gender:</span>
            <div class="radio-options">
                <label class="radio-option">
                    <input type="radio" name="gender" value="FEMALE" required>
                    <span>Female</span>
                </label>
                <label class="radio-option">
                    <input type="radio" name="gender" value="MALE" required>
                    <span>Male</span>
                </label>
            </div>
        </div>

        <!-- Files -->
        <div class="input-group file-upload">
        <input type="file" name="frontImage" required>
        </div>

        <div class="input-group file-upload">
        <input type="file" name="backImage" required>
        </div>

        <!-- Auth -->
        <div class="input-group">
        <input name="email" type="email" placeholder="Email*" required>
        </div>

        <div class="input-group">
        <input name="password" type="password" placeholder="Password*" required>
        </div>

        <button type="submit" class="btn-register-form">Register</button>
    </form>
</main>

<!-- ===== FOOTER ===== -->
<footer>
    <div class="footer-left">
        <div>APPNAME---</div>
        <div>Smarter prep. Better results.</div>
        <div>© 2025 APPNAME. All rights reserved.</div>
    </div>
    <div class="footer-right">
        <div>Home | About | Features | Register</div>
        <div>Become a Tutor</div>
        <div>support@appname.com</div>
    </div>
</footer>

</body>
</html>
