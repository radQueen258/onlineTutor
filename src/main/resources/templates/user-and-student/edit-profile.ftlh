<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

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

        /* Sidebar (same as other pages) */
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

        .brand {
            padding: 0 40px;
            font-size: 18px;
            font-weight: 600;
            font-style: italic;
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
            font-size: 18px;
            font-weight: 500;
            margin-bottom: 10px;
        }

        .nav-item i {
            width: 30px;
            font-size: 22px;
            margin-right: 15px;
        }

        .nav-item.active {
            background-color: #82613E;
            margin-right: 15px;
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .sidebar-footer {
            padding: 0 40px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .logout-btn {
            background-color: #dc3545;
            color: #fff;
            border: none;
            padding: 10px 14px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
        }

        .profile-link {
            color: white;
            text-decoration: none;
            font-weight: 500;
        }

        /* Main */
        main {
            flex-grow: 1;
            padding: 40px 60px;
        }

        header {
            background-color: #f1b981;
            height: 260px;
            border-radius: 30px;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 30px;
            margin-bottom: -130px;
        }

        .website-name {
            font-size: 32px;
            font-weight: 800;
            color: #000;
            margin-top: 20px;
        }

        .profile-card {
            background-color: #ffffff;
            max-width: 800px;
            margin: 0 auto 50px auto;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            padding: 40px 60px;
            min-height: 600px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .user-name {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 10px;
            color: #000;
        }

        .info-container {
            width: 100%;
            max-width: 600px;
            margin: 60px 0;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 25px;
            font-size: 16px;
        }

        .info-label {
            font-weight: 700;
            color: #000;
        }

        .info-value {
            color: #333;
            text-align: right;
        }

        form {
            width: 100%;
            max-width: 600px;
            margin-bottom: 40px;
        }

        label {
            font-weight: 600;
            display: block;
            margin-bottom: 10px;
        }

        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
        }

        .checkbox-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
        }

        .btn {
            background-color: #123c5e;
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn:hover {
            background-color: #0d2d46;
        }

        .warning {
            margin-top: 20px;
            font-weight: 600;
            color: #b02a37;
        }

        @media (max-width: 1024px) {
            aside {
                display: none;
            }
            main {
                padding: 20px;
            }
        }

        /* Profile form sections */
        .profile-section {
            width: 100%;
            max-width: 600px;
            background-color: #f8fafc;
            border-radius: 14px;
            padding: 30px 35px;
            margin-bottom: 40px;
            box-shadow: inset 0 0 0 1px #e3e8ef;
        }

        .section-title {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 25px;
            color: #123c5e;
        }

        /* Inputs consistency */
        .profile-section input[type="password"],
        .profile-section select {
            background-color: white;
            border: 1px solid #d0d7e2;
            font-size: 15px;
        }

        /* Checkbox spacing */
        .checkbox-group {
            margin-bottom: 25px;
        }

        .checkbox-group label {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 15px;
        }

        /* Button alignment */
        .profile-section .btn {
            margin-top: 15px;
        }

        .warning {
            background-color: #fdecea;
            padding: 16px 20px;
            border-radius: 12px;
            border: 1px solid #f5c2c7;
            text-align: center;
        }

    </style>
</head>

<body>

<!-- Sidebar -->
<div class="bokeh-container">
    <div class="bokeh bokeh-1"></div>
    <div class="bokeh bokeh-2"></div>
    <div class="bokeh bokeh-3"></div>
    <div class="bokeh bokeh-4"></div>
    <div class="bokeh bokeh-5"></div>
    <div class="bokeh bokeh-6"></div>
    <div class="bokeh bokeh-7"></div>
</div>

<header>
    <div class="header-top">
        <a href="/profile" class="icon-btn">
            <i class="fa-solid fa-arrow-left"></i>
        </a>

        <div class="lang-btn">
            <i class="fa-solid fa-globe"></i>
        </div>
    </div>

    <div class="website-name">WEBSITE NAME</div>
</header>

<!-- Main -->
<main>

    <div class="profile-card">
        <h2 class="user-name">${user.firstName}</h2>

        <div class="info-container">
            <div class="info-row">
                <span class="info-label">Email:</span>
                <span class="info-value">${user.email}</span>
            </div>
        </div>

        <!-- Change Password -->
        <div class="profile-section">
            <h3 class="section-title">Change Password</h3>

            <form method="post" action="/student/update-password">

            <input type="password" name="newPassword" required>
            <button type="submit" class="btn">Change Password</button>
        </form>
        </div>

        <!-- Change Focus -->
        <#if canChangeFocus>
        <div class="profile-section">
            <h3 class="section-title">Study Focus</h3>
            <form id="changeFocusForm" method="post" action="/student/update-focus">
                <label>Choose Grade</label>
                <select name="grade" required>
                    <#list grades as g>
                        <option value="${g}">${g}</option>
                    </#list>
                </select>

                <label>Select Subjects</label>
                <div class="checkbox-group">
                    <#list subjects as s>
                        <label>
                            <input type="checkbox" name="focusAreas" value="${s}"> ${s}
                        </label>
                    </#list>
                </div>

                <button type="submit" class="btn">Update Focus</button>
            </form>
        </div>

            <script>
                document.getElementById("changeFocusForm").addEventListener("submit", function(e) {
                    const confirmed = confirm(
                        "Are you sure you want to change your study focus? This will reset your current study plan and aptitude test."
                    );
                    if (!confirmed) {
                        e.preventDefault();
                    }
                });
            </script>
        <#else>
            <p class="warning">
                You must complete your current study plan before changing your study focus.
            </p>
        </#if>
    </div>

</main>

</body>
</html>
