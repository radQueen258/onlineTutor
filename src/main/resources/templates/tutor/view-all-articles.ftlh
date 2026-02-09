<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor - Resources' Articles</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }

        body {
            background-color: #f0f4f9;
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
            position: relative;
        }

        /* Sidebar */
        aside.sidebar {
            width: 280px;
            background-color: #113255;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            position: fixed;
            height: 100vh;
            left: 0;
            top: 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            z-index: 100;
        }

        .sidebar-brand { padding: 0 30px; font-size: 18px; font-weight: 700; margin-bottom: 60px; }
        .nav-menu { list-style: none; flex-grow: 1; }
        .nav-item { padding: 15px 30px; font-size: 16px; font-weight: 500; margin-bottom: 10px; cursor: pointer; }
        .nav-item a { color: white; text-decoration: none; }
        .nav-item:hover { background-color: #8b6b45; border-radius: 10px; }
        .sidebar-footer { padding: 0 30px; margin-top: auto; }
        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            width: 100%;
        }

        /* Main Content */
        main.content {
            flex-grow: 1;
            margin-left: 280px;
            padding: 40px 60px;
            position: relative;
            max-width: 1200px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 15px;
            padding: 40px 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            display: flex;
            flex-direction: column;
            gap: 40px;
        }

        h2.resource-title {
            font-size: 24px;
            font-weight: 700;
            border-bottom: 2px solid #eee;
            padding-bottom: 8px;
            margin-bottom: 20px;
            color: #000;
        }

        .article-card {
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .article-card h3 { font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #000; }
        .article-card p { font-size: 16px; margin-bottom: 8px; color: #333; }

        .btn {
            display: inline-block;
            padding: 8px 18px;
            margin-right: 10px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
            border: none;
        }

        .btn-primary { background-color: #007bff; color: white; }
        .btn-primary:hover { background-color: #0056b3; }

        .btn-secondary { background-color: #f1b981; color: #000; }
        .btn-secondary:hover { background-color: #e0a95f; }

        .video-card {
            background-color: #f8f8f8;
            padding: 10px;
            border-radius: 8px;
            margin: 12px 0;
        }

        iframe {
            width: 100%;
            max-width: 420px;
            height: 236px;
            border: none;
            border-radius: 8px;
        }

        @media (max-width: 1024px) {
            main.content { margin-left: 0; padding: 20px; }
            aside.sidebar { display: none; }
            iframe { max-width: 100%; }
        }
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-brand">Website Name</div>
    <ul class="nav-menu">
        <li class="nav-item"><a href="/tutor/workplace">Workplace</a></li>
        <li class="nav-item"><a href="/tutor/analytics">View Analytics</a></li>
        <li class="nav-item"><a href="/tutor/resources/new">Create Resource</a></li>
    </ul>
    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
</aside>

<main class="content">
    <div class="card">
        <#if resources?size == 0>
            <p>You don’t have any resources yet.</p>
            <a href="/tutor/resources/new" class="btn btn-secondary">Create Resource</a>
        <#else>
            <#list resources as resource>
                <div class="resource-section">
                    <h2 class="resource-title">${resource.topicName}</h2>

                    <#if resource.articles?? && (resource.articles?size > 0)>
                        <#list resource.articles as article>
                            <div class="article-card">
                                <h3>${article.articleTitle}</h3>
                                <p><strong>Subject:</strong> ${article.subject}</p>

                                <a href="/tutor/resources/${resource.id}/article/${article.id}" class="btn btn-primary">See Article</a>
                                <a href="/tutor/article/edit/${article.id}" class="btn btn-secondary">Edit Article</a>

                                <#if article.video??>
                                    <div class="video-card">
                                        <strong>${article.video.videoTitle}</strong><br>
                                        <small>${article.video.videoDescription!""}</small><br>
                                        <button type="button" class="btn btn-primary" onclick="toggleVideo('video-${article.video.id}')">Show / Hide Video</button>
                                        <div id="video-${article.video.id}" style="display:none;">
                                            <iframe src="https://www.youtube.com/embed/${(article.video.videoUrl?matches('v=([^&]+)'))?then(article.video.videoUrl?replace('.*v=([^&]+).*','$1'), article.video.videoUrl?replace('.*/([^/?]+)$','$1'))}"
                                                    title="${article.video.videoTitle}" allowfullscreen></iframe>
                                        </div>
                                    </div>
                                    <a href="/tutor/video/edit/${article.video.id}" class="btn btn-secondary">Edit Video</a>
                                <#else>
                                    <p>No videos yet for this article.</p>
                                </#if>

                                <a href="/tutor/resources/${resource.id}/article/${article.id}/upload-video" class="btn btn-primary">Add Video</a>
                            </div>
                        </#list>

                        <a href="/tutor/resources/${resource.id}/article/new" class="btn btn-primary">Add Article</a>
                    <#else>
                        <p>No articles yet for this resource.</p>
                        <a href="/tutor/resources/${resource.id}/article/new" class="btn btn-primary">Add Article</a>
                    </#if>
                </div>
            </#list>
        </#if>
    </div>
</main>

<script>
    function toggleVideo(id) {
        const el = document.getElementById(id);
        if (!el) return;
        el.style.display = (el.style.display === 'none' || el.style.display === '') ? 'block' : 'none';
    }
</script>

</body>
</html>
