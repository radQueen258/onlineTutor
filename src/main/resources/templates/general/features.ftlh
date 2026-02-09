<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>What We Offer - Study Platform</title>
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f4f7f9;
            color: #000;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            overflow-x: hidden;
            padding-bottom: 50px;
        }

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

        .main-container {
            max-width: 1200px;
            width: 100%;
            padding: 40px 20px;
            position: relative;
        }

        .section-title {
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 60px;
            letter-spacing: 1px;
        }

        .grid-layout {
            display: grid;
            grid-template-columns: 1fr 1fr 1fr;
            gap: 40px;
            align-items: start;
        }

        .card-image {
            width: 100%;
            aspect-ratio: 1 / 1.1;
            border-radius: 150px;
            object-fit: cover;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .red-bg { background-color: #e55050; }
        .blue-bg { background-color: #2b58a1; }
        .purple-bg { background-color: #a393c3; }

        .content-block {
            text-align: center;
            padding: 20px 0;
        }

        .content-block h3 {
            font-style: italic;
            font-weight: 700;
            font-size: 18px;
            margin-bottom: 15px;
        }

        .content-block p {
            font-size: 15px;
            line-height: 1.5;
            color: #333;
            max-width: 280px;
            margin: 0 auto;
        }

        /* Decorative dots */
        .dot {
            position: absolute;
            border-radius: 50%;
            z-index: -1;
        }

        .dot-purple-lg { width: 40px; height: 40px; background-color: #a393c3; top: 100px; left: 100px; }
        .dot-blue-sm { width: 20px; height: 20px; background-color: #2b58a1; top: 80px; right: 50px; }
        .dot-red-sm { width: 18px; height: 18px; background-color: #e55050; top: 180px; right: 32%; }
        .dot-orange-sm { width: 18px; height: 18px; background-color: #f38d2d; top: 290px; left: 48%; }
        .dot-red-xs { width: 15px; height: 15px; background-color: #e55050; top: 550px; left: 35%; }
        .dot-yellow-xs { width: 12px; height: 12px; background-color: #f9c835; top: 520px; left: 51%; }
        .dot-blue-md { width: 22px; height: 22px; background-color: #2b58a1; bottom: 200px; right: 28%; }
        .dot-green-md { width: 22px; height: 22px; background-color: #4caf50; bottom: 50px; left: 10%; }
        .dot-red-md { width: 18px; height: 18px; background-color: #e55050; bottom: 80px; right: 5%; }

        /* Responsive adjustments */
        @media (max-width: 900px) {
            .grid-layout {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            .dot { display: none; }
            .nav-bar { flex-wrap: wrap; justify-content: center; border-radius: 20px; }
        }

        .col-left { display: flex; flex-direction: column; gap: 40px; }
        .col-center { display: flex; flex-direction: column; gap: 40px; padding-top: 20px; }
        .col-right { display: flex; flex-direction: column; gap: 40px; }

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

<main class="main-container">
    <!-- Decorative dots -->
    <div class="dot dot-purple-lg"></div>
    <div class="dot dot-blue-sm"></div>
    <div class="dot dot-red-sm"></div>
    <div class="dot dot-orange-sm"></div>
    <div class="dot dot-red-xs"></div>
    <div class="dot dot-yellow-xs"></div>
    <div class="dot dot-blue-md"></div>
    <div class="dot dot-green-md"></div>
    <div class="dot dot-red-md"></div>

    <h1 class="section-title">WHAT WE OFFER</h1>

    <div class="grid-layout">
        <!-- Left Column -->
        <div class="col-left">
            <img src="https://placehold.co/400x450/e55050/ffffff?text=Woman+with+Books" alt="Woman with books on a red background" class="card-image">

            <div class="content-block">
                <h3>Progress Tracking</h3>
                <p>Stay motivated by seeing how far you've come.</p>
            </div>

            <div class="content-block">
                <h3>Curated Resources</h3>
                <p>Access the best articles and videos, matched to your needs.</p>
            </div>
        </div>

        <!-- Center Column -->
        <div class="col-center">
            <div class="content-block" style="margin-bottom: 20px;">
                <h3>Personalized Study Plans</h3>
                <p>Organize your preparation with smart topic weighting and pacing that fit your goals.</p>
            </div>

            <img src="https://placehold.co/400x450/2b58a1/ffffff?text=Man+with+Backpack" alt="Man with a backpack and yellow folder on a blue background" class="card-image">
        </div>

        <!-- Right Column -->
        <div class="col-right">
            <img src="https://placehold.co/400x450/a393c3/ffffff?text=Woman+with+Backpack" alt="Woman with a backpack on a purple background" class="card-image">

            <div class="content-block">
                <h3>Exam Topic Trends</h3>
                <p>See which topics appear most often in past exams so you know where to focus.</p>
            </div>

            <div class="content-block">
                <h3>Explanation in your local language</h3>
                <p>Check explanatory videos and articles in your own local language.</p>
            </div>
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