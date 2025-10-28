<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tutor Workplace</title>
</head>
<body>

<h2>Welcome, ${tutorName}!</h2>

<p>
    <a href="/tutor/article/new">Create New Article</a> |
    <a href="/tutor/analytics">View Analytics</a>
</p>

<#if articles?size == 0>
    <p>You haven’t created any articles yet.</p>
<#else>
    <#list articles as article>
        <div style="margin-bottom: 25px; border-bottom: 1px solid #ccc; padding-bottom: 10px;">
            <h3>${article.articleTitle}</h3>
            <p><strong>Subject:</strong> ${article.subject}</p>

            <#if article.video??>
                <#list article.video as video>
                    <div style="margin: 12px 0; padding: 10px; background: #f8f8f8; border-radius: 8px;">
                        <strong>${video.videoTitle}</strong><br>
                        <small>${video.videoDescription!""}</small>

                        <#-- Extract the YouTube video ID -->
                        <#assign videoId = (video.videoUrl?matches("v=([^&]+)"))?then(video.videoUrl?replace(".*v=([^&]+).*", "$1"), video.videoUrl?replace(".*/([^/?]+)$", "$1")) />

                        <br>
                        <button type="button" onclick="toggleVideo('video-${video.id}')"
                                style="margin-top:8px;padding:5px 10px;border:none;background:#007bff;color:white;border-radius:6px;cursor:pointer;">
                            Show / Hide Video
                        </button>

                        <div id="video-${video.id}" style="display:none;margin-top:10px;">
                            <iframe width="420" height="236"
                                    src="https://www.youtube.com/embed/${videoId}"
                                    title="${video.videoTitle}"
                                    frameborder="0"
                                    allowfullscreen>
                            </iframe>
                        </div>
                    </div>
                </#list>
            <#else>
                <p>No videos yet for this article.</p>
            </#if>

            <p><a href="/tutor/article/${article.id}/upload-video">Add Video</a></p>
        </div>
    </#list>
</#if>

<script>
    function toggleVideo(id) {
        const el = document.getElementById(id);
        if (!el) return;
        el.style.display = (el.style.display === 'none' || el.style.display === '') ? 'block' : 'none';
    }
</script>


</body>
</html>
