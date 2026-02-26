<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${translation.translatedTitle}</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter', sans-serif; background:#f5f7fb; padding:60px; }
        .container {
            max-width:900px;
            margin:auto;
            background:#fff;
            padding:50px;
            border-radius:20px;
            box-shadow:0 10px 30px rgba(0,0,0,0.1);
        }
        h1 { font-size:36px; margin-bottom:20px; }
        .content { line-height:1.7; font-size:16px; }
    </style>
</head>
<body>

<div class="container">
    <h1>${translation.translatedTitle}</h1>
    <br>
    <div class="content">
        ${translation.translatedContent?no_esc}
    </div>
</div>

</body>
</html>