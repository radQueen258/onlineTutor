<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Resource</title>

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
            max-width: 600px;
            padding: 40px 50px;
            border-radius: 16px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        }

        h2 {
            color: #0f2b4c;
            margin-bottom: 30px;
            font-size: 26px;
        }

        label {
            font-weight: 600;
            margin-bottom: 6px;
            display: block;
            color: #0f2b4c;
        }

        select {
            width: 100%;
            padding: 10px 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .actions {
            display: flex;
            gap: 12px;
        }

        .btn-primary {
            background: #0f2b4c;
            color: white;
            border: none;
            padding: 10px 18px;
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
            text-decoration: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: 600;
        }
    </style>
</head>

<body>

<main class="card">

    <h2>Create Resource from Curriculum</h2>

    <form action="/admin/resources/save" method="post">

        <label>Select Curriculum Topic</label>
        <select name="curriculumResourceId" required>
            <#list curriculumResources as cr>
                <option value="${cr.id}">
                    ${cr.topicName} (${cr.subject}, ${cr.grade})
                </option>
            </#list>
        </select>

        <div class="actions">
            <button type="submit" class="btn-primary">Create Resource</button>
            <a href="/admin/workplace" class="btn-secondary">Cancel</a>
        </div>

    </form>

</main>

</body>
</html>
