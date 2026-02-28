<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>

    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>

    <style>
        body, html {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100%;
            background-color: #f0f4f9;
            overflow-x: hidden;
        }

        /* Background Bokeh */
        .bokeh-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
            pointer-events: none;
        }

        .bokeh {
            position: absolute;
            border-radius: 50%;
            filter: blur(20px);
            opacity: 0.4;
        }

        .bokeh-1 { width: 60px; height: 60px; background-color: #9b86bd; top: 45%; left: 5%; }
        .bokeh-2 { width: 40px; height: 40px; background-color: #88c488; top: 60%; left: 10%; }
        .bokeh-3 { width: 30px; height: 30px; background-color: #f4d03f; top: 75%; left: 15%; }
        .bokeh-4 { width: 35px; height: 35px; background-color: #5d8aa8; top: 85%; left: 18%; }
        .bokeh-5 { width: 45px; height: 45px; background-color: #f4d03f; top: 40%; right: 15%; }
        .bokeh-6 { width: 30px; height: 30px; background-color: #5d8aa8; top: 52%; right: 12%; }
        .bokeh-7 { width: 70px; height: 70px; background-color: #e74c3c; top: 70%; right: 8%; }

        /* Header */
        header {
            background-color: #f1b981;
            height: 320px;
            width: 100%;
            border-bottom-left-radius: 40px;
            border-bottom-right-radius: 40px;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 25px;
        }

        .header-top {
            width: 95%;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .icon-btn {
            background: none;
            border: none;
            font-size: 24px;
            cursor: pointer;
            color: #333;
        }

        .lang-btn {
            background: white;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .website-name {
            font-size: 30px;
            font-weight: 800;
            margin-top: 25px;
        }

        /* Profile Card */
        .profile-card {
            background-color: white;
            width: 90%;
            max-width: 800px;
            margin: -160px auto 50px auto;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
            padding: 45px 60px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .user-name {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 6px;
        }

        .school-name {
            font-size: 14px;
            color: #666;
            margin-bottom: 50px;
        }

        .info-container {
            width: 100%;
            max-width: 600px;
            margin-bottom: 60px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 22px;
            font-size: 16px;
        }

        .info-label {
            font-weight: 700;
        }

        .info-value {
            text-align: right;
            color: #333;
        }

        .button-container {
            width: 100%;
            max-width: 600px;
            display: flex;
            justify-content: space-between;
            gap: 20px;
        }

        .btn {
            background-color: #123c5e;
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 30px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            min-width: 180px;
        }

        .btn.secondary {
            background-color: #6c757d;
        }

        .btn:hover {
            opacity: 0.9;
        }

        @media (max-width: 600px) {
            .profile-card {
                padding: 30px 20px;
            }

            .button-container {
                flex-direction: column;
                align-items: center;
            }

            .btn {
                width: 100%;
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
        <a href="/dashboard" class="icon-btn">
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
        <p class="school-name">${user.school.name}</p>

        <div class="info-container">
            <div class="info-row">
                <span class="info-label">Email:</span>
                <span class="info-value">${user.email}</span>
            </div>

            <div class="info-row">
                <span class="info-label">Grade:</span>
                <span class="info-value">${user.examLevel}</span>
            </div>

            <div class="info-row">
                <span class="info-label">Focus Areas:</span>
                <span class="info-value">
                    <#list user.preferredSubjects as focus>
                        ${focus}<#if focus_has_next>, </#if>
                    </#list>
                </span>
            </div>
        </div>

        <div class="button-container">
            <a href="/student/edit">
                <button class="btn">Edit Profile</button>
            </a>

            <a href="/dashboard">
                <button class="btn secondary">Go to Dashboard</button>
            </a>
        </div>

    </div>
</main>

</body>
</html>
