<!DOCTYPE html>
<html>
<head>
    <title>Translations</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter', sans-serif; background:#f5f7fb; padding:40px; }
        h2 { font-size:32px; margin-bottom:30px; }
        table { width:100%; background:#fff; border-radius:16px; overflow:hidden; box-shadow:0 5px 20px rgba(0,0,0,0.08); }
        th, td { padding:18px; text-align:left; }
        th { background:#0F3456; color:#fff; }
        tr:nth-child(even) { background:#f9f9f9; }
        a { color:#0F3456; font-weight:600; text-decoration:none; }
    </style>
</head>
<body>

<h2>Translations</h2>

<table>
    <tr>
        <th>Article</th>
        <th>Subject</th>
        <th>Grade</th>
        <th>Language</th>
        <th>View</th>
    </tr>

    <#list translations as t>
        <tr>
            <td>${t.article.articleTitle}</td>
            <td>${t.article.subject}</td>
            <td>${t.article.resource.curriculumResource.grade}</td>
            <td>${t.language}</td>
            <td>
                <a href="/articles/${t.article.id?c}/translations/${t.language}">
                    Open
                </a>
            </td>
        </tr>
    </#list>

</table>

</body>
</html>