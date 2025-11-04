<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tutor - Resources' Articles</title>
</head>
<body>

<!-- Sidebar -->
<div style="width:220px;float:left;background:#0f2b4c;color:white;height:100vh;">
    <h3 style="padding:10px;">Website Name</h3>
    <ul style="list-style:none;padding:0;">
        <li><a href="/tutor/article/new" style="color:white;text-decoration:none;">Create New Article</a></li>
        <li><a href="/tutor/analytics" style="color:white;text-decoration:none;">View Analytics</a></li>

        <li><a href="/tutor/resources/new" style="color:white;text-decoration:none;">Create Resource</a></li>
    </ul>

    <form action="/logout" method="post">
        <button type="submit" style="
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;">
            Logout
        </button>
    </form>
</div>

<div style="margin-left:240px;padding:20px;">

    <#if resources?size == 0>
        <p>You don’t have any resources yet.</p>
        <li><a href="/tutor/resources/new" style="color:white;text-decoration:none;">Create Resource</a></li>
    <#else>
        <#list resources as resource>
            <div style="margin-bottom: 30px;">
                <h2 style="border-bottom:1px solid #ccc;">${resource.topicName}</h2>

                <#if resource.articles?? && numArticles > 0>
                    <#list resource.article as article>
                        <div style="margin-bottom: 25px; border-bottom: 1px solid #ccc; padding-bottom: 10px;">
                            <h3>${article.articleTitle}</h3>
                            <p><strong>Subject:</strong> ${article.subject}</p>

                            <#if article.video??>
                                <div style="margin: 12px 0; padding: 10px; background: #f8f8f8; border-radius: 8px;">
                                    <strong>${article.video.videoTitle}</strong><br>
                                    <small>${article.video.videoDescription!""}</small>

                                    <#-- Extract YouTube video ID -->
                                    <#assign videoUrl = article.video.videoUrl>
                                    <#assign videoId = (videoUrl?matches("v=([^&]+)"))?then(
                                    videoUrl?replace(".*v=([^&]+).*", "$1"),
                                    videoUrl?replace(".*/([^/?]+)$", "$1")
                                    ) />

                                    <br>
                                    <button type="button" onclick="toggleVideo('video-${article.video.id}')"
                                            style="margin-top:8px;padding:5px 10px;border:none;background:#007bff;color:white;border-radius:6px;cursor:pointer;">
                                        Show / Hide Video
                                    </button>

                                    <div id="video-${article.video.id}" style="display:none;margin-top:10px;">
                                        <iframe width="420" height="236"
                                                src="https://www.youtube.com/embed/${videoId}"
                                                title="${article.video.videoTitle}"
                                                frameborder="0"
                                                allowfullscreen>
                                        </iframe>
                                    </div>
                                </div>
                            <#else>
                                <p>No videos yet for this article.</p>
                            </#if>

                            <p><a href="/tutor/article/${article.id}/upload-video">Add Video</a></p>
                        </div>
                    </#list>
                <#else>
                    <p>No articles yet for this resource.</p>
<#--                    I MUST WRITE HERE A LINK TO CREATE AN ARTICLE-->
                </#if>
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

</div>
</body>
</html>
