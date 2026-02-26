<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${article.articleTitle}</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        /* KEEPING YOUR ORIGINAL CSS EXACTLY AS IS */
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Inter', sans-serif; }
        body { display:flex; min-height:100vh; background:#f5f7fb; color:#333; }

        aside { width:280px; background:#0F3456; color:white; display:flex; flex-direction:column; padding:40px 0; border-top-right-radius:20px; border-bottom-right-radius:20px; }
        .brand { padding:0 40px; font-size:18px; font-weight:600; font-style:italic; margin-bottom:60px; }
        nav { flex-grow:1; }
        .nav-item { display:flex; align-items:center; padding:15px 40px; color:white; text-decoration:none; font-size:18px; font-weight:500; margin-bottom:10px; }
        .nav-item i { width:30px; font-size:22px; margin-right:15px; }
        .nav-item.active { background:#82613E; margin-right:15px; border-top-right-radius:10px; border-bottom-right-radius:10px; }
        .sidebar-footer { padding:0 40px; display:flex; flex-direction:column; gap:20px; }
        .logout-btn { background:#dc3545; color:#fff; border:none; padding:10px 14px; border-radius:10px; font-weight:600; cursor:pointer; width:100%; }
        .profile-link { color:white; text-decoration:none; font-weight:500; }

        main { flex-grow:1; padding:40px 60px; position:relative; max-width:1200px; }

        .header-actions { display:flex; justify-content:space-between; align-items:center; margin-bottom:30px; }

        .back-btn { font-size:22px; color:#333; text-decoration:none; }

        .translate-wrapper { position:relative; }
        .globe-btn {
            font-size:22px;
            cursor:pointer;
            background:#fff;
            padding:10px 14px;
            border-radius:50%;
            box-shadow:0 4px 12px rgba(0,0,0,0.1);
        }

        .language-dropdown {
            position:absolute;
            right:0;
            top:50px;
            background:#fff;
            border-radius:12px;
            box-shadow:0 10px 25px rgba(0,0,0,0.15);
            display:none;
            flex-direction:column;
            min-width:180px;
            z-index:1000;
        }

        .language-option {
            padding:12px 16px;
            cursor:pointer;
            font-weight:500;
        }

        .language-option:hover {
            background:#f5f7fb;
        }

        .article-header { margin-bottom:40px; }
        .article-title { font-size:42px; font-weight:800; margin-bottom:20px; }
        .article-subtitle { font-size:18px; font-weight:700; color:#000; }

        .article-layout { display:flex; gap:50px; align-items:flex-start; }
        .article-text { flex:2; line-height:1.7; font-size:16px; }
        .article-image { flex:1; position:sticky; top:120px; }
        .article-image img { width:100%; max-width:350px; border-radius:16px; box-shadow:0 10px 25px rgba(0,0,0,0.1); }

        .watch-video-btn {
            position:absolute;
            right:40px;
            top:350px;
            background:#f4c542;
            color:#000;
            padding:20px 25px;
            border-radius:20px;
            font-weight:700;
            width:220px;
            text-align:center;
            text-decoration:none;
            box-shadow:0 4px 10px rgba(0,0,0,0.1);
        }

        /* Modal */
        .modal-overlay {
            position:fixed;
            top:0; left:0;
            width:100%; height:100%;
            background:rgba(0,0,0,0.5);
            display:none;
            justify-content:center;
            align-items:center;
            z-index:2000;
        }

        .modal {
            background:#fff;
            padding:30px;
            border-radius:20px;
            width:400px;
            text-align:center;
            box-shadow:0 10px 30px rgba(0,0,0,0.2);
        }

        .modal h3 {
            margin-bottom:20px;
        }

        .modal a {
            display:inline-block;
            margin-top:15px;
            padding:10px 20px;
            background:#0F3456;
            color:#fff;
            border-radius:10px;
            text-decoration:none;
            font-weight:600;
        }

    </style>
</head>

<body>

<!-- Sidebar -->
<aside>
    <div class="brand">Website Name</div>
    <nav>
        <a href="/dashboard" class="nav-item"><i class="fa-solid fa-house"></i> Dashboard</a>
        <a href="/study-plan" class="nav-item"><i class="fa-solid fa-book-open"></i> Study Plan</a>
        <a href="/resources" class="nav-item active"><i class="fa-solid fa-play"></i> Resources</a>
        <a href="/articles/translations" class="nav-item"><i class="fa-solid fa-globe"></i> Translations</a>
    </nav>
    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/profile" class="profile-link">Profile</a>
    </div>
</aside>

<main>

    <div class="header-actions">
        <a href="/resources/${resourceId?c}/articles-and-videos" class="back-btn">
            <i class="fa-solid fa-arrow-left"></i>
        </a>

        <div class="translate-wrapper">
            <div class="globe-btn" onclick="toggleDropdown()">
                <i class="fa-solid fa-globe"></i>
            </div>

            <div class="language-dropdown" id="languageDropdown">
                <div class="language-option" onclick="requestTranslation('en')">English</div>
                <div class="language-option" onclick="requestTranslation('ru')">Russian</div>
                <div class="language-option" onclick="requestTranslation('pt')">Portuguese</div>
                <div class="language-option" onclick="requestTranslation('bantu')">Bantu</div>
            </div>
        </div>
    </div>

    <div class="article-header">
        <h1 class="article-title">${article.articleTitle}</h1>
        <p class="article-subtitle">
            ${article.tutorName.firstName} – ${article.subject}
        </p>
    </div>

    <div class="article-layout">
        <div class="article-text">
            ${article.articleContent?no_esc}
        </div>

        <#if article.imageUrl?? && article.imageUrl?has_content>
            <div class="article-image">
                <img src="${article.imageUrl}" alt="Article Illustration">
            </div>
        </#if>
    </div>

</main>

<!-- Modal -->
<div class="modal-overlay" id="translationModal">
    <div class="modal">
        <h3>Translation Ready</h3>
        <p>Your translated article is available.</p>
        <a id="translationLink" href="#">View Translation</a>
    </div>
</div>

<script>
    function toggleDropdown() {
        const dropdown = document.getElementById("languageDropdown");
        dropdown.style.display = dropdown.style.display === "flex" ? "none" : "flex";
    }

    function requestTranslation(language) {
        fetch("/articles/${article.id?c}/translate?language=" + language, {
            method: "POST"
        })
            .then(response => response.text())
            .then(url => {
                document.getElementById("translationLink").href = url;
                document.getElementById("translationModal").style.display = "flex";
            });
    }
</script>

</body>
</html>