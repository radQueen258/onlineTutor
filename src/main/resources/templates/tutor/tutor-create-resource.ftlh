<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Resource</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        *{box-sizing:border-box;margin:0;padding:0;font-family:'Inter',sans-serif;}
        body{background:#d7c4ae;min-height:100vh;display:flex;justify-content:center;align-items:flex-start;padding:20px;}
        .card{background:#fff;border-radius:15px;padding:50px 60px;box-shadow:0 15px 40px rgba(0,0,0,0.15);width:100%;max-width:600px;display:flex;flex-direction:column;gap:25px;}
        h2{font-size:28px;font-weight:800;color:#000;margin-bottom:20px;}
        label{font-weight:600;margin-bottom:6px;display:block;color:#000;}
        select{width:100%;padding:10px;margin-bottom:15px;border-radius:8px;border:2px solid #ccc;font-size:14px;}
        .btn-primary{background:#007bff;color:#fff;border:none;border-radius:8px;padding:10px 25px;font-weight:700;cursor:pointer;transition:0.2s;}
        .btn-primary:hover{background:#0056b3;}
        @media(max-width:768px){.card{padding:30px 20px;}h2{font-size:22px;}}
    </style>
</head>
<body>

<main class="card">
    <h2>Create New Resource</h2>

    <form action="/tutor/resources/save" method="post">
        <label>Curriculum Topic:</label>
        <select name="curriculumResourceId" required>
            <option value="" disabled selected>Select a topic</option>
            <#list curriculumResources as cr>
                <option value="${cr.id?c}">${cr.topicName} (${cr.grade})</option>
            </#list>
        </select>

        <div style="margin-top:20px;">
            <button type="submit" class="btn-primary">Create Resource</button>
            <a href="/tutor/workplace" class="btn-link">Cancel</a>
        </div>

    </form>
</main>

</body>
</html>
