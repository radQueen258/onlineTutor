<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Redirection Error</title>

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

        h1 {
            font-size: 28px;
            font-weight: 800;
            color: #0f2b4c;
            margin-bottom: 15px;
        }

        p {
            font-size: 15px;
            color: #555;
            margin-bottom: 30px;
        }

        a {
            background-color: #0f2b4c;
            color: white;
            padding: 12px 26px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
        }
    </style>
</head>

<body>

<div class="card">
    <h1>Redirection Error</h1>
    <p>Something went wrong while redirecting you.</p>

    <#if dashboardUrl??>
        <a href="${dashboardUrl}">Go to Dashboard</a>
    <#else>
        <a href="/">Go to Home</a>
    </#if>
</div>

</body>
</html>
