<!DOCTYPE html>
<html lang="en" xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title th:text="${article.title}">Article Page</title>
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

    <!-- Main Content -->
    <main style="flex: 1; padding: 30px; position: relative;">
        <!-- Back button -->
        <div>
            <a href="/resources" style="text-decoration: none; color: black;">← Back</a>
        </div>

        <!-- Article Title and Tutor Info -->
        <h1 th:text="${article.title}">Article’s Topic</h1>
        <p><strong th:text="${article.tutorName}">Tutor Name</strong> -
            <span th:text="${article.subject}">Subject</span></p>

        <!-- Article Body -->
        <section style="max-width: 800px;">
            <p th:text="${article.content}">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec dictum...
            </p>

            <!-- Example image -->
            <div style="text-align: center; margin: 20px 0;">
                <img src="/images/example-diagram.png" alt="Article Diagram" width="250">
            </div>

            <p>
                More placeholder content for the article... Lorem ipsum dolor sit amet, consectetur adipiscing elit.
            </p>
        </section>

        <!-- Watch Related Video Button -->
        <div style="position: absolute; right: 60px; top: 150px;">
            <a th:href="@{/resources/video/{id}(id=${article.video.id})}"
               style="display: inline-block; background-color: goldenrod; color: black;
                      padding: 10px 20px; border-radius: 8px; text-decoration: none; font-weight: bold;">
                Watch Related Video
            </a>
        </div>
    </main>
</div>
</body>
</html>
