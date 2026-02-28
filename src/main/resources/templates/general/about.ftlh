<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Legacy - Educational Platform</title>
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f0f4f8;
            color: #000;
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
        }

        /* Decorative Dots */
        .dot {
            position: absolute;
            border-radius: 50%;
            z-index: 0;
        }
        .dot-teal { background-color: #4db6ac; width: 24px; height: 24px; }
        .dot-yellow { background-color: #fbc02d; width: 20px; height: 20px; }
        .dot-green { background-color: #4caf50; width: 18px; height: 18px; }
        .dot-orange { background-color: #e67e22; width: 22px; height: 22px; }
        .dot-darkblue { background-color: #1a237e; width: 18px; height: 18px; }

        /* Navigation */
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


        /* Main Content */
        main {
            display: flex;
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
            position: relative;
            z-index: 1;
        }

        .left-content {
            flex: 1;
            position: relative;
            display: flex;
            flex-direction: column;
            gap: 50px;
        }

        .image-circle {
            width: 350px;
            height: 350px;
            border-radius: 50%;
            overflow: hidden;
            display: flex;
            align-items: flex-end;
            justify-content: center;
            position: relative;
        }

        .circle-green { background-color: #4caf50; }
        .circle-teal { background-color: #80deea; width: 280px; height: 280px; margin-left: 100px; }

        .image-circle img {
            width: 90%;
            height: auto;
            object-fit: cover;
        }

        .right-content {
            flex: 1.2;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding-top: 40px;
            position: relative;
        }

        .glow-bg {
            position: absolute;
            top: 0;
            right: 0;
            width: 100%;
            height: 400px;
            background: radial-gradient(circle, rgba(244, 204, 51, 0.4) 0%, rgba(244, 204, 51, 0) 70%);
            z-index: -1;
        }

        h1 {
            font-size: 32px;
            font-weight: 800;
            margin-bottom: 10px;
            line-height: 1.4;
        }

        h1 span {
            display: block;
        }

        .description {
            max-width: 550px;
            font-size: 17px;
            line-height: 1.5;
            margin-top: 80px;
            color: #000;
        }

        .vision {
            max-width: 550px;
            font-size: 17px;
            line-height: 1.5;
            margin-top: 40px;
            color: #000;
        }

        .tagline {
            margin-top: 60px;
            font-size: 18px;
            font-weight: 700;
            font-style: italic;
        }

        /* Responsive */
        @media (max-width: 992px) {
            main {
                flex-direction: column;
                align-items: center;
            }
            .nav-container {
                flex-wrap: wrap;
                justify-content: center;
                border-radius: 20px;
            }
            .left-content {
                margin-bottom: 50px;
            }
            .circle-teal {
                margin-left: 0;
            }
        }

        @media (max-width: 600px) {
            .nav-links {
                padding-left: 0;
                gap: 10px;
            }
            .nav-links a {
                font-size: 13px;
            }
            .nav-links a.active {
                padding: 6px 15px;
            }
            .btn {
                padding: 8px 15px;
                font-size: 13px;
            }
            .image-circle {
                width: 280px;
                height: 280px;
            }
            .circle-teal {
                width: 220px;
                height: 220px;
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

<!-- Decorative Dots -->
<div class="dot dot-teal" style="top: 150px; left: 60px;"></div>
<div class="dot dot-yellow" style="top: 120px; left: 370px;"></div>
<div class="dot dot-teal" style="top: 120px; left: 510px;"></div>
<div class="dot dot-green" style="top: 300px; left: 413px;"></div>
<div class="dot dot-orange" style="top: 420px; left: 462px;"></div>
<div class="dot dot-green" style="top: 620px; left: 51px;"></div>
<div class="dot dot-darkblue" style="top: 660px; left: 251px;"></div>
<div class="dot dot-green" style="top: 640px; left: 338px;"></div>
<div class="dot dot-teal" style="top: 715px; left: 378px;"></div>
<div class="dot dot-teal" style="top: 800px; left: 117px;"></div>
<div class="dot dot-green" style="top: 935px; left: 117px;"></div>
<div class="dot dot-yellow" style="top: 820px; left: 435px;"></div>

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

</header>

<main>
    <div class="left-content">
        <div class="image-circle circle-green">
            <img src="https://images.unsplash.com/photo-1524504388940-b1c1722653e1?q=80&w=600&auto=format&fit=crop" alt="Smiling female student with backpack and notebook">
        </div>
        <div class="image-circle circle-teal">
            <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=600&auto=format&fit=crop" alt="Smiling male student in orange sweater">
        </div>
    </div>

    <div class="right-content">
        <div class="glow-bg"></div>
        <h1>
            <span>We are here to</span>
            <span>create a</span>
            <span>LEGACY!</span>
        </h1>

        <p class="description">
            Preparing for exams can feel overwhelming. Our platform is designed to make your study journey more focused and efficient by giving you the tools to understand what really matters and how to tackle it.
        </p>

        <p class="vision">
            We want to help students prepare with confidence by combining data-driven insights and quality learning resources. Our vision is simple:
        </p>

        <p class="tagline">
            Less stress. Smarter prep. Better results.
        </p>
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