<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Aptitude Test</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', system-ui, sans-serif;
        }

        body {
            min-height: 100vh;
            background: #f0f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: #333;
        }

        .card {
            background: white;
            width: 100%;
            max-width: 600px;
            border-radius: 18px;
            padding: 45px 50px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.12);
            text-align: center;
        }

        h1 {
            font-size: 30px;
            font-weight: 800;
            color: #0f2b4c;
            margin-bottom: 15px;
        }

        p {
            font-size: 15px;
            line-height: 1.6;
            color: #555;
            margin-bottom: 35px;
        }

        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-primary {
            background-color: #0f2b4c;
            color: white;
            border: none;
            padding: 12px 26px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.2s ease;
        }

        .btn-primary:hover {
            background-color: #123c5e;
        }

        .btn-secondary {
            background-color: transparent;
            color: #0f2b4c;
            border: 2px solid #0f2b4c;
            padding: 10px 24px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .btn-secondary:hover {
            background-color: #0f2b4c;
            color: white;
        }

        .note {
            margin-top: 25px;
            font-size: 13px;
            color: #777;
        }
    </style>
</head>

<body>

<main class="card">
    <h1>Aptitude Test</h1>

    <p>
        This aptitude test evaluates your core skills and takes approximately
        <strong>1 hour</strong> to complete.
        Please ensure you have a stable internet connection and sufficient time
        before starting.
    </p>

    <div class="actions">
        <form action="/aptitude-test/start" method="get">
            <button type="submit" class="btn-primary">
                Take Test Now
            </button>
        </form>

        <form action="/dashboard" method="get">
            <input type="hidden" name="status" value="NOT_STARTED">
            <button type="submit" class="btn-secondary">
                Take Test Later
            </button>
        </form>
    </div>

    <div class="note">
        Once started, the test must be completed in one session.
    </div>
</main>

</body>
</html>
