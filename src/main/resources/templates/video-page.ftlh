<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Video Page</title>
</head>

<body>
<div style="display: flex; height: 100vh;">
    <!-- Sidebar -->
    <nav style="width: 200px; background-color: #1f3a5f; color: white; padding: 20px;">
        <h3>Website Name</h3>
        <ul style="list-style: none; padding: 0;">
            <li style="margin-bottom: 10px;">
                <a href="/dashboard" style="color: white; text-decoration: none;">Dashboard</a>
            </li>
            <li style="margin-bottom: 10px;">
                <a href="/study-plan" style="color: white; text-decoration: none;">Study Plan</a>
            </li>
            <li style="margin-bottom: 10px;">
                <a href="/resources" style="color: burlywood; text-decoration: none;">Resources</a>
            </li>
            <li style="margin-bottom: 10px;">
                <a href="/exam-trends" style="color: white; text-decoration: none;">Exam Trends</a>
            </li>
        </ul>

        <div style="margin-top: auto;">
            <a href="/profile" style="color: white;">Profile</a>
        </div>
    </nav>

    <!-- Main Video Content -->
    <main style="flex: 1; padding: 40px;">
        <a href="/resources" style="text-decoration: none; color: black;">← Back</a>
        <h1>Video Topic</h1>

        <div style="margin-top: 20px;">
            <video width="640" height="360" controls>
                <source src="${video.videoUrl}" type="video/mp4">
                Your browser does not support the video tag.
            </video>
        </div>

        <div style="margin-top: 20px;">
            <p><strong>${video.tutorName.firstName} - ${video.videoTitle}</strong></p>
            <p>${video.videoDescription}</p>
        </div>
    </main>
</div>
</body>
</html>
