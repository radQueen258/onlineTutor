<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Resources</title>
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

    <!-- Main Content -->
    <main style="flex: 1; padding: 30px;">
        <h1>Resources</h1>
        <div style="margin-top: 40px; border: 1px solid #ccc; border-radius: 6px; padding: 20px; background-color: #f9f9f9;">
            <table style="width: 100%;">
                <thead>
                <tr>
                    <th style="text-align: left;">Major Topic</th>
                    <th style="text-align: left;">Articles & Videos</th>
                </tr>
                </thead>
                <tbody>
                <#list resources as resource>
                    <tr>
                        <td>
                            <a href="/resources/article/${resource.id}"
                               style="color: black; text-decoration: none;">
                                ${resource.topicName}
                            </a>
                        </td>
                        <td>
                            <a href="/resources/${resource.id}/articles-and-videos"
                               style="color: blue;">Click Here</a>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>
