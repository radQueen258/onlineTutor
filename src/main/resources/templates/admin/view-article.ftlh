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
            <li><a href="/admin/analytics" style="color:white;text-decoration:none;">View Analytics</a></li>
            <li><a href="/admin/dashboard" style="color:white;text-decoration:none;">Admin Dashboard</a></li>

            <li><a href="/admin/resources/new" style="color:white;text-decoration:none;">Create Resource</a></li>
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

    <#--    Main Content -->
    <main style="flex: 1; padding: 30px; position: relative;">
        <div>
            <a href="/admin/resources/${resourceId}/articles" style="text-decoration: none; color: black;">← Back</a>
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
            <div style="text-align: center; margin: 20px 0;">
                <img src="/images/example-diagram.png" alt="Article Diagram" width="250">
            </div>

            <p>
                More placeholder content for the article... Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            </p>
        </section>

    </main>

</div>
</body>
</html>
