<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body, html {
            min-height: 100%;
            background-color: #f0f4f9;
            overflow-x: hidden;
            color: #333;
        }

        /* Background Bokeh */
        .bokeh-container {
            position: fixed;
            inset: 0;
            z-index: -1;
            pointer-events: none;
        }

        .bokeh {
            position: absolute;
            border-radius: 50%;
            filter: blur(20px);
            opacity: 0.4;
        }

        .bokeh-1 { width: 60px; height: 60px; background: #9b86bd; top: 45%; left: 5%; }
        .bokeh-2 { width: 40px; height: 40px; background: #88c488; top: 60%; left: 10%; }
        .bokeh-3 { width: 30px; height: 30px; background: #f4d03f; top: 75%; left: 15%; }
        .bokeh-4 { width: 35px; height: 35px; background: #5d8aa8; top: 85%; left: 18%; }
        .bokeh-5 { width: 45px; height: 45px; background: #f4d03f; top: 40%; right: 15%; }
        .bokeh-6 { width: 30px; height: 30px; background: #5d8aa8; top: 52%; right: 12%; }
        .bokeh-7 { width: 70px; height: 70px; background: #e74c3c; top: 70%; right: 8%; }

        /* Header */
        header {
            background-color: #f1b981;
            height: 350px;
            border-bottom-left-radius: 40px;
            border-bottom-right-radius: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 20px;
        }

        .header-top {
            width: 95%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .icon-btn, .lang-btn {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #333;
        }

        .lang-btn {
            background: #fff;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .website-name {
            font-size: 32px;
            font-weight: 800;
            margin-top: 20px;
            letter-spacing: 1px;
        }

        /* Main */
        main {
            display: flex;
            justify-content: center;
        }

        .profile-card {
            background: #fff;
            width: 90%;
            max-width: 800px;
            margin: -180px auto 60px;
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
            margin-bottom: 40px;
            color: #000;
        }

        .info-container {
            width: 100%;
            max-width: 600px;
            margin-bottom: 60px;
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
            text-align: right;
        }

        /* Profile sections (forms unchanged) */
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
            border: 1px solid #d0d7e2;
            margin-bottom: 20px;
            font-size: 15px;
        }

        .checkbox-group {
            margin-bottom: 25px;
        }

        .checkbox-group label {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 15px;
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
            background-color: #fdecea;
            padding: 16px 20px;
            border-radius: 12px;
            border: 1px solid #f5c2c7;
            font-weight: 600;
            color: #b02a37;
            text-align: center;
            max-width: 600px;
        }

        @media (max-width: 600px) {
            .profile-card {
                padding: 30px 20px;
                margin-top: -150px;
            }
            .website-name {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

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
        <a href="/admin/profile" class="icon-btn">
            <i class="fa-solid fa-arrow-left"></i>
        </a>
        <div class="lang-btn">
            <i class="fa-solid fa-globe"></i>
        </div>
    </div>
    <div class="website-name">WEBSITE NAME</div>
</header>

<main>
    <div class="profile-card">

        <h2 class="user-name">${user.firstName}</h2>

        <div class="info-container">
            <div class="info-row">
                <span class="info-label">Email:</span>
                <span class="info-value">${user.email}</span>
            </div>
        </div>

        <!-- Change Password (unchanged logic) -->
        <div class="profile-section">
            <h3 class="section-title">Change Password</h3>
            <form method="post" action="/admin/update-password">
                <input type="password" name="newPassword" required>
                <button type="submit" class="btn">Change Password</button>
            </form>
        </div>


            <div class="profile-section">
                <h3 class="section-title">Study Focus</h3>
                <form id="changeFocusForm" method="post" action="/admin/update-focus">

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
                    if (!confirm("Are you sure you want to change your subject focus?")) {
                        e.preventDefault();
                    }
                });
            </script>

    </div>
</main>

</body>
</html>
