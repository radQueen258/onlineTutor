<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Video</title>
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * { margin:0; padding:0; box-sizing:border-box; font-family:'Inter', sans-serif; }

        body {
            display: flex;
            height: 100vh;
            background-color: #F4F7FA;
            overflow: hidden;
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
        .brand { padding:0 40px; font-size:18px; font-weight:600; font-style:italic; margin-bottom:60px; }
        nav { flex-grow:1; }
        .nav-item { display:flex; align-items:center; padding:15px 40px; color:white; text-decoration:none; font-size:18px; font-weight:500; margin-bottom:10px; transition:0.2s; }
        .nav-item i { width:30px; font-size:22px; margin-right:15px; }
        .nav-item.active { background-color:#82613E; margin-right:15px; border-radius:10px; }
        .sidebar-footer { padding:0 40px; display:flex; flex-direction:column; gap:20px; }
        .logout-btn { background-color:#dc3545; color:white; border:none; padding:10px 14px; border-radius:10px; font-weight:600; cursor:pointer; width:100%; }
        .profile-link { color:white; text-decoration:none; font-weight:500; }

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
        .content-info { max-width:900px; }
        .tutor-name { font-size:20px; font-weight:700; margin-bottom:15px; }
        .description { font-size:16px; line-height:1.6; color:#333; }

    </style>
</head>
<body>

<!-- Sidebar -->
<aside>
    <div class="brand">Website Name</div>
    <nav>
        <a href="/dashboard" class="nav-item"><i class="fa-solid fa-house"></i>Dashboard</a>
        <a href="/study-plan" class="nav-item"><i class="fa-solid fa-book-open"></i>Study Plan</a>
        <a href="/resources" class="nav-item active"><i class="fa-solid fa-play"></i>Resources</a>
        <a href="/exam-trends" class="nav-item"><i class="fa-solid fa-chart-pie"></i>Exam Trends</a>
    </nav>
    <div class="sidebar-footer">
        <form action="/logout" method="post"><button class="logout-btn">Logout</button></form>
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
            <h1>Video</h1>
        </div>
    </header>

    <#if video??>
        <div class="video-container" id="videoContainer">

            <iframe
                    src="${embedUrl}"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                    allowfullscreen>
            </iframe>

            <div class="video-overlay" id="videoOverlay">
                <i class="fas fa-play overlay-icon" id="overlayIcon"></i>
            </div>

        </div>
    <#else>
        <p>Video not available</p>
    </#if>

    <#if video.tutorName??>
        <section class="content-info">
            <div class="tutor-name">
                ${video.tutorName.firstName} – ${video.videoTitle}
            </div>
            <p>${embedUrl}</p>
            <p class="description">${video.videoDescription}</p>
        </section>
    <#else>
        <p>No video information available.</p>
    </#if>
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