<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            display: flex;
            min-height: 100vh;
            background-color: #f0f4f9;
            color: #333;
        }

        /* Sidebar */
        aside {
            width: 260px;
            background-color: #0F3456;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
        }

        .brand {
            padding: 0 40px;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 60px;
        }

        nav {
            flex-grow: 1;
        }

        .nav-item {
            display: flex;
            align-items: center;
            padding: 15px 40px;
            color: white;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 10px;
            gap: 8px;
        }

        .nav-item i {
            width: 26px;
            margin-right: 12px;
        }

        .nav-item:hover {
            background-color: #123c5e;
        }

        .sidebar-footer {
            padding: 0 40px;
        }

        .logout-btn {
            width: 100%;
            background-color: #dc3545;
            border: none;
            padding: 10px;
            border-radius: 10px;
            color: white;
            font-weight: 600;
            cursor: pointer;
        }

        .profile-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        /* Main */
        main {
            flex-grow: 1;
            padding: 50px 60px;
        }

        .page-title {
            font-size: 26px;
            font-weight: 800;
            margin-bottom: 10px;
            color: #123c5e;
        }

        .page-subtitle {
            font-size: 15px;
            color: #666;
            margin-bottom: 40px;
        }

        /* Cards */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .card {
            background-color: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card h3 {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #123c5e;
        }

        .card p {
            font-size: 15px;
            margin-bottom: 20px;
        }

        .stat {
            font-size: 36px;
            font-weight: 800;
            color: #0F3456;
            margin-bottom: 20px;
        }

        .card a {
            align-self: flex-start;
            text-decoration: none;
        }

        .btn {
            background-color: #123c5e;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0d2d46;
        }

        /* Bottom actions */
        .actions {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        @media (max-width: 1024px) {
            aside {
                display: none;
            }
            main {
                padding: 30px 20px;
            }
        }
    </style>
</head>

<body>

<!-- Sidebar -->
<aside>
    <div class="brand">Website Name</div>

    <nav>
        <a href="/admin/workplace" class="nav-item">
            <i class="fa-solid fa-briefcase"></i>
            Workplace
        </a>
        <a href="/admin/aptitude-results" class="nav-item">
            <i class="fa-solid fa-chart-line"></i>
            Aptitude Results
        </a>
    </nav>

    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/tutor/profile" class="profile-link">Profile</a>
    </div>
</aside>

<!-- Main -->
<main>

    <h1 class="page-title">Hello, ${adminName}</h1>
    <p class="page-subtitle">
        Here’s a quick overview of what’s going on in the system.
    </p>

    <div class="dashboard-grid">

        <div class="card">
            <h3>Students</h3>
            <div class="stat">${totalStudents}</div>
            <a href="/admin/users/students">
                <button class="btn">Manage Students</button>
            </a>
        </div>

        <div class="card">
            <h3>Tutors</h3>
            <div class="stat">${totalTutors}</div>
            <a href="/admin/users/tutors">
                <button class="btn">Manage Tutors</button>
            </a>
        </div>

        <div class="card">
            <h3>Articles</h3>
            <div class="stat">${totalArticles}</div>
            <a href="/admin/articles">
                <button class="btn">Manage Articles</button>
            </a>
        </div>

        <div class="card">
            <h3>Videos</h3>
            <div class="stat">${totalVideos}</div>
            <a href="/admin/videos">
                <button class="btn">Manage Videos</button>
            </a>
        </div>

    </div>

    <div class="actions">
        <a href="/admin/statistics">
            <button class="btn">
                <i class="fa-solid fa-chart-pie"></i> View Detailed Statistics
            </button>
        </a>
    </div>

</main>

</body>
</html>
