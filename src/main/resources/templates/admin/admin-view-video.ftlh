<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registered Users</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">


    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Inter', system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
            display: flex;
            min-height: 100vh;
            background-color: #f0f4f9;
            color: #333;
        }

        aside {
            width: 260px;
            background-color: #0F3456;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 30px 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
        }

        .brand {
            padding: 0 40px;
            font-size: 18px;
            font-weight: 700;
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
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .nav-item i {
            width: 26px;
            margin-right: 12px;
        }

        .nav-item:hover {
            background-color: #123c5e;
        }

        .sidebar-footer {
            padding: 0 40px;
        }

        .logout-btn {
            margin-top: 20px;
            background: #dc3545;
            border: none;
            color: white;
            padding: 8px;
            border-radius: 6px;
            width: 100%;
        }

        .content {
            flex-grow: 1;
            padding: 50px 60px;
        }

        .card {
            background: white;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        h1, h2 {
            color: #0f2b4c;
            margin-top: 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th {
            background: #0f2b4c;
            color: white;
            padding: 10px;
            text-align: left;
            line-height: 1.4;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #e0e0e0;
            line-height: 1.4;
        }

        .delete-btn {
            background: #dc3545;
            border: none;
            color: white;
            padding: 6px 10px;
            border-radius: 6px;
            cursor: pointer;
        }

        .back-link {
            text-decoration: none;
            background: #0f2b4c;
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
        }
    </style>
</head>

<body>
<div style="display: flex; height: 100vh;">
    <!-- Sidebar -->
    <aside>
        <div class="brand">Website Name</div>

        <nav>
            <a href="/admin/dashboard" class="nav-item">
                <i class="fa-solid fa-briefcase"></i>
                Workplace
            </a>
            <a href="/admin/aptitude-results" class="nav-item">
                Aptitude Results
            </a>
        </nav>

        <div class="sidebar-footer">
            <form action="/logout" method="post">
                <button type="submit" class="logout-btn">Logout</button>
            </form>
            <a href="/admin/profile" class="profile-link">Profile</a>
        </div>
    </aside>

    <!-- Main Content -->
    <main>

        <header>
            <div class="header-left">
                <a href="/resources/${resourceId}/articles-and-videos" class="back-btn">
                    <i class="fa-solid fa-arrow-left"></i>
                </a>
                <h1>Video</h1>
            </div>
        </header>

        <div class="video-container">
            <video controls>
                <source src="${video.videoUrl}" type="video/mp4">
                Your browser does not support the video tag.
            </video>
        </div>

        <#if video.tutorName??>
            <section class="content-info">
                <div class="tutor-name">
                    ${video.tutorName.firstName} – ${video.videoTitle}
                </div>
                <p class="description">
                    ${video.videoDescription}
                </p>
            </section>
        <#else>
            <p>No video information available.</p>
        </#if>

    </main>
</div>
</body>
</html>
