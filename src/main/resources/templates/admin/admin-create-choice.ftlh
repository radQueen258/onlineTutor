<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Options</title>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Inter', system-ui, sans-serif;
            background-color: #f0f4f9;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 60px 20px;
            color: #333;
        }

        .card {
            background: #ffffff;
            width: 100%;
            max-width: 500px;
            padding: 40px 50px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
            text-align: center;
        }

        h2 {
            color: #0f2b4c;
            margin-bottom: 30px;
            font-size: 26px;
        }

        .actions {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .btn-primary {
            background: #0f2b4c;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-primary:hover {
            background: #123c5e;
        }

        .btn-secondary {
            background: #e0e6ed;
            color: #0f2b4c;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
        }
    </style>
</head>

<body>

<main class="card">

    <h2>What do you want to create?</h2>

    <div class="actions">
        <form action="/admin/curriculum-resources/new" method="get">
            <button type="submit" class="btn-primary">
                Curriculum Resource
            </button>
        </form>

        <form action="/admin/resources/new" method="get">
            <button type="submit" class="btn-secondary">
                Resource
            </button>
        </form>
    </div>

</main>

</body>
</html>
