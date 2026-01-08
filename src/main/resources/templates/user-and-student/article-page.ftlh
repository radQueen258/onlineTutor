<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${article.articleTitle}</title>
</head>
<body>
<div style="display: flex; height: 100vh;">
    <!-- Sidebar -->
    <nav style="width: 200px; background-color: #1f3a5f; color: white; padding: 20px;">
        <h3>Website Name</h3>
        <ul style="list-style: none; padding: 0;">
            <li><a href="/dashboard" style="color: white; text-decoration: none;">Dashboard</a></li>
            <li><a href="/study-plan" style="color: white; text-decoration: none;">Study Plan</a></li>
            <li><a href="/resources" style="color: burlywood; text-decoration: none;">Resources</a></li>
            <li><a href="/exam-trends" style="color: white; text-decoration: none;">Exam Trends</a></li>
        </ul>
        <div style="margin-top: auto;">
            <a href="/profile" style="color: white;">Profile</a>
        </div>
    </nav>

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

    <br>

<#--    Main Content -->
    <main style="flex: 1; padding: 30px; position: relative;">
        <div>
            <a href="/resources/${resourceId}/articles-and-videos" style="text-decoration: none; color: black;">← Back</a>
        </div>

        <!-- Article Title and Tutor Info -->
        <h1>${article.articleTitle}</h1>
        <p>
            <strong>${article.tutorName.firstName}</strong> -
            <span>${article.subject}</span>
        </p>

        <!-- Article Body -->
        <section style="max-width: 800px;">
            <p>${article.articleContent}</p>

            <!-- Example image -->
            <#if article.imageUrl??>
            <div style="text-align: center; margin: 20px 0;">
                <img src="${article.imageUrl}" alt="Article Diagram" width="250">
            </div>
            </#if>

            <p>
                More placeholder content for the article... Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            </p>
        </section>

        <!-- Watch Related Video Button -->
        <#if article.video??>
        <div style="position: absolute; right: 60px; top: 150px;">
            <a href="/resources/${resourceId}/video/${article.video.id}"
               style="display: inline-block; background-color: goldenrod; color: black;
                  padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: bold;">
                Watch Related Video
            </a>
        </div>
        </#if>
    </main>

</div>
</body>
</html>
