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
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 30px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.35);
            background-color:#000;
        }

        iframe {
            width: 100%;
            height: 100%;
            border:0;
        }

        /* Play/Pause Button Overlay */
        .video-overlay {
            position: absolute;
            top:0; left:0;
            width:100%; height:100%;
            display:flex;
            justify-content:center;
            align-items:center;
            cursor:pointer;
            transition: background 0.3s;
            background: rgba(0,0,0,0.25);
        }
        .video-overlay:hover { background: rgba(0,0,0,0.4); }
        .overlay-icon {
            color: white;
            font-size: 50px;
            background: rgba(0,0,0,0.5);
            border-radius:50%;
            padding:15px;
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
            <!-- iframe will be inserted dynamically -->
            <div class="video-overlay" id="videoOverlay">
                <i class="fas fa-play overlay-icon" id="overlayIcon"></i>
            </div>
        </div>
    <#else>
        <p>Video not available</p>
    </#if>

    <#if video.tutorName??>
        <section class="content-info">
            <div class="tutor-name">${video.tutorName.firstName} – ${video.videoTitle}</div>
            <p class="description">${video.videoDescription}</p>
        </section>
    <#else>
        <p>No video information available.</p>
    </#if>
</main>

<script>
    // Convert any YouTube URL to embed URL
    function getYouTubeEmbedUrl(url) {
        if(!url) return null;
        url = url.split('?')[0]; // remove query params
        let videoId = null;

        const shortMatch = url.match(/youtu\.be\/([a-zA-Z0-9_-]+)/);
        const longMatch = url.match(/v=([a-zA-Z0-9_-]+)/);

        if(shortMatch) videoId = shortMatch[1];
        else if(longMatch) videoId = longMatch[1];

        return videoId ? `https://www.youtube.com/embed/${video.id?c}?enablejsapi=1` : null;
    }

    const videoUrlFromDB = "${video.videoUrl}";
    const embedUrl = getYouTubeEmbedUrl(videoUrlFromDB);

    if(embedUrl) {
        const container = document.getElementById('videoContainer');

        // Insert iframe dynamically (keep overlay outside iframe)
        const iframe = document.createElement('iframe');
        iframe.id = 'youtubeVideo';
        iframe.src = embedUrl;
        iframe.frameBorder = 0;
        iframe.allow = "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture";
        iframe.allowFullscreen = true;
        iframe.style.width = "100%";
        iframe.style.height = "100%";
        iframe.style.borderRadius = "12px";

        container.prepend(iframe);
    }

    // Load YouTube iframe API
    let tag = document.createElement('script');
    tag.src = "https://www.youtube.com/iframe_api";
    let firstScriptTag = document.getElementsByTagName('script')[0];
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

    let player;
    function onYouTubeIframeAPIReady() {
        player = new YT.Player('youtubeVideo');
    }

    // Overlay play/pause control
    const overlay = document.getElementById('videoOverlay');
    const icon = document.getElementById('overlayIcon');

    overlay.addEventListener('click', () => {
        if (!player) return;
        const state = player.getPlayerState();
        if (state === YT.PlayerState.PLAYING) {
            player.pauseVideo();
            icon.classList.remove('fa-pause');
            icon.classList.add('fa-play');
        } else {
            player.playVideo();
            icon.classList.remove('fa-play');
            icon.classList.add('fa-pause');
        }
    });
</script>

</body>
</html>