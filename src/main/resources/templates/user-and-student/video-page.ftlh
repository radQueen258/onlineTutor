<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Video</title>
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: #f0f4f8;
            min-height: 100vh;
            display: flex;
        }

        /* Sidebar */
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
            transition: 0.2s ease;
            gap: 8px;
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
            gap: 8px;
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
        /* Main */
        main { flex-grow:1; padding:40px 60px; overflow-y:auto; }

        header { display:flex; align-items:center; justify-content:space-between; margin-bottom:40px; }
        .header-left { display:flex; align-items:center; gap:20px; }
        .back-btn { font-size:22px; color:#000; text-decoration:none; }

        h1 { font-size:32px; font-weight:700; color:#000; margin-bottom:30px; }

        /* Video Container */
        .video-container {
            position: relative;
            max-width: 900px;
            width: 100%;
            aspect-ratio: 16 / 9;
            margin: 30px auto; /* center horizontally */
            border-radius: 12px;
            overflow: hidden;
            background: #000;
            box-shadow: 0 15px 40px rgba(0,0,0,0.35);
        }

        /* Make iframe fill container */
        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }

        /* Overlay Play/Pause */
        .video-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;

            display: flex;
            justify-content: center;
            align-items: center;

            background: rgba(0,0,0,0.25);
            cursor: pointer;

            transition: background 0.3s ease;
            z-index: 2;
        }

        .video-overlay:hover {
            background: rgba(0,0,0,0.45);
        }

        /* Play/Pause Icon */
        .overlay-icon {
            color: white;
            font-size: 48px;
            background: rgba(0,0,0,0.55);
            border-radius: 50%;
            padding: 18px;
            transition: transform 0.2s ease;
        }

        .video-overlay:hover .overlay-icon {
            transform: scale(1.1);
        }

        /* Video Info */

        .tutor-name { font-size:20px; font-weight:700; margin-bottom:15px; }


        /* Layout */
        .video-layout{
            display:flex;
            gap:40px;
            align-items:flex-start;
        }

        /* Video side */
        .video-section{
            flex:2;
        }

        /* Video container improvement */
        .video-container{
            border-radius:16px;
            overflow:hidden;
            background:black;
            box-shadow:0 20px 45px rgba(0,0,0,0.25);
        }

        /* Right info panel */
        .video-info-card{

            flex:1;

            background:white;

            padding:30px;

            border-radius:14px;

            box-shadow:0 10px 30px rgba(0,0,0,0.08);

            display:flex;

            flex-direction:column;

            gap:25px;

        }

        /* Tutor block */
        .tutor-block{

            display:flex;

            align-items:center;

            gap:15px;

        }

        /* Avatar */
        .tutor-avatar{

            width:55px;
            height:55px;

            border-radius:50%;

            background:#0F3456;

            display:flex;

            align-items:center;

            justify-content:center;

            color:white;

            font-size:22px;

        }

        /* Tutor name */
        .tutor-name{

            font-size:18px;

            font-weight:700;

            color: black;

        }

        /* Tutor role */
        .tutor-role{

            font-size:14px;

            color:#888;

        }

        /* Description */
        .video-description h3{

            margin-bottom:10px;

        }

        .video-description p{

            line-height:1.6;

            color:#444;

        }

    </style>
</head>
<body>

<!-- Sidebar -->
<aside>
    <div class="brand">Online Tutor</div>

    <nav>
        <a href="/dashboard" class="nav-item">
            <i class="fa-solid fa-house"></i> Dashboard
        </a>

        <a href="/study-plan" class="nav-item">
            <i class="fa-solid fa-book-open"></i> Study Plan
        </a>

        <a href="/resources" class="nav-item active">
            <i class="fa-solid fa-play"></i> Resources
        </a>

        <a href="/chat/student" class="nav-item">
            <i class="fa-solid fa-comments"></i> Contact a Tutor
        </a>

        <a href="/articles/translations" class="nav-item">
            <i class="fa-solid fa-globe"></i> Translations
        </a>
    </nav>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/profile" class="profile-link">Profile</a>
    </div>
</aside>

<!-- Main -->
<main>

    <header>
        <div class="header-left">
            <a href="/resources/${resourceId?c}/articles-and-videos" class="back-btn">
                <i class="fa-solid fa-arrow-left"></i>
            </a>
            <h1>${video.videoTitle! "Video Lesson"}</h1>
        </div>
    </header>

    <div class="video-layout">

        <#if video??>
            <div class="video-section">

                <div class="video-container" id="videoContainer">
                    <iframe
                            src="${embedUrl}"
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                            allowfullscreen>
                    </iframe>

                    <div class="video-overlay" id="videoOverlay">
                        <i class="fas fa-play overlay-icon"></i>
                    </div>
                </div>

            </div>
        </#if>


        <aside class="video-info-card">

            <#if video.tutorName??>
                <div class="tutor-block">

                    <div class="tutor-avatar">
                        <i class="fa-solid fa-user"></i>
                    </div>

                    <div>
                        <div class="tutor-name">
                            ${video.tutorName.firstName}
                        </div>

                        <div class="tutor-role">
                            Tutor
                        </div>
                    </div>

                </div>
            </#if>

            <div class="video-description">
                <h3>Lesson Description</h3>

                <p>
                    ${video.videoDescription!"No description available."}
                </p>
            </div>

        </aside>

    </div>

</main>

<script>

    const overlay = document.getElementById("videoOverlay");

    overlay.addEventListener("click", function() {

        const iframe = document.querySelector(".video-container iframe");

        if(!iframe.src.includes("autoplay=1")){
            iframe.src += "?autoplay=1";
        }

        overlay.style.display = "none";
    });

</script>

</body>
</html>