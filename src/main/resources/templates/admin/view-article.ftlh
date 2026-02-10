<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${article.articleTitle}</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            display: flex;
            min-height: 100vh;
            background-color: #f5f7fb;
            color: #333;
        }

        /* Sidebar – SAME AS RESOURCES */
        aside {
            width: 280px;
            background-color: #0F3456;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
        }

        .brand {
            padding: 0 40px;
            font-size: 18px;
            font-weight: 600;
            font-style: italic;
            margin-bottom: 60px;
        }

        nav {
            flex-grow: 1;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 15px 40px;
            color: white;
            text-decoration: none;
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .nav-item i {
            width: 30px;
            font-size: 22px;
            margin-right: 15px;
        }

        .nav-item.active {
            background-color: #82613E;
            margin-right: 15px;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .sidebar-footer {
            padding: 0 40px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: #fff;
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

        /* Main */
        main {
            flex-grow: 1;
            padding: 40px 60px;
            position: relative;
            max-width: 1200px;
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .back-btn {
            font-size: 22px;
            color: #333;
            text-decoration: none;
        }

        .article-header {
            margin-bottom: 40px;
        }

        .article-title {
            font-size: 42px;
            font-weight: 800;
            margin-bottom: 20px;
        }

        .article-subtitle {
            font-size: 18px;
            font-weight: 700;
            color: #000;
        }

        .article-body {
            max-width: 800px;
            line-height: 1.5;
            font-size: 16px;
        }

        .article-body p {
            margin-bottom: 25px;
        }

        .illustration-container {
            margin: 40px 0;
            display: flex;
            justify-content: flex-start;
            padding-left: 40px;
        }

        .illustration-container img {
            max-width: 400px;
            height: auto;
        }

        /* Watch Video Button */
        .watch-video-btn {
            position: absolute;
            right: 40px;
            top: 350px;
            background-color: #f4c542;
            color: #000;
            padding: 20px 25px;
            border-radius: 20px;
            font-weight: 700;
            width: 220px;
            text-align: center;
            text-decoration: none;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        @media (max-width: 1024px) {
            aside {
                display: none;
            }
            main {
                padding: 20px;
            }
            .watch-video-btn {
                position: static;
                margin-top: 30px;
                width: 100%;
            }
        }
    </style>
</head>
<body>


<!-- Sidebar -->
<aside>
    <div class="brand">Website Name</div>

    <nav>
        <a href="/admin/dashboard" class="nav-item">Workplace</a>
        <a href="/admin/resources/new" class="nav-item active">Create Resource</a>
        <a href="/admin/analytics" class="nav-item">Analysis</a>
    </nav>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/tutor/profile" class="profile-link">Profile</a>
    </div>
</aside>

<main>
    <div class="header-actions">
        <a href="/tutor/resources/${resourceId}/articles" class="back-btn">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
    </div>

    <div class="article-header">
        <h1 class="article-title">${article.articleTitle}</h1>
        <p class="article-subtitle">
            ${article.tutorName.firstName} – ${article.subject}
        </p>
    </div>

    <div class="article-body">
        <p>${article.articleContent}</p>

        <#if article.imageUrl??>
            <div class="illustration-container">
                <img src="${article.imageUrl}" alt="Article Illustration">
            </div>
        </#if>
    </div>

</main>

</div>
</body>
</html>
