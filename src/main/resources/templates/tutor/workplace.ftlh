<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tutor Workplace - Name of the WebApp</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.7.2/js/all.min.js"></script>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Inter', sans-serif; }

        body {
            background-color: #f0f4f9;
            min-height: 100vh;
            display: flex;
            overflow-x: hidden;
            position: relative;
        }

        /* Sidebar */
        aside.sidebar {
            width: 280px;
            background-color: #113255;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 40px 0;
            position: fixed;
            height: 100vh;
            left: 0;
            top: 0;
            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;
            z-index: 100;
        }

        .sidebar-brand { padding: 0 30px; font-size: 18px; font-weight: 700; margin-bottom: 60px; }

        .nav-menu { list-style: none; flex-grow: 1; }
        .nav-item { padding: 15px 30px; font-size: 16px; font-weight: 500; margin-bottom: 10px; cursor: pointer; }
        .nav-item a { color: white; text-decoration: none; }
        .nav-item:hover { background-color: #8b6b45; border-radius: 10px; }

        .sidebar-footer { padding: 0 30px; margin-top: auto; }
        .logout-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            width: 100%;
        }

        /* Main Content */
        main.content {
            flex-grow: 1;
            margin-left: 280px;
            padding: 40px 60px;
            position: relative;
            max-width: 1200px;
        }

        /* Card container like student resources/profile page */
        .card {
            background-color: #ffffff;
            border-radius: 15px;
            padding: 40px 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        header.page-header {
            margin-bottom: 30px;
        }

        header.page-header h2 {
            font-size: 28px;
            font-weight: 800;
            margin-bottom: 10px;
            color: #000;
        }

        .create-resource-btn {
            display: inline-block;
            margin-bottom: 20px;
            background-color: #fbc02d;
            color: #000;
            padding: 12px 25px;
            border-radius: 30px;
            font-weight: 700;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .create-resource-btn:hover { background-color: #e0a95f; }

        /* Table inside card */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
            font-size: 16px;
            border-bottom: 1px solid #eee;
        }

        th {
            font-weight: 700;
            color: #333;
            background-color: transparent;
        }

        td a { color: #007bff; text-decoration: none; }
        td a:hover { text-decoration: underline; }

        .delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 30px;
            cursor: pointer;
            font-weight: 600;
        }

        @media (max-width: 1024px) {
            main.content { margin-left: 0; padding: 20px; }
            aside.sidebar { display: none; }
        }
    </style>
</head>
<body>

<aside class="sidebar">
    <div class="sidebar-brand">Website Name</div>
    <ul class="nav-menu">
        <li class="nav-item"><a href="/tutor/analytics">View Analytics</a></li>
    </ul>
    <div class="sidebar-footer">
        <form action="/logout" method="post">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
        <a href="/profile" class="profile-link">Profile</a>
    </div>
</aside>

<main class="content">
    <header class="page-header">
        <h2>Welcome, ${tutorName}!</h2>
        <h2>Resources</h2>
        <a href="/tutor/resources/new" class="create-resource-btn">Create Resource</a>
    </header>

    <br>
    <div class="card">
<#--        <header class="page-header">-->
<#--            <h2>Welcome, ${tutorName}!</h2>-->
<#--            <h2>Resources</h2>-->
<#--            <a href="/tutor/resources/new" class="create-resource-btn">Create Resource</a>-->
<#--        </header>-->

        <#if resources?? && (resources?size > 0)>
            <table>
                <tr>
                    <th>Resource Name</th>
                    <th>Number of Articles</th>
                    <th>Actions</th>
                    <th>Deleted</th>
                </tr>
                <#list resources as resource>
                    <tr>
                        <td>${resource.topicName!'-'}</td>
                        <td>
                            <#if resource.articles?? && (resource.articles?size > 0)>
                                ${resource.articles?size}
                            <#else>0</#if>
                        </td>
                        <td>
                            <a href="/tutor/resources/${resource.id}/articles">View Articles</a>
                        </td>
                        <td>
                            <form action="/tutor/resources/${resource.id}/delete" method="post" style="display:inline;">
                                <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this resource?');">
                                    Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                </#list>
            </table>
        <#else>
            <p>No resources found yet. <a href="/tutor/resources/new">Create one now</a>.</p>
        </#if>
    </div>
</main>

</body>
</html>
