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
        .nav-item {
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
            gap: 8px;
        }

        .nav-item.active {
            background-color: #82613E;
            margin-right: 15px;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
            gap: 8px;
        }

        .nav-item a {
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-item:hover {
            background-color: #8b6b45;
            border-radius: 10px;
        }

        .sidebar-footer {
            padding: 0 40px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 14px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
        }

        .profile-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }
        /* Main Content */
        main.content { flex-grow: 1; margin-left: 280px; padding: 40px 60px; max-width: 1200px; }
        .card { background-color: #fff; border-radius: 20px; padding: 40px; box-shadow: 0 15px 35px rgba(0,0,0,0.08); display: flex; flex-direction: column; gap: 40px; transition: box-shadow 0.3s; }
        .card:hover { box-shadow: 0 20px 50px rgba(0,0,0,0.12); }

        h2.resource-title { font-size: 26px; font-weight: 700; border-bottom: 2px solid #eee; padding-bottom: 10px; margin-bottom: 25px; color: #222; }
        .article-card { padding: 20px; border-radius: 12px; background: #fafafa; margin-bottom: 20px; transition: transform 0.2s, box-shadow 0.2s; }
        .article-card:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0,0,0,0.08); }
        .article-card h3 { font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #000; }
        .article-card p { font-size: 15px; margin-bottom: 12px; color: #444; }

        .btn { display: inline-block; padding: 10px 20px; margin-right: 10px; border-radius: 12px; font-weight: 600; font-size: 14px; text-decoration: none; cursor: pointer; transition: all 0.3s; border: none; }
        .btn-primary { background-color: #007bff; color: #fff; }
        .btn-primary:hover { background-color: #0056b3; }
        .btn-secondary { background-color: #f1b981; color: #000; }
        .btn-secondary:hover { background-color: #e0a95f; }

        .video-card { background-color: #f5f5f5; padding: 15px; border-radius: 12px; margin: 15px 0; }
        .video-container { position: relative; max-width: 560px; width: 100%; border-radius: 12px; overflow: hidden; background-color: #000; margin-top: 10px; }
        .video-container iframe { width: 100%; height: 100%; border-radius: 12px; border: 0; }
        .video-overlay { position: absolute; top:0; left:0; width:100%; height:100%; display:flex; justify-content:center; align-items:center; cursor:pointer; background: rgba(0,0,0,0.25); transition: background 0.3s; }
        .video-overlay:hover { background: rgba(0,0,0,0.4); }
        .overlay-icon { color: white; font-size: 50px; background: rgba(0,0,0,0.5); border-radius:50%; padding:15px; }

        @media (max-width: 1024px) {
            main.content { margin-left: 0; padding: 20px; }
            aside.sidebar { display: none; }
            .video-container { max-width: 100%; }
        }
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-brand">Website Name</div>
    <ul class="nav-menu">
        <li class="nav-item active">
            <a href="/tutor/workplace">
                <i class="fa-solid fa-briefcase"></i>
                Workplace
            </a>
        </li>

        <li class="nav-item">
            <a href="/tutor/analytics">
                <i class="fa-solid fa-chart-line"></i>
                View Analytics
            </a>
        </li>

        <li class="nav-item">
            <a href="/chat/teacher">
                <i class="fa-solid fa-comments"></i>
                Help a Student
            </a>
        </li>
    </ul>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/tutor/profile" class="profile-link">Profile</a>
    </div>
</aside>

<main class="content">
    <div class="card">
        <#if resources?size == 0>
            <p style="font-size:16px;">You don’t have any resources yet.</p>
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
                                <a href="/tutor/resources/${resource.id?c}/article/${article.id?c}" class="btn btn-primary">See Article</a>
                                <a href="/tutor/article/edit/${article.id?c}" class="btn btn-secondary">Edit Article</a>

                                <#if article.video??>
                                    <div class="video-card">
                                        <strong>${article.video.videoTitle}</strong><br>
                                        <small>${article.video.videoDescription!""}</small><br>
                                        <button type="button" class="btn btn-primary" onclick="toggleVideo('video-${article.video.id?c}')">Show / Hide Video</button>
                                        <div id="video-${article.video.id?c}" class="video-container" style="display:none;">
                                            <iframe src="${embedUrl}" title="${article.video.videoTitle}" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                            <div class="video-overlay" onclick="playVideo(this)"><i class="fas fa-play overlay-icon"></i></div>
                                        </div>
                                    </div>
                                    <a href="/tutor/video/edit/${article.video.id?c}" class="btn btn-secondary">Edit Video</a>
                                <#else>
                                    <p>No videos yet for this article.</p>
                                    <a href="/tutor/resources/${resource.id?c}/article/${article.id?c}/upload-video" class="btn btn-primary">Add Video</a>
                                </#if>
                            </div>
                        </#list>
                        <a href="/tutor/resources/${resource.id?c}/article/new" class="btn btn-primary">Add Article</a>
                    <#else>
                        <p>No articles yet for this resource.</p>
                        <a href="/tutor/resources/${resource.id?c}/article/new" class="btn btn-primary">Add Article</a>
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
    function playVideo(overlayEl) {
        const container = overlayEl.closest('.video-container');
        const iframe = container.querySelector('iframe');
        if (!iframe.src.includes("autoplay=1")) { iframe.src += (iframe.src.includes('?') ? '&' : '?') + 'autoplay=1'; }
        overlayEl.style.display = 'none';
    }
</script>

</body>
</html>