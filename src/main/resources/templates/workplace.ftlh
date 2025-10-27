<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tutor Workplace</title>
</head>
<body>

<h2>Welcome, ${user.firstName}!</h2>

<p>
    <a href="/tutor/article/new">Create New Article</a> |
    <a href="/tutor/analytics">View Analytics</a>
</p>

<#if articles?size == 0>
    <p>You haven’t created any articles yet.</p>
<#else>
    <#list articles as article>
        <div style="margin-bottom: 20px; border-bottom: 1px solid #ccc;">
            <h3>${article.title}</h3>
            <p><strong>Subject:</strong> ${article.subject}</p>

            <#if article.videos?? && article.videos?size > 0>
                <ul>
                    <#list article.videos as video>
                        <li>
                            <strong>${video.videoTitle}</strong> —
                            <a href="${video.videoUrl}" target="_blank">Watch on YouTube</a>
                        </li>
                    </#list>
                </ul>
            <#else>
                <p>No videos yet for this article.</p>
            </#if>

            <a href="/tutor/article/${article.id}/upload-video">Add Video</a>
        </div>
    </#list>
</#if>

</body>
</html>
