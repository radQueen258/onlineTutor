<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Get In Touch - AppName</title>
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #ffffff;
            color: #000;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }

        /* Navigation Styles */
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

        /* Main Content Styles */
        main {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            padding: 40px 10%;
        }

        .content-container {
            display: flex;
            width: 100%;
            max-width: 1200px;
            justify-content: space-between;
            align-items: center;
            z-index: 10;
        }

        .left-side {
            flex: 1;
        }

        .left-side h1 {
            font-size: 42px;
            font-style: italic;
            font-weight: 500;
        }

        .right-side {
            flex: 1;
            max-width: 500px;
        }

        .form-group {
            margin-bottom: 35px;
        }

        .form-group label {
            display: block;
            font-weight: 700;
            font-size: 18px;
            margin-bottom: 10px;
        }

        .form-group input {
            width: 100%;
            border: none;
            border-bottom: 2px solid #000;
            padding: 10px 0;
            font-size: 16px;
            outline: none;
            background: transparent;
        }

        .submit-container {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }

        .submit-btn {
            background-color: #fff;
            border: 4px solid #000;
            padding: 12px 40px;
            font-weight: 700;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .submit-btn:hover {
            background-color: #000;
            color: #fff;
        }

        /* Background Blurred Circles */
        .blur-circle {
            position: absolute;
            border-radius: 50%;
            filter: blur(40px);
            z-index: 1;
            opacity: 0.7;
        }

        .circle-purple {
            width: 180px;
            height: 180px;
            background-color: #a78bfa;
            top: 10%;
            left: 5%;
        }

        .circle-red {
            width: 140px;
            height: 140px;
            background-color: #ef4444;
            top: 20%;
            left: 40%;
        }

        .circle-green {
            width: 60px;
            height: 60px;
            background-color: #22c55e;
            top: 45%;
            left: 20%;
        }

        .circle-yellow {
            width: 70px;
            height: 70px;
            background-color: #eab308;
            bottom: 30%;
            left: 32%;
        }

        .circle-orange {
            width: 160px;
            height: 160px;
            background-color: #f97316;
            bottom: 10%;
            left: 5%;
        }

        .circle-blue {
            width: 80px;
            height: 80px;
            background-color: #3b82f6;
            bottom: 15%;
            left: 33%;
        }

        /* Footer Styles */
        footer {
            padding: 40px 10%;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            font-size: 14px;
            line-height: 1.8;
        }

        .footer-left {
            color: #333;
        }

        .footer-left .brand {
            font-weight: 400;
            letter-spacing: 2px;
            margin-bottom: 10px;
            display: block;
        }

        .footer-right {
            text-align: right;
            color: #333;
        }

        .footer-links {
            margin-bottom: 10px;
        }

        @media (max-width: 768px) {
            nav {
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
                border-radius: 20px;
            }
            .content-container {
                flex-direction: column;
                text-align: center;
            }
            .left-side {
                margin-bottom: 50px;
            }
            .right-side {
                width: 100%;
            }
            footer {
                flex-direction: column;
                align-items: center;
                text-align: center;
                gap: 20px;
            }
            .footer-right {
                text-align: center;
            }
            .blur-circle {
                opacity: 0.4;
            }
        }
    </style>
</head>
<body>

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
    <!-- Decorative Background Elements -->
    <div class="blur-circle circle-purple"></div>
    <div class="blur-circle circle-red"></div>
    <div class="blur-circle circle-green"></div>
    <div class="blur-circle circle-yellow"></div>
    <div class="blur-circle circle-orange"></div>
    <div class="blur-circle circle-blue"></div>

    <div class="content-container">
        <div class="left-side">
            <h1>Get In Touch !</h1>
        </div>
        <div class="right-side">
            <form>
                <div class="form-group">
                    <label for="first-name">First Name*</label>
                    <input type="text" id="first-name" required>
                </div>
                <div class="form-group">
                    <label for="last-name">Last Name *</label>
                    <input type="text" id="last-name" required>
                </div>
                <div class="form-group">
                    <label for="school-name">School Name *</label>
                    <input type="text" id="school-name" required>
                </div>
                <div class="form-group">
                    <label for="message">Message *</label>
                    <input type="text" id="message" required>
                </div>
                <div class="submit-container">
                    <button type="submit" class="submit-btn">Submit</button>
                </div>
            </form>
        </div>
    </div>
</main>

<footer>
    <div class="footer-left">
        <span class="brand">APPNAME---</span>
        <p>Smarter prep. Better results.</p>
        <p>© 2025 APPNAME. All rights reserved.</p>
    </div>
    <div class="footer-right">
        <div class="footer-links">
            Home | About | Features | Register
        </div>
        <p>Become a Tutor</p>
        <p>support@appname.com</p>
    </div>
</footer>

</body>
</html>