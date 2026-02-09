<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aptitude Test Completion</title>
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #d2c4b5;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            color: #000;
        }

        /* Background Blobs */
        .blob {
            position: absolute;
            border-radius: 50%;
            filter: blur(60px);
            z-index: -1;
            opacity: 0.6;
        }

        .blob-purple {
            top: 15%;
            left: -5%;
            width: 250px;
            height: 250px;
            background-color: #9a9ae0;
        }

        .blob-orange {
            bottom: 15%;
            left: -5%;
            width: 250px;
            height: 250px;
            background-color: #f38d21;
        }

        header {
            margin-bottom: 40px;
        }

        header h2 {
            font-weight: 900;
            text-transform: uppercase;
            letter-spacing: 0.3em;
            font-size: 1.4rem;
            text-align: center;
        }

        .card {
            background-color: #ffffff;
            width: 90%;
            max-width: 900px;
            padding: 80px 40px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .card h1 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 10px;
            line-height: 1.4;
        }

        .card .test-name {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 50px;
        }

        .card p {
            font-size: 1rem;
            line-height: 1.5;
            color: #333;
            max-width: 500px;
            margin-bottom: 40px;
        }

        .card .happy-studying {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 60px;
        }

        .btn-dashboard {
            display: inline-block;
            padding: 10px 40px;
            border: 3px solid #000;
            background-color: #fff;
            color: #000;
            text-decoration: none;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .btn-dashboard:hover {
            background-color: #000;
            color: #fff;
        }

        footer {
            margin-top: 40px;
        }

        footer p {
            font-style: italic;
            letter-spacing: 0.3em;
            font-weight: 700;
            font-size: 1.2rem;
        }

        @media (max-width: 768px) {
            .card {
                padding: 40px 20px;
            }
            .card h1, .card .test-name {
                font-size: 1.6rem;
            }
            header h2 {
                font-size: 1rem;
            }
            footer p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>

<div class="blob blob-purple"></div>
<div class="blob blob-orange"></div>

<header>
    <h2>Name of the WebApp</h2>
</header>

<main class="card">
    <h1>Thank you for completing the</h1>
    <div class="test-name">Aptitude Test!</div>

    <p>
        Your answers have been submitted successfully.<br>
        Now you will have access to your personalised Study Plan!
    </p>

    <div class="happy-studying">Happy Studying!</div>

    <a href="/dashboard" class="btn-dashboard">Dashboard</a>
</main>

<footer>
    <p>You Got This!</p>
</footer>

</body>
</html>