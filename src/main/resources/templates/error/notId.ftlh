<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invalid ID</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
        }

        body {
            min-height: 100vh;
            background: #f0f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .card {
            background: white;
            max-width: 520px;
            width: 100%;
            padding: 45px 50px;
            border-radius: 18px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.12);
            text-align: center;
        }

        h2 {
            font-size: 26px;
            font-weight: 800;
            color: #dc3545;
            margin-bottom: 15px;
        }

        p {
            font-size: 15px;
            color: #555;
            margin-bottom: 30px;
        }

        .btn {
            background-color: #0f2b4c;
            color: white;
            border: none;
            padding: 12px 26px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
        }

        .btn:hover {
            background-color: #123c5e;
        }
    </style>
</head>

<body>

<div class="card">
    <h2>This is not a valid ID</h2>
    <p>Please upload a valid identification document to continue your registration.</p>

    <a href="/signUp" class="btn">Try Again</a>
</div>

</body>
</html>
