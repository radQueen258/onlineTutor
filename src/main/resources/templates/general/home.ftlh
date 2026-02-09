<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Educational Platform UI</title>
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f0f4f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            overflow-x: hidden;
            position: relative;
        }

        /* Background Decorative Circles */
        .bg-circle {
            position: absolute;
            border-radius: 50%;
            z-index: -1;
            opacity: 0.6;
        }

        /* Positioning circles based on visual */
        .circle-1 { width: 30px; height: 30px; background-color: #b2d8c5; top: 220px; left: 45px; }
        .circle-2 { width: 25px; height: 25px; background-color: #a8d8e0; top: 265px; left: 220px; }
        .circle-3 { width: 22px; height: 22px; background-color: #f9e8b3; top: 190px; left: 350px; }
        .circle-4 { width: 18px; height: 18px; background-color: #a8d8e0; top: 195px; left: 490px; }
        .circle-5 { width: 25px; height: 25px; background-color: #f9e8b3; top: 240px; left: 525px; }
        .circle-6 { width: 15px; height: 15px; background-color: #a8d8e0; top: 240px; left: 665px; }
        .circle-7 { width: 25px; height: 25px; background-color: #b2d8c5; top: 410px; left: 570px; }
        .circle-8 { width: 25px; height: 25px; background-color: #f9d8b3; top: 535px; left: 620px; }
        .circle-9 { width: 15px; height: 15px; background-color: #b2d8c5; top: 755px; left: 495px; }
        .circle-10 { width: 30px; height: 30px; background-color: #a8d8e0; top: 835px; left: 535px; }
        .circle-11 { width: 15px; height: 15px; background-color: #f9e8b3; top: 890px; left: 415px; }
        .circle-12 { width: 18px; height: 18px; background-color: #f9e8b3; top: 935px; left: 590px; }
        .circle-13 { width: 25px; height: 25px; background-color: #a8d8e0; top: 785px; left: 360px; }
        .circle-14 { width: 20px; height: 20px; background-color: #7a8fa1; top: 780px; left: 410px; }
        .circle-15 { width: 18px; height: 18px; background-color: #a8d8e0; top: 915px; left: 275px; }
        .circle-16 { width: 15px; height: 15px; background-color: #a8d8e0; top: 870px; left: 100px; }
        .circle-17 { width: 22px; height: 22px; background-color: #b2d8c5; top: 690px; left: 35px; }

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
            background-color: #e67e22;
            color: #fff;
            padding: 10px 35px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            font-size: 16px;
        }

        /*.btn-register {*/
        /*    background-color: #f08c2d;*/
        /*    color: #fff;*/
        /*}*/

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
            width: 100%;
            max-width: 1200px;
            margin-top: 80px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 50px;
            position: relative;
        }

        .hero-card {
            background-color: #fff;
            padding: 60px 50px;
            border-radius: 40px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.1);
            width: 480px;
            text-align: center;
            z-index: 10;
        }

        .hero-card h1 {
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 10px;
            color: #000;
        }

        .hero-card h2 {
            font-size: 42px;
            font-weight: 800;
            margin-bottom: 35px;
            color: #000;
            letter-spacing: 1px;
        }

        .hero-card p {
            font-size: 18px;
            color: #333;
            line-height: 1.4;
            margin-bottom: 40px;
            font-weight: 400;
        }

        .hero-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
        }

        .hero-btn {
            padding: 15px 25px;
            border-radius: 12px;
            border: none;
            font-weight: 700;
            font-size: 16px;
            cursor: pointer;
            min-width: 160px;
        }

        .btn-tutor {
            background-color: #f08c2d;
            color: #fff;
        }

        .btn-study {
            background-color: #0a304e;
            color: #fff;
        }

        .image-grid {
            display: flex;
            gap: 25px;
            align-items: flex-start;
            height: 650px;
        }

        .image-pill {
            width: 120px;
            border-radius: 100px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        .pill-1 {
            height: 380px;
            margin-top: 0;
        }

        .pill-2 {
            height: 380px;
            margin-top: 230px;
        }

        .pill-3 {
            height: 380px;
            margin-top: 420px;
            position: absolute;
            right: 50px;
        }

        /* Adjusting layout for the overlapping pills */
        .image-grid-container {
            position: relative;
            width: 300px;
            height: 800px;
        }

        .pill-red {
            position: absolute;
            top: 0;
            right: 150px;
            width: 120px;
            height: 380px;
            background-color: #e63946;
            border-radius: 100px;
            overflow: hidden;
        }

        .pill-yellow {
            position: absolute;
            top: 230px;
            right: 0;
            width: 120px;
            height: 380px;
            background-color: #fcd12a;
            border-radius: 100px;
            overflow: hidden;
        }

        .pill-blue {
            position: absolute;
            top: 420px;
            right: 150px;
            width: 120px;
            height: 380px;
            background-color: #1d3557;
            border-radius: 100px;
            overflow: hidden;
        }

        .pill-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        @media (max-width: 1024px) {
            main {
                flex-direction: column;
                gap: 50px;
                padding-bottom: 100px;
            }
            .image-grid-container {
                margin-top: 50px;
                height: 800px;
            }
            .globe-icon-container {
                right: 20px;
            }
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
</head>
<body>

<!-- Background Circles -->
<div class="bg-circle circle-1"></div>
<div class="bg-circle circle-2"></div>
<div class="bg-circle circle-3"></div>
<div class="bg-circle circle-4"></div>
<div class="bg-circle circle-5"></div>
<div class="bg-circle circle-6"></div>
<div class="bg-circle circle-7"></div>
<div class="bg-circle circle-8"></div>
<div class="bg-circle circle-9"></div>
<div class="bg-circle circle-10"></div>
<div class="bg-circle circle-11"></div>
<div class="bg-circle circle-12"></div>
<div class="bg-circle circle-13"></div>
<div class="bg-circle circle-14"></div>
<div class="bg-circle circle-15"></div>
<div class="bg-circle circle-16"></div>
<div class="bg-circle circle-17"></div>

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
    <div class="hero-card">
        <h1>Make Studying a</h1>
        <h2>LIFESTYLE</h2>
        <p>A Good Education opens doors to limitless possibilities.<br>Be the change you want to see!</p>
        <div class="hero-buttons">
<#--            <a href="/signIn" class="btn-tutor">Become a Tutor</a>-->
<#--            <a href="/signIn" class="btn-study">Start Studying</a>-->
            <a href="/signIn"> <button class="hero-btn btn-tutor">Become a Tutor</button> </a>
            <a href="/signIn"> <button class="hero-btn btn-study">Start Studying</button> </a>
        </div>
    </div>

    <div class="image-grid-container">
        <div class="pill-red">
            <img src="https://placehold.co/240x760/e63946/white?text=Student+1" alt="A female student holding books, smiling, red background, vertical pill shape" class="pill-img">
        </div>
        <div class="pill-yellow">
            <img src="https://placehold.co/240x760/fcd12a/white?text=Student+2" alt="A female student in a red hoodie holding books, yellow background, vertical pill shape" class="pill-img">
        </div>
        <div class="pill-blue">
            <img src="https://placehold.co/240x760/1d3557/white?text=Student+3" alt="A male student with a backpack holding books, blue background, vertical pill shape" class="pill-img">
        </div>
    </div>
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