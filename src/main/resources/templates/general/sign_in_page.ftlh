<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>APPNAME - Login</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>

    <!-- ===== CSS (UNCHANGED) ===== -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #ffffff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
            position: relative;
        }

        .blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(40px);
            z-index: -1;
            opacity: 0.7;
        }

        .blob-purple { width: 180px; height: 180px; background-color: #a29bfe; top: 10%; left: 2%; }
        .blob-red { width: 140px; height: 140px; background-color: #ff4d4d; top: 20%; left: 35%; }
        .blob-green { width: 60px; height: 60px; background-color: #2ecc71; top: 45%; left: 17%; }
        .blob-yellow { width: 80px; height: 80px; background-color: #f1c40f; bottom: 30%; left: 28%; }
        .blob-orange { width: 150px; height: 150px; background-color: #e67e22; bottom: 10%; left: 2%; }
        .blob-blue { width: 70px; height: 70px; background-color: #3498db; bottom: 10%; left: 29%; }

        header {
            display: flex;
            justify-content: center;
            padding: 20px;
            width: 100%;
        }

        .nav-bar {
            background-color: #f4c430;
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
            gap: 20px;
        }

        .btn-login-nav {
            background-color: #fff;
            color: #000;
            padding: 10px 35px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
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

        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 10%;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }

        .hero-text {
            font-size: 42px;
            font-weight: 500;
            font-style: italic;
            color: #000;
            max-width: 450px;
        }

        .login-form-container {
            width: 450px;
            display: flex;
            flex-direction: column;
            gap: 25px;
            align-items: flex-end;
        }

        .input-group {
            width: 100%;
        }

        .input-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #000;
            font-size: 18px;
            outline: none;
            background: transparent;
        }

        .input-group input::placeholder {
            color: #000;
        }

        .btn-login-main {
            background-color: #fff;
            border: 2px solid #000;
            padding: 10px 45px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.4);
            transition: transform 0.2s ease;
            margin-top: 20px;
            margin-right: 30px;
        }

        .btn-login-main:active {
            transform: scale(0.98);
        }

        footer {
            padding: 40px 10%;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
        }

        .footer-left, .footer-right {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .footer-right {
            text-align: right;
        }

        @media (max-width: 1024px) {
            main {
                flex-direction: column;
                justify-content: center;
                gap: 50px;
                text-align: center;
                padding-top: 50px;
            }
            .login-form-container {
                align-items: center;
            }
            .btn-login-main {
                margin-right: 0;
            }
            footer {
                flex-direction: column;
                align-items: center;
                text-align: center;
                gap: 30px;
            }
            .footer-right {
                text-align: center;
            }
            .nav-bar {
                flex-direction: column;
                gap: 15px;
                border-radius: 20px;
            }
        }
    </style>
</head>

<body>

<!-- Background Blobs -->
<div class="blob blob-purple"></div>
<div class="blob blob-red"></div>
<div class="blob blob-green"></div>
<div class="blob blob-yellow"></div>
<div class="blob blob-orange"></div>
<div class="blob blob-blue"></div>

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
            <a href="/signIn" class="btn-login-nav">Login</a>
            <a href="/signUp" class="btn-register-nav">Register</a>
        </div>
    </nav>
</header>

<!-- ===== MAIN ===== -->
<main>
    <div class="hero-text">
        We’ve been waiting for you!
    </div>

    <form class="login-form-container"
          action="/signIn"
          method="post">

        <div class="input-group">
            <input name="email" type="email" placeholder="Email*" required>
        </div>

        <div class="input-group">
            <input name="password" type="password" placeholder="Password*" required>
        </div>

        <button type="submit" class="btn-login-main">Login</button>
    </form>
</main>

<!-- ===== FOOTER ===== -->
<footer>
    <div class="footer-left">
        <div class="app-name">APPNAME---</div>
        <div class="tagline">Smarter prep. Better results.</div>
        <div class="copyright">© 2025 APPNAME. All rights reserved.</div>
    </div>
    <div class="footer-right">
        <div class="footer-nav">Home | About | Features | Register</div>
        <a href="#" class="footer-link">Become a Tutor</a>
        <div class="footer-email">support@appname.com</div>
    </div>
</footer>

</body>
</html>
